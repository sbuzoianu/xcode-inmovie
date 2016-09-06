//
//  +IMDBManagerDelegate.h
//  MovieTime
//
//  Created by Buzoianu Stefan on 01/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDBMovieDataModel.h"

@protocol IMDBManagerDelegate <NSObject>

- (void)didReceiveMovies:(NSArray *)movies;
- (void)didReceiveActorsProperty:(NSDictionary *)actors forMovie:(IMDBMovieDataModel *)movie;
- (void)fetchingJSONFailedWithError:(NSError *)error;

@end
