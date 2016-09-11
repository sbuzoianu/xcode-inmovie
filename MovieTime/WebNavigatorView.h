//
//  WebNavigatorView.h
//  InMovies
//
//  Created by Buzoianu Stefan on 10/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebNavigatorController.h"

@interface WebNavigatorView : UIView

@property (nonatomic, weak) WebNavigatorController *controller;

- (void)loadPageFromUri:(NSString *)pageUri;

@end
