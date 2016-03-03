//
//  TGBBanner.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "TGBBanner.h"

@implementation TGBBanner

- (id)initWithDictionary: (NSDictionary*) responseObject {
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.title = [responseObject objectForKey:@"title"];
        self.clickUrl = [responseObject objectForKey:@"clickUrl"];
        self.text = [responseObject objectForKey:@"text"];
        self.name = [responseObject objectForKey:@"name"];
    }
    return self;
}


@end
