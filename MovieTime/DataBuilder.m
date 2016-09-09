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
                    NSString *removedVal = @"_V1_";
                    
                    NSRange range = [urlPoster rangeOfString:@"_V1_"];
                    if(range.location == NSNotFound)
                    {
                        range = [urlPoster rangeOfString:@"_V1._"];
                        removedVal = @"_V1._";
                        if(range.location == NSNotFound)
                            range = (NSRange){0, [urlPoster length]};
                    }
                    
                    NSString *newPosterUrl = [NSString stringWithFormat:@"%@%@UY230_.jpg", [urlPoster substringToIndex:range.location], removedVal];
                
                    [movieObj setValue:newPosterUrl forKey:@"urlPoster"];
                }
            } @catch (NSError *err) {
                NSLog(@"DataBuilder ERROR: %@", [err localizedDescription]);
            }
            
            if([[movieResult objectForKey:@"trailer"] valueForKey:@"videoURL"]!=nil)
            {
                NSString *urlTrailer = [[movieResult objectForKey:@"trailer"] valueForKey:@"videoURL"];
                
                urlTrailer = [urlTrailer stringByReplacingOccurrencesOfString:@"www.imdb.comVIDEO" withString:@"m.imdb.com/video"];
                
                [movieObj setValue:urlTrailer forKey:@"trailerURL"];
            }
            
            [movies addObject:movieObj];
        }
    }
    
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
