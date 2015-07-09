//
//  MSMovieDetailViewController.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMovieDetailViewModel.h"

@interface MSMovieDetailViewController : UIViewController

- (instancetype)initWithViewModel:(MSMovieDetailViewModel *)viewModel;

@end
