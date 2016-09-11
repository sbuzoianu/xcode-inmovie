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

@property (nonatomic, weak) MovieDetailsController<UIScrollViewDelegate> *controller;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) NSString *trailerCalled;

- (void)setNavigationBarButtons;
- (void)initScrollView;

- (void)populateScrollViewWithMoviesFromList;
- (void)eventOnDidScrollMoviesList:(UIScrollView *)scrollView;

@end
