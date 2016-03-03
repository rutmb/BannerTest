//
//  OdnoklassnikiBanner.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "Banner.h"

@interface OdnoklassnikiBanner : Banner

@property NSString* text;
@property NSString* name;
@property NSString* logotypeURL;
@property File* fileLogoUrl;

@end

RLM_ARRAY_TYPE(OdnoklassnikiBanner)

