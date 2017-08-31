//
//  DlibWrapperManager.h
//  Mimica
//
//  Created by Gleb Linnik on 24.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@interface DlibWrapperManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray<NSValue *> *)findFaceLandmarksInSampleBuffer:(CMSampleBufferRef)sampleBuffer inRect:(NSValue *)rect;

@end
