//
//  MSMovieDetailViewModel.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSMovieDetailViewModel.h"

@interface MSMovieDetailViewModel ()
@property (nonatomic, weak) id<MSViewModelServices> services;
@end

@implementation MSMovieDetailViewModel

- (instancetype)initWithMovie:(MSMovie *)movie services:(id<MSViewModelServices>)services {
    if (self = [super init]) {
        _services = services;
        _detailedMovie = movie;
    }
    return self;
}

- (RACSignal *)signalForBackdropImage:(NSString *)imageUrl {
    return [[self.services getMovieDBSearchService] signalForBackdropImage:imageUrl];
}

@end
