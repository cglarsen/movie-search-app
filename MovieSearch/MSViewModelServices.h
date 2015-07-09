//
//  MSViewModelServices.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMovieDBInterface.h"

@protocol MSViewModelServices <NSObject>

- (id<MSMovieDBInterface>) getMovieDBSearchService;
- (void)pushViewModel:(id)viewModel;

@end
