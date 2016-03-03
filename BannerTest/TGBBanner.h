//
//  TGBBanner.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "Banner.h"

@interface TGBBanner : Banner

@property NSString* clickUrl;
@property NSString* text;
@property NSString* name;

@end

RLM_ARRAY_TYPE(TGBBanner)
