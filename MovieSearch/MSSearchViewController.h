//
//  ViewController.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 03/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSearchViewModel.h"

@interface MSSearchViewController : UITableViewController

- (instancetype)initWithViewModel:(MSSearchViewModel *)viewModel;

@end

