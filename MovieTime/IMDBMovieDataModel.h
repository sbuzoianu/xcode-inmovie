//
//  IMDBMovieDataModel.h
//  MovieTime
//
//  Created by Buzoianu Stefan on 30/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMDBMovieDataModel : NSObject

@property (strong, nonatomic) NSString *idIMDB;
@property (strong, nonatomic) NSString *urlIMDB;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *originalTitle;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSDictionary *directors;
@property (strong, nonatomic) NSDictionary *writers;
@property (strong, nonatomic) NSString *runtime;
@property (strong, nonatomic) NSString *urlPoster;
@property (strong, nonatomic) NSDictionary *countries;
@property (strong, nonatomic) NSDictionary *languages;
@property (strong, nonatomic) NSDictionary *genres;
@property (strong, nonatomic) NSString *plot;
@property (strong, nonatomic) NSString *simplePlot;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *metascore;
@property (strong, nonatomic) NSDictionary *filmingLocations;
@property (strong, nonatomic) NSDictionary *keywords;
@property (strong, nonatomic) NSDictionary *quotes;
@property (strong, nonatomic) NSString *rated;
@property (strong, nonatomic) NSDictionary *votes;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSDictionary *trailer;
@property (strong, nonatomic) NSDictionary *actors;

- (void) addActorsProperty:(NSDictionary *)actors;

@end
