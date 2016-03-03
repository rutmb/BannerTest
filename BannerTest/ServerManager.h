//
//  ServerManager.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+(ServerManager*)sharedManager;

- (void)getBannersFromServer:(BOOL)fromServer
                   onSuccess:(void (^) (NSDictionary* banners))success
                   onFailure:(void (^) (NSError* error, NSInteger statusCode))failure;

@end
