//
//  MSSearchViewModel.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 06/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSSearchViewModel.h"
#import "NSArray+LinqExtensions.h"
#import "MSMovie.h"
#import "MSMovieDetailViewModel.h"

@interface MSSearchViewModel ()

@property (nonatomic, weak) id<MSViewModelServices> services;

@end

@implementation MSSearchViewModel

- (instancetype)initWithServices:(id<MSViewModelServices>)services {
    self = [super init];
    if (self) {
         _services = services;
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.searchText = @"";
    self.movies = [NSArray array];
    
    //Main signal observe changes in search textField
    [[[[[RACObserve(self, searchText)
         filter:^BOOL(NSString *text) {
             return [self isValidSearchText:text];
         }]
        throttle:0.5]
       flattenMap:^RACStream *(NSString *text) {
           return [[self.services getMovieDBSearchService] signalForMovieSearchWithText:text];
       }]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(NSDictionary *jsonSearchResult) {
         //NSLog(@"jsonResponse: %@",jsonSearchResult);
         NSArray *results = jsonSearchResult[@"results"];
         NSArray *movies = [results linq_select:^id(id movie) {
             return [MSMovie movieFromData:movie];
         }];
         self.movies = nil;
         self.movies = movies;
     } error:^(NSError *error) {
         NSLog(@"An error occurred: %@", error);
     }];
    
    // create the selected movie command that push new viewmodel and view
    self.selectedMovieCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(MSMovie *selectedMovie) {
        MSMovieDetailViewModel *movieDetailViewModel =
        [[MSMovieDetailViewModel alloc] initWithMovie:selectedMovie services:self.services];
        [self.services pushViewModel:movieDetailViewModel];
        
        return [RACSignal empty];
    }];

}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

- (RACSignal *)signalForLoadingImage:(NSString *)imageUrl {
    return [[self.services getMovieDBSearchService] signalForLoadingImage:imageUrl];
}

@end
