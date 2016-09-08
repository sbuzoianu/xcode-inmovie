//
//  MovieDetailsView.m
//  InMovies
//
//  Created by Marius Ilie on 06/09/2016.
//  Copyright © 2016 Marius Ilie. All rights reserved.
//

#import "MovieDetailsView.h"

@implementation MovieDetailsView

- (void)setNavigationBarButtons
{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    
    [self.controller.navigationItem setRightBarButtonItem:saveButton];
}

- (void)initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.scrollView = scrollView;
    
    [self.controller.view addSubview:self.scrollView];
}

- (void)populateScrollViewWithMovie:(IMDBMovieDataModel *)params withImage:(UIImage *)image
{
    // Prepare values
    
    long statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    long navBarHeight = self.controller.navigationController.navigationBar.frame.size.height+statusBarHeight;
    long frameWidth = self.scrollView.frame.size.width;
    long borderWidth = 1;
    
    //MARK: SCROLL_VIEW & BG
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(-borderWidth, -navBarHeight-borderWidth, frameWidth+borderWidth, 250+navBarHeight+borderWidth*2)];
    header.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, header.frame.size.height)];
    
    backgroundImage.image = image;
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundImage setClipsToBounds:YES];
    
    CGRect frame = CGRectMake(0, navBarHeight, frameWidth, backgroundImage.frame.size.height - navBarHeight);
    [self setBlurEffect:backgroundImage withFrame:frame];
    
    header.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    header.layer.borderWidth = borderWidth;
    header.layer.shadowColor = [UIColor blackColor].CGColor;
    header.layer.shadowOffset = CGSizeMake(0, 2);
    header.layer.shadowOpacity = 0.15;
    
    //MARK: COVER_IMG1
    
    UIImageView *moviesList = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, header.frame.size.height)];
    
    UIImageView *coverImage = [[UIImageView alloc] initWithFrame:CGRectMake((frameWidth-155)/2, navBarHeight+20, 155, backgroundImage.frame.size.height - 40 - navBarHeight)];
    coverImage.image = image;
    coverImage.contentMode = UIViewContentModeScaleAspectFill;
    [coverImage setClipsToBounds:YES];
    
    coverImage.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor;
    coverImage.layer.borderWidth = borderWidth;
    coverImage.layer.shadowColor = [UIColor blackColor].CGColor;
    coverImage.layer.shadowOffset = CGSizeMake(0, 4);
    coverImage.layer.shadowOpacity = 0.4;
    
    //MARK: COVER_IMG2
    
    UIImageView *coverImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(coverImage.frame.origin.x+coverImage.frame.size.width+20, navBarHeight+20, 155, backgroundImage.frame.size.height - 40 - navBarHeight)];
    coverImage2.image = image;
    coverImage2.contentMode = UIViewContentModeScaleAspectFill;
    [coverImage2 setClipsToBounds:YES];
    
    coverImage2.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor;
    coverImage2.layer.borderWidth = borderWidth;
    coverImage2.alpha = 0.55f;
    
    //MARK: ADD SUBVIEWS
    
    [moviesList addSubview:coverImage];
    [moviesList addSubview:coverImage2];
    
    [backgroundImage addSubview:moviesList];
    [header addSubview:backgroundImage];
    [self.scrollView addSubview:header];
    
    //self.scrollView.contentSize = header.frame.size;
}

- (void)setBlurEffect:(UIImageView *)backgroundImage withFrame:(CGRect)CGRectFrame
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectFrame;
    blurEffectView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.73];
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [backgroundImage addSubview:blurEffectView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
