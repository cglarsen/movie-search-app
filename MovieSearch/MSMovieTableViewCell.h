//
//  MovieTableViewCell.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 04/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMovieTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *movieTitleLabel;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UIImageView *posterImage;

@end
