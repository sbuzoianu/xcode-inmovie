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
        
        if([movieResult objectForKey:@"title"] != nil)
        {
            for (NSString *key in movieResult)
                if ([movieObj respondsToSelector:NSSelectorFromString(key)])
                    [movieObj setValue:[movieResult valueForKey:key] forKey:key];
            
            @try
            {
                if([movieResult objectForKey:@"urlPoster"]!=nil)
                {
                    NSString *urlPoster = [movieObj valueForKey:@"urlPoster"];
                    
                    NSRange range = [urlPoster rangeOfString:@"_V1_"];
                    if(range.location == NSNotFound)
                    {
                        range = [urlPoster rangeOfString:@"_V1._"];
                        if(range.location == NSNotFound)
                            range = (NSRange){0, [urlPoster length]};
                    }
                    
                    NSString *newPosterUrl = [NSString stringWithFormat:@"%@.jpg", [urlPoster substringToIndex:range.location]];
                
                    [movieObj setValue:newPosterUrl forKey:@"urlPoster"];
                }
            } @catch (NSError *err) {
                NSLog(@"DataBuilder ERROR: %@", [err localizedDescription]);
            }
            
            [movies addObject:movieObj];
        }
    }
    
    [movies sortUsingComparator:^(id obj1, id obj2) {
        NSString *obj1FirstYear = @"0";
        NSString *obj2FirstYear = @"0";
        
        @try {
            obj1FirstYear = [[obj1 valueForKey:@"year"] substringToIndex: 4];
        } @catch (NSException *exception) {
            obj1FirstYear = @"0";
        }
        
        @try {
            obj2FirstYear = [[obj2 valueForKey:@"year"] substringToIndex: 4];
        } @catch (NSException *exception) {
            obj2FirstYear = @"0";
        }
        
        NSString *obj1Year = @"0";
        NSString *obj2Year = @"0";
        
        @try {
            obj1Year = [[obj1 valueForKey:@"year"] substringFromIndex: [[obj1 valueForKey:@"year"] length] - 4];
        } @catch (NSException *exception) {
            obj1Year = @"0";
        }
        
        @try {
            obj2Year = [[obj2 valueForKey:@"year"] substringFromIndex: [[obj2 valueForKey:@"year"] length] - 4];
        } @catch (NSException *exception) {
            obj2Year = @"0";
        }
        
        // compare years
        if ([obj1Year integerValue] > [obj2Year integerValue] || [obj1FirstYear integerValue] > [obj1Year integerValue] || [obj1Year  isEqual: @"0"])
            return (NSComparisonResult)NSOrderedAscending;
        else return (NSComparisonResult)NSOrderedDescending;
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
