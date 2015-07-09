//
//  MSMovie.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 03/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSMovie : NSObject

@property (strong, nonatomic) NSString *movieID;
@property (strong, nonatomic) NSString *movieTitle;
@property (strong, nonatomic) NSString *movieResume;
@property (strong, nonatomic) NSString *posterImageUrl;
@property (strong, nonatomic) NSString *backdropImageUrl;
@property (strong, nonatomic) NSString *releaseDateString;
@property (strong, nonatomic) NSNumber *movieVote;
@property (strong, nonatomic) NSArray *movieGenres;


+ (instancetype)movieFromData:(NSDictionary *)data;
@end
