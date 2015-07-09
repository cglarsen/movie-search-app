//
//  MSMovie.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 03/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSMovie.h"

@implementation MSMovie

+ (instancetype)movieFromData:(NSDictionary *)data {
    MSMovie *movie = [MSMovie new];
    movie.movieID = data[@"id"];
    movie.movieTitle = data[@"original_title"];
    movie.movieResume = data[@"overview"];
    movie.posterImageUrl = data[@"poster_path"];
    movie.backdropImageUrl = data[@"backdrop_path"];
    movie.releaseDateString = data[@"release_date"];
    movie.movieVote = [NSNumber numberWithFloat: [data[@"vote_average"]floatValue]];
    movie.movieGenres =data[@"genre_ids"];
    return movie;
}

@end
