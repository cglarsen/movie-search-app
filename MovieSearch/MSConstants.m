//
//  MSConstants.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 08/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSConstants.h"
NSString *const MSTimeSinceLastConfigUpdateKey  = @"lastUpdate";
NSString *const MSBaseImageURLKey               = @"baseImageURL";
NSString *const MSMovieGenreKey                 = @"movieGenre";

NSString * const configurationURLString         = @"http://api.themoviedb.org/3/configuration?api_key=ecc4744bcd27ca2e8d8921697735915b";
NSString * const BaseURLString                  = @"http://api.themoviedb.org/3/search/movie?api_key=ecc4744bcd27ca2e8d8921697735915b&query=";
NSString * const genreURLString                 = @"http://api.themoviedb.org/3/genre/movie/list?api_key=ecc4744bcd27ca2e8d8921697735915b";