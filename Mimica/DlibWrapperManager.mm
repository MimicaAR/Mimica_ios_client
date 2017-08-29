//
//  DlibWrapperManager.mm
//  Mimica
//
//  Created by Gleb Linnik on 26.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing.h>
#include <dlib/image_io.h>

@interface DlibWrapperManager : NSObject

+ (dlib::array2d<dlib::bgr_pixel>)convertSampleBuffer:(CMSampleBufferRef) sampleBuffer;
+ (void)copyDlibVector:(dlib::array2d<dlib::bgr_pixel>)image toSampleBuffer:(CMSampleBufferRef) sampleBuffer;
+ (std::vector<dlib::rectangle>)convertCGRectValueArray:(NSArray<NSValue *> *)rects;

@end

@implementation DlibWrapperManager

+ (dlib::array2d<dlib::bgr_pixel> *)convertSampleBuffer:(CMSampleBufferRef) sampleBuffer{
	
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
	CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
	return &img;
}

+ (void)copyDlibVector:(dlib::array2d<dlib::bgr_pixel>)image toSampleBuffer:(CMSampleBufferRef) sampleBuffer{
	image.reset();
	size_t width = image.nc();
	size_t height = image.nr();
	size_t rowBytes = image.width_step();

	CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CVPixelBufferLockBaseAddress(imageBuffer, 0);
	
	unsigned char *baseBuffer = (unsigned char *) CVPixelBufferGetBaseAddress(imageBuffer);


	for (size_t yy = 0; yy < height; ++yy) {
		unsigned char *row = baseBuffer + (rowBytes * yy);
		for (size_t xx = 0; xx < width; ++xx) {
			image.move_next();
			const dlib::bgr_pixel& pixel = image.element();
			
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
