//
//  MSSearchViewModel.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 06/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSViewModelServices.h"

@interface MSSearchViewModel : NSObject
@property (strong, nonatomic) NSString *searchText;
@property (nonatomic, strong) NSArray *movies;

- (instancetype)initWithServices:(id<MSViewModelServices>)services;
- (RACSignal *)signalForLoadingImage:(NSString *)imageUrl;

@property (nonatomic, strong) RACCommand *selectedMovieCommand;

@end
