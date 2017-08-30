//
//  DlibWrapperManager.mm
//  DisplayLiveSamples
//
//  Created by Luis Reisewitz on 16.05.16.
//  Copyright © 2016 ZweiGraf. All rights reserved.
//

#import "DlibWrapperManager.h"
#import <UIKit/UIKit.h>

#include <dlib/image_processing.h>
#include <dlib/image_io.h>

@interface DlibWrapperManager ()

@property (assign) BOOL prepared;

+ (std::vector<dlib::rectangle>)convertCGRectValueArray:(NSArray<NSValue *> *)rects;

@end
@implementation DlibWrapperManager {
	dlib::shape_predictor sp;
}


- (instancetype)init {
	self = [super init];
	if (self) {
		_prepared = NO;
	}
	return self;
}

- (void)prepare {
	NSString *modelFileName = [[NSBundle mainBundle] pathForResource:@"shape_predictor_68_face_landmarks" ofType:@"dat"];
	std::string modelFileNameCString = [modelFileName UTF8String];
	
	dlib::deserialize(modelFileNameCString) >> sp;
	
	// FIXME: test this stuff for memory leaks (cpp object destruction)
	self.prepared = YES;
}

- (void)doWorkOnSampleBuffer:(CMSampleBufferRef)sampleBuffer inRects:(NSArray<NSValue *> *)rects {
	
	if (!self.prepared) {
		[self prepare];
	}
	
	dlib::array2d<dlib::bgr_pixel> img;
	
	// MARK: magic
	CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CVPixelBufferLockBaseAddress(imageBuffer, 0);
	
	size_t width = CVPixelBufferGetWidth(imageBuffer);
	size_t height = CVPixelBufferGetHeight(imageBuffer);
	size_t rowBytes = CVPixelBufferGetBytesPerRow(imageBuffer);
	
	unsigned char *baseBuffer = (unsigned char *) CVPixelBufferGetBaseAddress(imageBuffer);
	
	// set_size expects rows, cols format
	img.set_size(height, width);
	
	// copy samplebuffer image data into dlib image format
	img.reset();
	for (size_t yy = 0; yy < height; ++yy) {
		unsigned char *row = baseBuffer + (rowBytes * yy);
		for (size_t xx = 0; xx < width; ++xx) {
			unsigned char b = row[xx * 4];
			unsigned char g = row[(xx * 4) + 1];
			unsigned char r = row[(xx * 4) + 2];
			
			img.move_next();
			dlib::bgr_pixel& pixel = img.element();
			dlib::bgr_pixel newpixel(b, g, r);
			pixel = newpixel;
		}
	}
	
	// convert the face bounds list to dlib format
	std::vector<dlib::rectangle> convertedRectangles = [DlibWrapperManager convertCGRectValueArray:rects];
	
	// for every detected face
	for (unsigned long j = 0; j < convertedRectangles.size(); ++j) {
		dlib::rectangle oneFaceRect = convertedRectangles[j];
		
		// detect all landmarks
		dlib::full_object_detection shape = sp(img, oneFaceRect);
		
		// and draw them into the image (samplebuffer)
		for (unsigned long k = 0; k < shape.num_parts(); k++) {
			dlib::point p = shape.part(k);
			draw_solid_circle(img, p, 3, dlib::rgb_pixel(0, 255, 255));
		}
	}
	
	// copy dlib image data back into samplebuffer
	img.reset();
	for (size_t yy = 0; yy < height; ++yy) {
		unsigned char *row = baseBuffer + (rowBytes * yy);
		for (size_t xx = 0; xx < width; ++xx) {
			img.move_next();
			const dlib::bgr_pixel& pixel = img.element();
			
			row[xx * 4] = pixel.blue;
			row[(xx * 4) + 1] = pixel.green;
			row[(xx * 4) + 2] = pixel.red;
		}
	}
	
	CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
}

+ (std::vector<dlib::rectangle>)convertCGRectValueArray:(NSArray<NSValue *> *)rects {
	std::vector<dlib::rectangle> myConvertedRects;
	for (NSValue *rectValue in rects) {
		CGRect rect = [rectValue CGRectValue];
		long left = rect.origin.x;
		long top = rect.origin.y;
		long right = left + rect.size.width;
		long bottom = top + rect.size.height;
		dlib::rectangle dlibRect(left, top, right, bottom);
		
		myConvertedRects.push_back(dlibRect);
	}
	return myConvertedRects;
}

@end
