//
//  Banner.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <Realm/Realm.h>
#import "File.h"

@interface Banner : RLMObject

@property NSString* id;
@property NSString* type;
@property NSString* title;
@property File* file;

-(id)initWithDictionary: (NSDictionary*) responseObject;

@end

RLM_ARRAY_TYPE(Banner)
