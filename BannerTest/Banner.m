//
//  Banner.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "Banner.h"

@implementation Banner

- (id) initWithDictionary: (NSDictionary*) responseObject {
    self = [super init];
    if (self) {
        self.id =  [responseObject objectForKey:@"id"];
        self.type = [responseObject objectForKey:@"$type"];
    }
    return self;
}

+ (NSString *)primaryKey {
    return @"id";
}

@end
