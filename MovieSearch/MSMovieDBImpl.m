//
//  MSMovieDBImpl.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 07/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSMovieDBImpl.h"
#import "AFNetworking.h"

@implementation MSMovieDBImpl

- (RACSignal *)signalForConfigurationURL {
    
    //create the signal block
    
    void (^signalBlock)(RACSubject *subject) = ^(RACSubject *subject) {
        
        NSURL *url = [NSURL URLWithString:[configurationURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //using AFNetworking to setup connection
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *timelineData = (NSDictionary *)responseObject;
            
            [subject sendNext:timelineData];
            [subject sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [subject sendError:error];
        }];
        
        [operation start];
    };
    
    RACSignal *signal = [RACSignal startLazilyWithScheduler:[RACScheduler scheduler]
                                                      block:signalBlock];
    return signal;
}

- (RACSignal *)signalForGenreArray {
    
    //create the signal block
    
    void (^signalBlock)(RACSubject *subject) = ^(RACSubject *subject) {
        
        NSURL *url = [NSURL URLWithString:[genreURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //using AFNetworking to setup connection
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *timelineData = (NSDictionary *)responseObject;
            
            [subject sendNext:timelineData];
            [subject sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [subject sendError:error];
        }];
        
        [operation start];
    };
    
    RACSignal *signal = [RACSignal startLazilyWithScheduler:[RACScheduler scheduler]
                                                      block:signalBlock];
    return signal;
}


- (RACSignal *)signalForMovieSearchWithText:(NSString *)text {
    
    //create the signal block
    
    void (^signalBlock)(RACSubject *subject) = ^(RACSubject *subject) {
        
        NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString,[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //using AFNetworking to setup connection
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *timelineData = (NSDictionary *)responseObject;
            
            [subject sendNext:timelineData];
            [subject sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [subject sendError:error];
        }];
        
        [operation start];
    };
    
    RACSignal *signal = [RACSignal startLazilyWithScheduler:[RACScheduler scheduler]
                                                      block:signalBlock];
    return signal;
}

-(RACSignal *)signalForLoadingImage:(NSString *)imageUrl {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageBaseUrl = [defaults objectForKey:MSBaseImageURLKey];
    
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *finalURLString = [NSString stringWithFormat:@"%@/w92/%@",imageBaseUrl,imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalURLString]];
        UIImage *image = [UIImage imageWithData:data];
        [subscriber sendNext:image];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:scheduler];
    
}

-(RACSignal *)signalForBackdropImage:(NSString *)imageUrl {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageBaseUrl = [defaults objectForKey:MSBaseImageURLKey];
    
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *finalURLString = [NSString stringWithFormat:@"%@/w300/%@",imageBaseUrl,imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalURLString]];
        UIImage *image = [UIImage imageWithData:data];
        [subscriber sendNext:image];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:scheduler];
    
}
@end
