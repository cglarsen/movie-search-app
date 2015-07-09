//
//  MSMovieDBInterface.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol MSMovieDBInterface <NSObject>

//get url for feching images
- (RACSignal *)signalForConfigurationURL;
//get genry array for displaying movie genres
- (RACSignal *)signalForGenreArray;
//get autocomplete list of movies
- (RACSignal *)signalForMovieSearchWithText:(NSString *)text;
//get poster used as tableview thumbnail
- (RACSignal *)signalForLoadingImage:(NSString *)imageUrl;
//get backdrop image for detail view
- (RACSignal *)signalForBackdropImage:(NSString *)imageUrl;

@end
