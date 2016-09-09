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

- (void)populateScrollViewWithMoviesFromList
{
    for(UIView *view in self.scrollView.subviews)
        [view removeFromSuperview];
    
    // Prepare values
    
    long statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    long navBarHeight = self.controller.navigationController.navigationBar.frame.size.height+statusBarHeight;
    long frameWidth = [UIScreen mainScreen].bounds.size.width;
    long borderWidth = 1;
    
    //MARK:- HEADER VIEW
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(-borderWidth, -navBarHeight-borderWidth, frameWidth+borderWidth*2, 250+navBarHeight+borderWidth*2)];
    
    header.backgroundColor = [UIColor blackColor];
    header.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    header.layer.borderWidth = borderWidth;
    header.layer.shadowColor = [UIColor blackColor].CGColor;
    header.layer.shadowOffset = CGSizeMake(0, 2);
    header.layer.shadowOpacity = 0.15;
    
    UIScrollView *backgroundZone = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frameWidth+borderWidth, header.frame.size.height)];
    
    UIScrollView *moviesList = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, header.frame.size.height)];
    
    long firstCoverXPos = (frameWidth-155)/2;
    long index = 0;
    for(IMDBMovieDataModel *model in self.controller.params)
    {
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*index, 0, frameWidth, header.frame.size.height)];
        
        backgroundImage.image = [model valueForKey:@"posterImg"];
        backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        [backgroundImage setClipsToBounds:YES];
        
        long coverXPos = firstCoverXPos+(175*index);
        long coverYPos = navBarHeight+20;
        long coverHeight = backgroundZone.frame.size.height - 40 - navBarHeight;
        
        UIView *coverImgView = [[UIView alloc] initWithFrame:CGRectMake(coverXPos, coverYPos, 155, coverHeight)];
        
        long coverImgViewXPos = 0;
        long coverImgViewYPos = 0;
        long coverImgViewWidth = coverImgView.frame.size.width;
        long coverImgViewHeight = coverImgView.frame.size.height;
        
        if(index != self.controller.startId)
        {
            coverImgViewXPos = 6.5f;
            coverImgViewYPos = 10;
            coverImgViewHeight -= 20;
            coverImgViewWidth = 142;
        }
        
        UIImageView *coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(coverImgViewXPos, coverImgViewYPos, coverImgViewWidth, coverImgViewHeight)];
        
        coverImage.image = [model valueForKey:@"posterImg"];
        coverImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [coverImage setClipsToBounds:YES];
        
        CGRect frame = CGRectMake(0, navBarHeight, frameWidth, backgroundZone.frame.size.height - navBarHeight);
        [self setBlurEffect:backgroundImage withFrame:frame andWhite:0.6f];
        
        if(index != self.controller.startId)
        {
            coverImgView.alpha = 0.75f;
            coverImgView.layer.shadowColor = [UIColor blackColor].CGColor;
            coverImgView.layer.shadowOffset = CGSizeMake(-1, 2);
            coverImgView.layer.shadowOpacity = 0.4;

            coverImage.image = [model valueForKey:@"grayPosterImg"];
        } else {
            coverImgView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f].CGColor;
            coverImgView.layer.borderWidth = borderWidth;
            coverImgView.layer.shadowColor = [UIColor blackColor].CGColor;
            coverImgView.layer.shadowOffset = CGSizeMake(-2, 5);
            coverImgView.layer.shadowOpacity = 0.4;
        }
        
        [coverImgView addSubview:coverImage];
        [moviesList addSubview:coverImgView];
        
        [backgroundZone addSubview:backgroundImage];
        
        index++;
    }
    
    [backgroundZone setContentSize:CGSizeMake(frameWidth*index, header.frame.size.height)];
    [moviesList setContentSize:CGSizeMake(index*175+firstCoverXPos, backgroundZone.frame.size.height - 40 - navBarHeight)];
    
    [backgroundZone setContentOffset:CGPointMake(self.controller.startId*frameWidth, 0) animated:NO];
    [moviesList setContentOffset:CGPointMake(self.controller.startId*175, 0) animated:NO];
    
    [header addSubview:backgroundZone];
    [header addSubview:moviesList];
    
    [self.scrollView addSubview:header];
    
    
    //MARK:- TITLE
    
    long lastContentHeight = backgroundZone.frame.size.height-navBarHeight-borderWidth+30;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(30, lastContentHeight, frameWidth-60, 22)];
    title.text = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"title"];
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    title.textColor = [UIColor grayColor];
    
    CGRect frame = title.frame;
    [title sizeToFit];
    frame.size.height = title.frame.size.height;
    title.frame = frame;
    
    lastContentHeight += title.frame.size.height + 12;
    
    [self.scrollView addSubview:title];
    
    
    //MARK:- DESCRIPTION
    
    UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(20, lastContentHeight, frameWidth-40, 22)];
    descView.backgroundColor = [UIColor colorWithRed:0.972f green:0.972f blue:0.972f alpha:1.0f];
    descView.layer.borderWidth = borderWidth;
    descView.layer.borderColor = [UIColor colorWithRed:0.955f green:0.955f blue:0.955f alpha:1.0f].CGColor;
    descView.layer.cornerRadius = 3;
    
    UILabel *descPlot = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, descView.frame.size.width-30, 22)];
    descPlot.text = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"simplePlot"];
    descPlot.numberOfLines = 0;
    descPlot.textAlignment = NSTextAlignmentCenter;
    descPlot.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    descPlot.textColor = [UIColor grayColor];
    
    frame = descPlot.frame;
    [descPlot sizeToFit];
    frame.size.height = descPlot.frame.size.height;
    descPlot.frame = frame;
    
    descView.frame = CGRectMake(25, lastContentHeight, frameWidth-50, descPlot.frame.size.height+20);
    
    lastContentHeight += descPlot.frame.size.height + 40;
    
    [descView addSubview:descPlot];
    [self.scrollView addSubview:descView];
    
    
    //MARK:- INFOS
    
    UIView *infosView = [[UIView alloc] initWithFrame:CGRectMake(25, lastContentHeight, frameWidth-50, 80)];
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    UIView *votesView = [[UIView alloc] initWithFrame:CGRectMake(typeView.frame.origin.x+typeView.frame.size.width, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    UIView *trailerView = [[UIView alloc] initWithFrame:CGRectMake(votesView.frame.origin.x+votesView.frame.size.width, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    
    //MARK: TypeView
    
    UIImageView *typeImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(typeView.frame.size.width/2-16, 0, 32, 32)];
    
    typeImageView.image = [UIImage imageNamed:@"video_paylist_filled-50"];
    typeImageView.image = [typeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    typeImageView.tintColor = [UIColor lightGrayColor];
    
    UILabel *typeText = [[UILabel alloc] initWithFrame:CGRectMake(0, typeView.frame.size.height-33, typeView.frame.size.width, 20)];
    
    typeText.text = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"type"];
    typeText.numberOfLines = 0;
    typeText.textAlignment = NSTextAlignmentCenter;
    typeText.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    typeText.textColor = [UIColor grayColor];
    
    [typeView addSubview:typeImageView];
    [typeView addSubview:typeText];
    
    [infosView addSubview:typeView];
    
    
    //MARK: VotesView
    
    UIImageView *votesImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(votesView.frame.size.width/2-16, 0, 32, 32)];
    
    votesImageView.image = [UIImage imageNamed:@"good_quality_filled-50"];
    votesImageView.image = [votesImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    votesImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    votesImageView.tintColor = [UIColor lightGrayColor];
    
    UILabel *votesText = [[UILabel alloc] initWithFrame:CGRectMake(0, votesView.frame.size.height-33, typeView.frame.size.width, 20)];
    
    votesText.text = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"votes"];
    if([votesText.text isEqual:@""] || votesText.text==nil)
        votesText.text = @"No votes";
        
    votesText.numberOfLines = 0;
    votesText.textAlignment = NSTextAlignmentCenter;
    votesText.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    votesText.textColor = [UIColor grayColor];
    
    [votesView addSubview:votesImageView];
    [votesView addSubview:votesText];
    
    [infosView addSubview:votesView];
    
    //MARK: TrailerView
    
    UIImageView *trailerImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(trailerView.frame.size.width/2-16, 0, 32, 32)];
    
    trailerImageView.image = [UIImage imageNamed:@"tv_show-50"];
    trailerImageView.image = [trailerImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    trailerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    trailerImageView.tintColor = [UIColor lightGrayColor];
    
    UILabel *trailerText = [[UILabel alloc] initWithFrame:CGRectMake(0, trailerView.frame.size.height-33, trailerView.frame.size.width, 20)];
    
    trailerText.text = @"Trailer";
    trailerText.numberOfLines = 0;
    trailerText.textAlignment = NSTextAlignmentCenter;
    trailerText.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    trailerText.textColor = [UIColor grayColor];
    
    UITapGestureRecognizer *tapOnTrailerView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTrailerView:)];
    [tapOnTrailerView setNumberOfTapsRequired:1];
    
    self.trailerCalled = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"trailerURL"];
    
    if(self.trailerCalled == nil)
        trailerText.text = @"No Trailer";
    
    [trailerView addSubview:trailerImageView];
    [trailerView addSubview:trailerText];
    
    [trailerView setUserInteractionEnabled:YES];
    [trailerView addGestureRecognizer:tapOnTrailerView];
    
    [infosView addSubview:trailerView];
    
    //MARK: FinalInfosView
    
    [self.scrollView addSubview:infosView];
    lastContentHeight += infosView.frame.size.height  + 15;

    self.scrollView.contentSize = CGSizeMake(frameWidth, lastContentHeight);
}

- (void)onTapTrailerView:(UIGestureRecognizer *)sender
{
    if(self.trailerCalled!=nil)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.trailerCalled]];
}

- (void)setBlurEffect:(UIView *)image withFrame:(CGRect)CGRectFrame andWhite:(long)white
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectFrame;
    blurEffectView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:white];
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [image addSubview:blurEffectView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
