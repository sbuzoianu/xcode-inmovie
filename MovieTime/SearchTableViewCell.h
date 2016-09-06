//
//  SearchTableViewCell.h
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@end
