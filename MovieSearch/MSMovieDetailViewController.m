//
//  MSMovieDetailViewController.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSMovieDetailViewController.h"
#import <ReactiveCocoa.h>
#import "View+MASAdditions.h"

@interface MSMovieDetailViewController ()
@property (strong, nonatomic) MSMovieDetailViewModel *viewModel;

@property (nonatomic, strong) UILabel *movieTitleLabel;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *voteLabel;
@property (nonatomic, strong) UILabel *genreLabel;
@property (nonatomic, strong) UIImageView *backdropImageView;
@property (nonatomic, strong) UITextView *resumeTextView;

@end

@implementation MSMovieDetailViewController

- (instancetype)initWithViewModel:(MSMovieDetailViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup layout
    [self.view setBackgroundColor:[UIColor blackColor]];

    //Backdrop image
    self.backdropImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.backdropImageView];
    [self.backdropImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@200);
    }];
    
    //fetching backdrop image
    [[[self.viewModel signalForBackdropImage:self.viewModel.detailedMovie.backdropImageUrl]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(UIImage *image) {
         self.backdropImageView.image = image;
     }];
    
    //Movie title label
    self.movieTitleLabel = [[UILabel alloc] init];
    self.movieTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.movieTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:35.0f]];
    self.movieTitleLabel.textColor=[UIColor whiteColor];
    self.movieTitleLabel.text = self.viewModel.detailedMovie.movieTitle;
    [self.view addSubview:self.movieTitleLabel];
    [self.movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backdropImageView.mas_bottom);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@60);
    }];
    
    //Movie year label
    self.yearLabel = [[UILabel alloc] init];
    self.yearLabel.textAlignment = NSTextAlignmentLeft;
    [self.yearLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0f]];
    self.yearLabel.textColor=[UIColor whiteColor];
    if (![self.viewModel.detailedMovie isKindOfClass:[NSNull class]]){
        if ([self.viewModel.detailedMovie.releaseDateString length] >= 4) self.yearLabel.text = [NSString stringWithFormat:@"Year: %@", [self.viewModel.detailedMovie.releaseDateString substringToIndex:4]];
        else self.yearLabel.text = @"Year: ?";
    }
    [self.view addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieTitleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@20);
    }];
    
    //Movie year label
    self.voteLabel = [[UILabel alloc] init];
    self.voteLabel.textAlignment = NSTextAlignmentLeft;
    [self.voteLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0f]];
    self.voteLabel.textColor=[UIColor whiteColor];
    self.voteLabel.text = [NSString stringWithFormat:@"Vote: %.1f", [self.viewModel.detailedMovie.movieVote floatValue]];
    [self.view addSubview:self.voteLabel];
    [self.voteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yearLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@20);
    }];
    
    //Movie genre label
    self.genreLabel = [[UILabel alloc] init];
    self.genreLabel.textAlignment = NSTextAlignmentLeft;
    [self.genreLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0f]];
    self.genreLabel.textColor=[UIColor whiteColor];
    [self setGenreLabelText:self.genreLabel];
    [self.view addSubview:self.genreLabel];
    [self.genreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voteLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@20);
    }];
    
    //Set resume textview
    self.resumeTextView = [[UITextView alloc] init];
    [self.view addSubview:self.resumeTextView];
    [self.resumeTextView setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];
    self.resumeTextView.textColor = [UIColor whiteColor];
    self.resumeTextView.backgroundColor = [UIColor blackColor];
    self.resumeTextView.editable = NO;
    self.resumeTextView.text = self.viewModel.detailedMovie.movieResume;
    [self.resumeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.genreLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-5);
    }];
}

- (void)setGenreLabelText:(UILabel *)genreLabel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *genreDict = [defaults objectForKey:MSMovieGenreKey];
    NSMutableString *genreString = [NSMutableString string];
    
    for (id object in self.viewModel.detailedMovie.movieGenres) {
        [genreString appendFormat:@" %@",[genreDict objectForKey:[NSString stringWithFormat:@"%@",object]]];
    }
    genreLabel.text = genreString;
}
@end
