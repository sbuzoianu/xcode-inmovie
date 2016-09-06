//
//  RootView.m
//  InMovies
//
//  Created by Buzoianu Stefan on 03/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "RootView.h"

@interface RootView ()

@end

@implementation RootView

- (void) callAddButtonDelegate:(id)sender
{
    [self.delegate didClickedAddBarButton:sender];
}

- (void)initNavigationToolBarWithNavigationController:(UINavigationController *)navController andNavigationItem:(UINavigationItem *)navItem
{
    [navController.navigationBar setBarStyle:UIBarStyleDefault];
    navController.navigationBar.topItem.title = @"InMovies";
    
    UIBarButtonItem *addNewMovieButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(callAddButtonDelegate:)];
    addNewMovieButton.tintColor = [UIColor blackColor];
    [navItem setRightBarButtonItem:addNewMovieButton];
    
    UIBarButtonItem *openMenuButton = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"list-fat-7"] style:UIBarButtonItemStylePlain target:self action:nil];
    openMenuButton.tintColor = [UIColor blackColor];
    
    navController.navigationBar.translucent = YES;
    
    [navController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [navController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    [navItem setLeftBarButtonItem:openMenuButton];
}

+ (void)addBlurredBgToMainView:(UIView *)view
{
    if (!UIAccessibilityIsReduceTransparencyEnabled())
    {
        UIView *backgroundView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+[UIScreen mainScreen].bounds.origin.y)];
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"bgToBlur"]];
        backgroundImage.frame = backgroundView.frame;
        [backgroundView addSubview:backgroundImage];
        
        //MARK: Blur Effect
        //Stackoverflow: http://stackoverflow.com/questions/17041669/creating-a-blurring-overlay-view
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [backgroundView addSubview:blurEffectView];
        [view addSubview:backgroundView];
    } else [view setBackgroundColor: [UIColor colorWithRed:0.86f green:0.86f blue:0.86f alpha:1.0f]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
