//
//  MovieTableViewCell.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 04/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSMovieTableViewCell.h"
#import "View+MASAdditions.h"

@implementation MSMovieTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //setup layout
        [self setBackgroundColor:[UIColor blackColor]];
        
        // configure control(s)
        self.posterImage = [[UIImageView alloc] init];
        [self addSubview:self.posterImage];
        [self.posterImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(2.0);
            make.left.equalTo(self.mas_left).with.offset(2.0);
            make.width.equalTo(@46);
            make.height.equalTo(@69);
        }];

        self.movieTitleLabel = [[UILabel alloc] init];
        self.movieTitleLabel.textColor = [UIColor whiteColor];
        self.movieTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.movieTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:28.0f]];
        [self addSubview:self.movieTitleLabel];
        [self.movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.posterImage.mas_top);
            make.left.equalTo(self.posterImage.mas_right).with.offset(10.0);
            make.width.equalTo(@200);
            make.height.equalTo(@35);
        }];
        
        self.yearLabel = [[UILabel alloc] init];
        self.yearLabel.textColor = [UIColor whiteColor];
        self.yearLabel.textAlignment = NSTextAlignmentLeft;
        [self.yearLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0f]];
        [self addSubview:self.yearLabel];
        [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.movieTitleLabel.mas_bottom).with.offset(2.0);
            make.left.equalTo(self.posterImage.mas_right).with.offset(10.0);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
