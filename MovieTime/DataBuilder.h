//
//  DataBuilder.h
//  MovieTime
//
//  Created by Buzoianu Stefan on 31/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBuilder : NSObject

+ (NSArray *)parseJSONFromData:(NSData *)data error:(NSError **)error;
+ (NSDictionary *)parseActorJSONFromData:(NSData *)data error:(NSError **)error;

@end
