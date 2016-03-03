//
//  SaveLoadSettings.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString *kSettingsNumberOfSections  = @"numberOfSections";
static  NSString *kSettingsCurrentKey        = @"currentKey";


@interface SaveLoadSettings : NSObject


+ (void) saveSettings: (NSNumber*) numberOfSections andCurrentKey: (NSString*) currentKey;
+ (NSArray*) loadSettings: (NSNumber*) numberOfSections andCurrentKey: (NSString*) currentKey;

@end
