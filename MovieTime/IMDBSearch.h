//
//  IMDBMovies.h
//  MovieTime
//
//  Created by Buzoianu Stefan on 31/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDBMovieDataModel.h"

@protocol IMDBSearchDelegate;


@interface IMDBSearch : NSObject

@property (nonatomic, weak) id<IMDBSearchDelegate> delegate;

- (void)searchDatasByTitle:(NSString *)title;
- (void)loadActorsPropertyByMovie:(IMDBMovieDataModel *)movie;

@end
