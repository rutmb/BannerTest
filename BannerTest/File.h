//
//  RootFile.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <Realm/Realm.h>

@interface File : RLMObject

@property NSString* imageURL;

- (id)initWithDictionary: (NSDictionary*) responseObject;

@end

RLM_ARRAY_TYPE(File)

