//
//  ServerManager.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

#import "File.h"
#import "Banner.h"
#import "TGBBanner.h"
#import "OdnoklassnikiBanner.h"
#import "HtmlImageFlashBanner.h"

#import <Realm/Realm.h>

@interface ServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) NSDictionary* bannerDictionary;

@end


@implementation ServerManager

#pragma mark - Initialization

+ (ServerManager*) sharedManager {
    
    static ServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL* baseUrl = [NSURL URLWithString:@"http://hybrid.ru"];
        self.sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
    }
    return self;
}

#pragma mark - API methods

-(NSArray*)arrayFromResults:(RLMResults*)results {
    NSMutableArray* array = [NSMutableArray array];
    for (id obj in results) {
        [array addObject:obj];
    }
    return [array copy];
}

- (void)getBannersFromServer:(BOOL)fromServer
                   onSuccess:(void (^) (NSDictionary* banners))success
                   onFailure:(void (^) (NSError* error, NSInteger statusCode))failure {
    
   
    NSArray* tgbArray = [self arrayFromResults:[TGBBanner allObjects]];
    NSArray* odnoklArray = [self arrayFromResults:[OdnoklassnikiBanner allObjects]];
    NSArray* htmlArray = [self arrayFromResults:[HtmlImageFlashBanner allObjects]];
    NSArray* imageArray = nil;
    
    NSInteger allCount = tgbArray.count+odnoklArray.count+htmlArray.count;
    
    if(allCount>0 && !fromServer) {
        
        
        NSArray* tgbArray1 = [NSArray arrayWithArray:[self sortArray: tgbArray]];
        NSArray* htmlArray1 = [NSArray arrayWithArray:[self sortArray: htmlArray]];
        NSArray* imageArray1 = [NSArray arrayWithArray:[self sortArray: imageArray]];
        NSArray* odnoklArray1 = [NSArray arrayWithArray:[self sortArray: odnoklArray]];
        
        self.bannerDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 
                                 tgbArray1, @"TGBBanner",
                                 htmlArray1, @"Html5Banner",
                                 imageArray1, @"ImageOrFlashBanner",
                                 odnoklArray1, @"OdnoklassnikiBanner",
                                 nil];
        
        if (success) {
            success (self.bannerDictionary);
        }
        
        return;
    }
    
    [self.sessionManager GET:@"/ads.json"
                  parameters:nil
                     success:^(NSURLSessionTask *task, NSArray* responseObject) {
                         
                        NSMutableArray* tgbArray = [NSMutableArray array];
                        NSMutableArray* htmlArray = [NSMutableArray array];
                        NSMutableArray* imageArray = [NSMutableArray array];
                        NSMutableArray* odnoklArray = [NSMutableArray array];
                         
                        [[RLMRealm defaultRealm] transactionWithBlock:^{
                            
                            [[RLMRealm defaultRealm] deleteAllObjects];
                            
                            for (NSDictionary* dict in responseObject) {
                                
                                Banner* banner = nil;
                                
                                NSString* type = [dict objectForKey:@"$type"];
                                
                                if ([type isEqualToString:@"TGBBanner"]) {
                                    
                                    banner = [[TGBBanner alloc] initWithDictionary:dict];
                                    banner.file = [[File alloc] initWithDictionary:[dict objectForKey:@"file"]];
                                    [tgbArray addObject:banner];
                                }
                                
                                if ([type isEqualToString:@"Html5Banner"]) {
                                    
                                    banner = [[HtmlImageFlashBanner alloc] initWithDictionary:dict];
                                    banner.file = [[File alloc] initWithDictionary:dict[@"imagePreview"]];
                                    [htmlArray addObject:banner];
                                }
                                
                                if ([type isEqualToString:@"ImageOrFlashBanner"]) {
                                    
                                    banner = [[HtmlImageFlashBanner alloc] initWithDictionary:dict];
                                    banner.file = [[File alloc] initWithDictionary:dict[@"imagePreview"]];
                                    [imageArray addObject:banner];
                                    
                                }
                                
                                if ([type isEqualToString:@"OdnoklassnikiBanner"]) {
                                    banner = [[OdnoklassnikiBanner alloc] initWithDictionary:dict];
                                    banner.file = [[File alloc] initWithDictionary:dict[@"img1080x607"]];
                                    [(OdnoklassnikiBanner*)banner setFileLogoUrl:[[File alloc] initWithDictionary:dict[@"img100x100"]]];
                                    [odnoklArray addObject:banner];
                                }
                                
                                if(banner) {
                                    [[RLMRealm defaultRealm] addObject:banner];
                                }
                                
                            }
                            
                        }];
                         
                        NSArray* tgbArray1 = [NSArray arrayWithArray:[self sortArray: tgbArray]];
                        NSArray* htmlArray1 = [NSArray arrayWithArray:[self sortArray: htmlArray]];
                        NSArray* imageArray1 = [NSArray arrayWithArray:[self sortArray: imageArray]];
                        NSArray* odnoklArray1 = [NSArray arrayWithArray:[self sortArray: odnoklArray]];
                        
                        self.bannerDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                  
                                                  tgbArray1, @"TGBBanner",
                                                  htmlArray1, @"Html5Banner",
                                                  imageArray1, @"ImageOrFlashBanner",
                                                  odnoklArray1, @"OdnoklassnikiBanner",
                                                  nil];
                         
                        if (success) {
                            success (self.bannerDictionary);
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         NSLog(@"error = %@", [error localizedDescription]);

     }];
    
}

#pragma mark - Sort JSON data

- (NSArray*) sortArray: (NSArray*) array {
    
    
    NSArray* sortArray = [array sortedArrayUsingComparator:^NSComparisonResult(Banner* obj1, Banner* obj2) {
        
        NSComparisonResult result =  [obj1.title compare:obj2.title];
        
        if (result == NSOrderedSame) {
            
            result = [obj1.file.imageURL compare:obj2.file.imageURL];
        }
        
        return result;
    
    }];
    
    return sortArray;
}

@end