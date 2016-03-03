//
//  SaveLoadSettings.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "SaveLoadSettings.h"

@implementation SaveLoadSettings

#pragma mark - Save and Load

+ (void) saveSettings: (NSNumber*) numberOfSections andCurrentKey: (NSString*) currentKey  {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:[numberOfSections intValue] forKey:kSettingsNumberOfSections];
    [userDefaults setObject:currentKey forKey:kSettingsCurrentKey];
    
    [userDefaults synchronize];

}

+ (NSArray*) loadSettings: (NSNumber*) numberOfSections andCurrentKey: (NSString*) currentKey {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber* tempNumber = [NSNumber numberWithInteger:[userDefaults integerForKey:kSettingsNumberOfSections]];
    
    numberOfSections = tempNumber;
    currentKey = [userDefaults objectForKey:kSettingsCurrentKey];
    
    if (!numberOfSections | !currentKey) {
        
        numberOfSections = @4;
        currentKey = @"";
    }
    
    return [NSArray arrayWithObjects:numberOfSections, currentKey, nil];
    
}


@end
