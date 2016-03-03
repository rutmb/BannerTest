//
//  HtmlImageFlashBanner.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "HtmlImageFlashBanner.h"

@implementation HtmlImageFlashBanner

- (id) initWithDictionary: (NSDictionary*) responseObject {
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.clickUrl = [responseObject objectForKey:@"clickUrl"];
        self.title = [responseObject objectForKey:@"tag"];
    }
    return self;
}

@end
