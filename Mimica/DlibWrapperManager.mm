//
//  DlibWrapperManager.mm
//  Mimica
//
//  Created by Gleb Linnik on 24.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

#import "DlibWrapperManager.h"
#import <UIKit/UIKit.h>

#include <dlib/image_processing.h>
#include <dlib/image_io.h>

@interface DlibWrapperManager ()

+ (std::vector<dlib::rectangle>)convertCGRectValueArray:(NSArray<NSValue *> *)rects;

@end

@implementation DlibWrapperManager {
	dlib::shape_predictor sp;
}


- (id)init {
	self = [super init];
	if (self) {
		[self prepare];
	}
	return self;
}

+ (instancetype)sharedInstance {
	static dispatch_once_t token = 0;
	__strong static DlibWrapperManager *sharedObject = nil;
	// executes a block object once and only once for the lifetime of an application
	dispatch_once(&token, ^{
		sharedObject = [[self alloc] init];
	});
	return sharedObject;
}

- (void)prepare {
	NSString *modelFileName = [[NSBundle mainBundle] pathForResource:@"shape_predictor_68_face_landmarks" ofType:@"dat"];
	std::string modelFileNameCString = [modelFileName UTF8String];
	// TODO: Implement this asyncronasly
	dlib::deserialize(modelFileNameCString) >> sp;
	// FIXME: test this stuff for memory leaks (cpp object destruction)
}

- (NSArray<NSValue *> *)findFaceLandmarksInSampleBuffer:(CMSampleBufferRef)sampleBuffer inRect:(NSValue *)rect {
	
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
	dlib::rectangle convertedRectangle = [DlibWrapperManager convertCGRectValue:rect];
	
	dlib::full_object_detection shape = sp(img, convertedRectangle);
	
	NSMutableArray <NSValue *> *faceLandmarks = [[NSMutableArray alloc] init];
	
	for (unsigned long k = 0; k < shape.num_parts(); k++) {
		dlib::point point = shape.part(k);
		[faceLandmarks addObject:[DlibWrapperManager convertPoint:point]];
//		draw_solid_circle(img, p, 3, dlib::rgb_pixel(0, 255, 255));
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
	return faceLandmarks;
}

+ (std::vector<dlib::rectangle>)convertCGRectValueArray:(NSArray<NSValue *> *)rects {
	std::vector<dlib::rectangle> myConvertedRects;
	for (NSValue *rectValue in rects) {
		myConvertedRects.push_back([self convertCGRectValue: rectValue]);
	}
	return myConvertedRects;
}
+ (dlib::rectangle)convertCGRectValue:(NSValue *)rect {
	CGRect _rect = [rect CGRectValue];
	long left = _rect.origin.x;
	long top = _rect.origin.y;
	long right = left + _rect.size.width;
	long bottom = top + _rect.size.height;
	dlib::rectangle dlibRect(left, top, right, bottom);
	return dlibRect;
}

+ (NSArray<NSValue *> *)convertPointsVector:(std::vector<dlib::point>)points {
	NSMutableArray<NSValue *> *convertedRects = [[NSMutableArray alloc] init];
	for (size_t i = 0; i < points.size(); ++i) {
		[convertedRects addObject:[self convertPoint:points[i]]];
	}
	return convertedRects;
}
+ (NSValue *)convertPoint:(dlib::point)point {
	CGFloat x = point.x();
	CGFloat y = point.y();
	return [NSValue valueWithCGPoint: CGPointMake(x, y)];
}

@end
