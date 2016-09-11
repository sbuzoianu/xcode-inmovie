//
//  MovieDetailsView.m
//  InMovies
//
//  Created by Marius Ilie on 06/09/2016.
//  Copyright © 2016 Marius Ilie. All rights reserved.
//

#import "ImageGrayScale.h"

#import "MovieDetailsView.h"
#import "WebNavigatorController.h"

@interface MovieDetailsView (){
    long frameWidth;
    long navBarHeight;
    long borderWidth;
    
    UIImageView *fadingBg;
    UIScrollView *backgroundZone;
    UIScrollView *moviesList;
    UIView *movieEntireDetails;
}

@end

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
    navBarHeight = self.controller.navigationController.navigationBar.frame.size.height+statusBarHeight;
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    borderWidth = 1;
    
    //MARK:- HEADER VIEW
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(-borderWidth, -navBarHeight-borderWidth, frameWidth+borderWidth*2, 250+navBarHeight+borderWidth*2)];
    
    header.backgroundColor = [UIColor colorWithRed:0.219 green:0.219 blue:0.227 alpha:1];
    header.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    header.layer.borderWidth = borderWidth;
    header.layer.shadowColor = [UIColor blackColor].CGColor;
    header.layer.shadowOffset = CGSizeMake(0, 2);
    header.layer.shadowOpacity = 0.15;
    
    backgroundZone = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frameWidth+borderWidth, header.frame.size.height)];
    
    CGRect frame = CGRectMake(0, 0, frameWidth, backgroundZone.frame.size.height);
    fadingBg = [[UIImageView alloc] initWithFrame:frame];
    
    fadingBg.alpha = 0;
    fadingBg.contentMode = UIViewContentModeScaleAspectFill;
    [fadingBg setClipsToBounds:YES];
    
    UIView *blurBackground = [[UIView alloc] initWithFrame:frame];
    
    frame = CGRectMake(0, navBarHeight, frameWidth, backgroundZone.frame.size.height - navBarHeight);
    [self setBlurEffect:blurBackground withFrame:frame andWhite:0.6f];
    
    moviesList = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, header.frame.size.height)];
    
    long firstCoverXPos = ([[UIScreen mainScreen] bounds].size.width-148)/2;
    long index = 0;
    for(IMDBMovieDataModel *model in self.controller.params)
    {
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*index, 0, frameWidth, header.frame.size.height)];
        backgroundImage.tag = index+1;
        
        backgroundImage.image = [model valueForKey:@"posterImg"];
        backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        [backgroundImage setClipsToBounds:YES];
        
        long coverXPos = firstCoverXPos+(175*index);
        long coverYPos = navBarHeight+20;
        long coverHeight = backgroundZone.frame.size.height - 40 - navBarHeight;
        
        UIView *coverImgView = [[UIView alloc] initWithFrame:CGRectMake(coverXPos, coverYPos, 155, coverHeight)];
        coverImgView.tag = index+1;
        
        UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMovieTap:)];
        [onTap setNumberOfTapsRequired:1];
        
        [coverImgView setUserInteractionEnabled:YES];
        [coverImgView addGestureRecognizer:onTap];
        
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
        coverImage.tag = index+1;
        
        coverImage.image = [model valueForKey:@"posterImg"];
        coverImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [coverImage setClipsToBounds:YES];
        
        if(index != self.controller.startId)
        {
            [self unselectMovie:coverImgView];
            coverImage.image = [model valueForKey:@"grayPosterImg"];
        } else [self selectMovie:coverImgView];
        
        [coverImgView addSubview:coverImage];
        [moviesList addSubview:coverImgView];
        
        [backgroundZone addSubview:backgroundImage];
        
        //MARK: LOAD POSTERS
        
        if([model valueForKey:@"posterImg"]==nil)
        {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^(void) {
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [model valueForKey:@"urlPoster"]]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                
                if(image == nil)
                    image = [UIImage imageNamed:@"cover50x74"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [model setValue:[image convertToGrayscale] forKey:@"grayPosterImg"];
                    [model setValue:image forKey:@"posterImg"];
                        
                    backgroundImage.image = [model valueForKey:@"posterImg"];
                    coverImage.image = [model valueForKey:@"posterImg"];
                        
                    if(index != self.controller.startId)
                        coverImage.image = [model valueForKey:@"grayPosterImg"];
                        
                    [backgroundImage setNeedsLayout];
                    [coverImage setNeedsLayout];
                });
            });
        }
        
        index++;
    }
    
    backgroundZone.contentSize = CGSizeMake(frameWidth*index, header.frame.size.height);
    moviesList.contentSize = CGSizeMake(index*175+firstCoverXPos*2-28, backgroundZone.frame.size.height - 40 - navBarHeight);
    
    [header addSubview:backgroundZone];
    [header addSubview:fadingBg];
    [header addSubview:blurBackground];
    [header bringSubviewToFront:blurBackground];
    
    [header addSubview:moviesList];
    [header bringSubviewToFront:moviesList];
    
    [self.scrollView addSubview:header];
    
    [self addMovieDetailsViewWithAnimation:YES];
}

- (void)addMovieDetailsViewWithAnimation:(BOOL)withAnimation
{
    for(UIView *view in movieEntireDetails.subviews)
        [view removeFromSuperview];
    
    long lastContentHeight = backgroundZone.frame.size.height-navBarHeight-borderWidth+30;
    //MARK: ENTIRE DETAILS
    
    long firstLastContentHeight = lastContentHeight;
    movieEntireDetails = [[UIView alloc] initWithFrame:CGRectMake(0, lastContentHeight, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    movieEntireDetails.alpha = 0;
    
    //MARK:- TITLE
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, frameWidth-60, 22)];
    title.text = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"title"];
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    title.textColor = [UIColor grayColor];
    
    CGRect frame = title.frame;
    [title sizeToFit];
    frame.size.height = title.frame.size.height;
    title.frame = frame;
    
    lastContentHeight = title.frame.size.height + 12;
    
    [movieEntireDetails addSubview:title];
    
    
    //MARK:- DESCRIPTION
    
    if([[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"simplePlot"]!=nil && ![[[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"simplePlot"] isEqual:@""])
    {
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
        [movieEntireDetails addSubview:descView];
    }
    
    
    //MARK:- INFOS
    
    UIView *infosView = [[UIView alloc] initWithFrame:CGRectMake(25, lastContentHeight, frameWidth-50, 80)];
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(typeView.frame.origin.x+typeView.frame.size.width, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    UIView *votesView = [[UIView alloc] initWithFrame:CGRectMake(saveView.frame.origin.x+saveView.frame.size.width, 0, (frameWidth-50)/3, infosView.frame.size.height)];
    
    
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
    
    
    //MARK: SaveView
    
    UIImageView *trailerImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(saveView.frame.size.width/2-19.5, 0, 39, 39)];
    
    trailerImageView.image = [UIImage imageNamed:@"saveVideo"];
    trailerImageView.image = [trailerImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    trailerImageView.contentMode = UIViewContentModeScaleToFill;
    
    trailerImageView.tintColor = [UIColor colorWithRed:0.133 green:0.545 blue:0.133 alpha:1];
    
    UILabel *trailerText = [[UILabel alloc] initWithFrame:CGRectMake(0, saveView.frame.size.height-33, saveView.frame.size.width, 20)];
    
    trailerText.text = @"Watch Movie";
    trailerText.numberOfLines = 0;
    trailerText.textAlignment = NSTextAlignmentCenter;
    trailerText.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    trailerText.textColor = [UIColor colorWithRed:0.133 green:0.545 blue:0.133 alpha:1];
    
    UITapGestureRecognizer *tapOnTrailerView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTrailerView:)];
    [tapOnTrailerView setNumberOfTapsRequired:1];
    
    self.trailerCalled = [[self.controller.params objectAtIndex:self.controller.startId] valueForKey:@"trailerURL"];
    
    [saveView addSubview:trailerImageView];
    [saveView addSubview:trailerText];
    
    [saveView setUserInteractionEnabled:YES];
    [saveView addGestureRecognizer:tapOnTrailerView];
    
    [infosView addSubview:saveView];
    
    
    //MARK: VotesView
    
    UIImageView *votesImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(votesView.frame.size.width/2-18.25, 0, 36.5, 36.)];
    
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
    
    
    //MARK: FinalInfosView
    
    lastContentHeight += infosView.frame.size.height  + 5;
    
    //MARK: TrailerWebView
    
    if(self.trailerCalled != nil)
    {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(25, lastContentHeight, frameWidth-50, (frameWidth-50)*9/16)];
        
        [webView setOpaque:NO];
        
        webView.layer.shadowColor = [UIColor blackColor].CGColor;
        webView.layer.shadowOffset = CGSizeMake(-1, 2);
        webView.layer.shadowOpacity = 0.2;
        
        webView.backgroundColor = [UIColor lightGrayColor];
        
        NSURL *pageUrl = [NSURL URLWithString:self.trailerCalled];
        NSURLRequest *request = [NSURLRequest requestWithURL:pageUrl];
        
        [movieEntireDetails addSubview:webView];
        [webView loadRequest:request];
        
        lastContentHeight += webView.frame.size.height  + 15;
    }
    
    movieEntireDetails.frame = CGRectMake(0, firstLastContentHeight, [[UIScreen mainScreen] bounds].size.width, lastContentHeight);
    [movieEntireDetails addSubview:infosView];
    
    [self.scrollView addSubview:movieEntireDetails];
    self.scrollView.contentSize = CGSizeMake(frameWidth, movieEntireDetails.frame.size.height+movieEntireDetails.frame.origin.y);
    
    //MARK:- ANIMATIONS
    
    if(withAnimation)
    {
        [backgroundZone setContentOffset:CGPointMake(self.controller.startId*frameWidth, 0) animated:NO];
        [moviesList setContentOffset:CGPointMake(self.controller.startId*175, 0) animated:NO];
    }
    
    [self initAnimationAlphaForUIVIew:movieEntireDetails fromValue:0 To:1 WithTime:0.7];
    
    //MARK:- DELEGATES
    
    moviesList.delegate = self.controller;
}

- (void)unselectMovie:(UIView*)view
{
    view.alpha = 0.75f;
    view.layer.borderColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 0;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-1, 2);
    view.layer.shadowOpacity = 0.4;
}

- (void)selectMovie:(UIView*)view
{
    view.alpha = 1.0f;
    view.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f].CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-2, 5);
    view.layer.shadowOpacity = 0.4;
}

- (void)initAnimationAlphaForUIVIew:(UIView*)view fromValue:(float)from To:(float)to WithTime:(float)time
{
    [UIView animateWithDuration:time animations:^(void) {
        view.alpha = from;
        view.alpha = to;
    }];
}

- (void)initAnimationAlphaForUIVIew:(UIView*)view fromValue:(float)from To:(float)to WithTime:(float)time completionHandler:(void (^)(void))callBackFunction
{
    [UIView animateWithDuration:time animations:^(void) {
        view.alpha = from;
        view.alpha = to;
    } completion:^(BOOL finished){
        if(finished)
            callBackFunction();
    }];
}

- (void)onMovieTap:(UIGestureRecognizer *)sender
{
    UIView *viewSender = sender.view;
    long index = viewSender.tag-1;
    
    [self performActionsAfterScroll:moviesList withIndex:index];
}

- (void)onTapTrailerView:(UIGestureRecognizer *)sender
{
    WebNavigatorController *navController = [[WebNavigatorController alloc] init];
    navController.pageUri = self.trailerCalled;
    
    [self.controller.navigationController pushViewController:navController animated:YES];
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

- (void)eventOnDidScrollMoviesList:(UIScrollView *)scrollView
{
    
    long index = (int)scrollView.contentOffset.x/175;
    if(scrollView.contentOffset.x/175-index > 0.4)
        index += 1;
    
    if(index > [self.controller.params count])
        index = [self.controller.params count];
    else if(index < 0)
        index = 0;

    [self performActionsAfterScroll:scrollView withIndex:index];
}

- (void)performActionsAfterScroll:(UIScrollView*)scrollView withIndex:(long)index
{
    long oldId = self.controller.startId;
    scrollView.delegate = nil;
    
    fadingBg.alpha = 0;
    fadingBg.image = [[self.controller.params objectAtIndex:index] valueForKey:@"posterImg"];
    
    [self initAnimationAlphaForUIVIew:fadingBg fromValue:0 To:1 WithTime:0.35 completionHandler:^{
        [backgroundZone setContentOffset:CGPointMake(index*frameWidth, 0) animated:NO];
        fadingBg.alpha = 0;
        scrollView.delegate = self.controller;
    }];
    
    [scrollView setContentOffset:CGPointMake(index*175, 0) animated:YES];
    
    if(index == oldId)
    return;
    
    self.controller.startId = index;
    
    UIView *view = [moviesList viewWithTag:(oldId+1)];
    if(view != nil)
    {
        UIImageView *imageView = (UIImageView *)view.subviews[0];
        
        [self unselectMovie:view];
        
        imageView.frame = CGRectMake(6.5, 10, 142, view.frame.size.height-20);
        imageView.image = [[self.controller.params objectAtIndex:oldId] valueForKey:@"grayPosterImg"];
    }
    
    view = [moviesList viewWithTag:(index+1)];
    if(view != nil)
    {
        UIImageView *imageView = (UIImageView *)view.subviews[0];
        
        [self selectMovie:view];
        
        imageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        imageView.image = [[self.controller.params objectAtIndex:index] valueForKey:@"posterImg"];
    }
    
    [self initAnimationAlphaForUIVIew:movieEntireDetails fromValue:1 To:0 WithTime:0.2 completionHandler:^{
        [self addMovieDetailsViewWithAnimation:NO];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
