//
//  RootFile.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "File.h"

@implementation File

- (id) initWithDictionary: (NSDictionary*) responseObject {
    self = [super init];
    if (self) {
        self.imageURL = [responseObject objectForKey:@"url"];
    }
    return self;
}


@end
