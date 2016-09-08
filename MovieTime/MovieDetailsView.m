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
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, header.frame.size.height)];
    
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
    
    UIScrollView *moviesList = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, header.frame.size.height)];
    
    //MARK: COVER_IMG1
    
    UIView *coverImgView = [[UIView alloc] initWithFrame:CGRectMake((frameWidth-155)/2, navBarHeight+20, 155, backgroundImage.frame.size.height - 40 - navBarHeight)];
    
    UIImageView *coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, coverImgView.frame.size.width, coverImgView.frame.size.height)];
    
    coverImage.image = image;
    coverImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [coverImage setClipsToBounds:YES];
    
    coverImgView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f].CGColor;
    coverImgView.layer.borderWidth = borderWidth;
    coverImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    coverImgView.layer.shadowOffset = CGSizeMake(0, 4);
    coverImgView.layer.shadowOpacity = 0.4;
    
    [coverImgView addSubview:coverImage];
    [moviesList addSubview:coverImgView];
    
    //MARK: COVER_IMG2
    
    UIView *coverImgView2 = [[UIView alloc] initWithFrame:CGRectMake(coverImgView.frame.origin.x+coverImgView.frame.size.width+20, navBarHeight+20, 155, backgroundImage.frame.size.height - 40 - navBarHeight)];
    
    UIImageView *coverImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, coverImgView2.frame.size.width, coverImgView2.frame.size.height)];
    
    coverImage2.image = image;
    coverImage2.contentMode = UIViewContentModeScaleAspectFill;
    
    [coverImage2 setClipsToBounds:YES];
    
    coverImgView2.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f].CGColor;
    coverImgView2.layer.borderWidth = borderWidth;
    coverImgView2.alpha = 0.55f;
    
    [coverImgView2 addSubview:coverImage2];
    [moviesList addSubview:coverImgView2];
    
    //MARK: ADD SUBVIEWS
    
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
