//
//  RootView.h
//  InMovies
//
//  Created by Buzoianu Stefan on 03/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "+NavigationDelegates.h"

@interface RootView : UIView

@property (nonatomic, weak) id<MainNavigationDelegate> delegate;

- (void)initNavigationToolBarWithNavigationController:(UINavigationController *)navController andNavigationItem:(UINavigationItem *)navItem;

+ (void)addBlurredBgToMainView:(UIView *)view;

@end
