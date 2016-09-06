//
//  IMDBManager.m
//  MovieTime
//
//  Created by Buzoianu Stefan on 01/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "IMDBManager.h"
#import "DataBuilder.h"

@implementation IMDBManager

- (void)fetchDatasByTitle:(NSString *)title
{
    [self.search searchDatasByTitle:title];
}

- (void)fetchActorsByMovie:(IMDBMovieDataModel *)movie
{
    [self.search loadActorsPropertyByMovie:movie];
}

#pragma mark - IMDBSearchDelegate

- (void)receivedJSONWithData:(NSData *)jsonObject
{
    NSError *error = nil;
    NSArray *movies = [DataBuilder parseJSONFromData:jsonObject error:&error];
    
    if (error != nil)
        [self.delegate fetchingJSONFailedWithError:error];
    else [self.delegate didReceiveMovies:movies];
}

- (void)receivedActorsJSONWithData:(NSData *)jsonObject forMovie:(IMDBMovieDataModel *)movie
{
    NSError *error = nil;
    NSDictionary *actors = [DataBuilder parseActorJSONFromData:jsonObject error:&error];
    
    if (error != nil)
        [self.delegate fetchingJSONFailedWithError:error];
    else [self.delegate didReceiveActorsProperty:actors forMovie:movie];
}

- (void)fetchingJSONFailedWithError:(NSError *)error
{
    [self.delegate fetchingJSONFailedWithError:error];
}

+ (int)getIndexMovieByimdbID:(NSString *)imdbID fromArray:(NSArray *)moviesArray
{
    int index = 0;
    int returnIndex = -1;
    for(IMDBMovieDataModel *movie in moviesArray)
    {
        if([movie valueForKey:@"idIMDB"] == imdbID)
            returnIndex = index;
        
        index++;
    }
    
    return returnIndex;
}

@end
