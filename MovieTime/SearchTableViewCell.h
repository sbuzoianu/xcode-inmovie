//
//  SearchTableViewCell.h
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "+TableViewCellDelegate.h"

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic, strong) id<TableViewCellDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;

- (IBAction)cellTapGestureInvoked:(UITapGestureRecognizer *)sender;

@end
