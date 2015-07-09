//
//  MSViewModelServicesImpl.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSViewModelServicesImpl.h"
#import "MSMovieDBImpl.h"
#import "MSMovieDetailViewController.h"
#import "MSMovieDetailViewModel.h"

@interface MSViewModelServicesImpl ()

@property (weak, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) MSMovieDBImpl *movieSearchService;

@end

@implementation MSViewModelServicesImpl

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _movieSearchService = [MSMovieDBImpl new];
        _navigationController = navigationController;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _movieSearchService = [MSMovieDBImpl new];
    }
    return self;
}

- (id<MSMovieDBInterface>)getMovieDBSearchService {
    return self.movieSearchService;
}

- (void)pushViewModel:(id)viewModel {
    id viewController;
    
    if ([viewModel isKindOfClass:MSMovieDetailViewModel.class]) {
        viewController = [[MSMovieDetailViewController alloc] initWithViewModel:viewModel];
    } else {
        NSLog(@"dont known the pushed ViewModel!");
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
