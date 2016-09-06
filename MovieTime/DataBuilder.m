//
//  DataBuilder.m
//  MovieTime
//
//  Created by Buzoianu Stefan on 31/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "DataBuilder.h"
#import "IMDBSearch.h"

@implementation DataBuilder

+ (NSArray *)parseJSONFromData:(NSData *)data error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (localError != nil)
    {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    NSArray *results = [[parsedObject valueForKey:@"data"] valueForKey:@"movies"];
    
    for (NSDictionary *movieResult in results)
    {
        IMDBMovieDataModel *movieObj = [[IMDBMovieDataModel alloc] init];
        
        if([movieResult objectForKey:@"title"] != nil && [movieResult objectForKey:@"year"] != nil && [movieResult objectForKey:@"urlPoster"] != nil)
        {
            for (NSString *key in movieResult)
                if ([movieObj respondsToSelector:NSSelectorFromString(key)])
                    [movieObj setValue:[movieResult valueForKey:key] forKey:key];
        
            [movies addObject:movieObj];
        }
    }
    
    [movies sortUsingComparator:^(id obj1, id obj2) {
        NSString *obj1FirstYear = [[obj1 valueForKey:@"year"] substringToIndex: 4];
        NSString *obj2FirstYear = [[obj2 valueForKey:@"year"] substringToIndex: 4];
        
        NSString *obj1Year = [[obj1 valueForKey:@"year"] substringFromIndex: [[obj1 valueForKey:@"year"] length] - 4];
        NSString *obj2Year = [[obj2 valueForKey:@"year"] substringFromIndex: [[obj2 valueForKey:@"year"] length] - 4];
        
        // compare years
        if ([obj1Year integerValue] > [obj2Year integerValue] || [obj1FirstYear integerValue] > [obj2FirstYear integerValue] || [obj1Year integerValue] > [obj2FirstYear integerValue] || [obj1FirstYear integerValue] > [obj2Year integerValue])
            return (NSComparisonResult)NSOrderedAscending;
        
        if ([obj1Year integerValue] < [obj2Year integerValue] || [obj1FirstYear integerValue] < [obj2FirstYear integerValue] || [obj1Year integerValue] < [obj2FirstYear integerValue] || [obj1FirstYear integerValue] < [obj2Year integerValue])
            return (NSComparisonResult)NSOrderedDescending;
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return movies;
}

+ (NSDictionary *)parseActorJSONFromData:(NSData *)data error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (localError != nil)
    {
        *error = localError;
        return nil;
    }
    
    NSDictionary *actors = [[[[parsedObject valueForKey:@"data"] valueForKey:@"movies"] objectAtIndex:0] valueForKey:@"actors"];
    
    return actors;
}

@end
