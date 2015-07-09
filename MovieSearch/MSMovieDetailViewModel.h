//
//  MSMovieDetailViewModel.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSViewModelServices.h"
#import "MSMovie.h"

@interface MSMovieDetailViewModel : NSObject

@property (strong, nonatomic) MSMovie *detailedMovie;

- (instancetype)initWithMovie:(MSMovie *)movie services:(id<MSViewModelServices>)services;
- (RACSignal *)signalForBackdropImage:(NSString *)imageUrl;
@end
