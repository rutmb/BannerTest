//
//  OdnoklassnikiBanner.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "OdnoklassnikiBanner.h"

@implementation OdnoklassnikiBanner

- (id) initWithDictionary: (NSDictionary*) responseObject {
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.title = [responseObject objectForKey:@"title"];
        self.text = [responseObject objectForKey:@"text"];
        self.name = [responseObject objectForKey:@"name"];
    }
    return self;
}

@end
