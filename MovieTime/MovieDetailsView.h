//
//  MovieDetailsView.h
//  InMovies
//
//  Created by Marius Ilie on 06/09/2016.
//  Copyright © 2016 Marius Ilie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsController.h"
#import "IMDBMovieDataModel.h"

@interface MovieDetailsView : UIView

@property (nonatomic, strong) MovieDetailsController *controller;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *trailerCalled;

- (void)setNavigationBarButtons;
- (void)initScrollView;

- (void)populateScrollViewWithMoviesFromList;

@end
