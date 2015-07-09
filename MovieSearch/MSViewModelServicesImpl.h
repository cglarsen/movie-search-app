//
//  MSViewModelServicesImpl.h
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSViewModelServices.h"

@interface MSViewModelServicesImpl : NSObject <MSViewModelServices>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
