//
//  MovieDetailsController.h
//  InMovies
//
//  Created by Buzoianu Stefan on 06/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMDBMovieDataModel.h"

@interface MovieDetailsController : UIViewController

@property (nonatomic, strong) IMDBMovieDataModel *params;
@property (nonatomic, strong) UIImage *transferImage;

@end
