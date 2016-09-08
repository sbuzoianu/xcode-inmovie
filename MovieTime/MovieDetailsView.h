//
//  MovieDetailsView.h
//  InMovies
//
//  Created by Marius Ilie on 06/09/2016.
//  Copyright © 2016 Marius Ilie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMDBMovieDataModel.h"

@interface MovieDetailsView : UIView

@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)setNavigationBarButtons;
- (void)initScrollView;

- (void)populateScrollViewWithMovie:(IMDBMovieDataModel *)params withImage:(UIImage *)image;

@end
