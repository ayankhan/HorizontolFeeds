//
//  SharedParsing.m
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import "SharedParsing.h"

#define sharedQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation SharedParsing

static NSString *const feedsURL = @"http://54.254.204.73/api/property/feeds";

SINGLETON_FOR_CLASS(SharedParsing);

-(void)assignSender:(id)sender
{
    obj = sender;
}

#pragma mark - FEEDS WEBSERVICE -

- (void)WSCallForFeeds:(NSDictionary*)dict
                 successBlock:(completionBlock)completionBlock
                 failureBlock:(failureBlock)failure
{
    dispatch_async( sharedQueue,
                   ^{
                       NSURL *url1 = [NSURL URLWithString:feedsURL];
                       [self createNSUrlSession:url1 postDict:dict successBlock:completionBlock failureBlock:failure];
                       
                   });
}


#pragma mark - CREATE NSURLSESSION -

-(void)createNSUrlSession:(NSURL*)URL postDict:(NSDictionary*)dict successBlock:(completionBlock)completionBlock
             failureBlock:(failureBlock)failure
{
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    //Json String
    NSString * myString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"ULR----->>>>%@",URL);
    NSLog(@"PostDict----->>>>%@",myString);
    
    
    
    
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          
                                          {
                                              if ([data length] > 0 && error == nil)
                                              {
//                                                  NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                  NSLog(@"result string: %@", newStr);
//                                                  NSLog(@"result string: %@", response);
                                                  
                                                  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                  NSLog(@"result json: %@", jsonArray);
                                                  
                                                  if (!jsonArray) {
                                                      NSLog(@"Get Feeds Error is %@",[error description]);
                                                      failure(NO,nil);
                                                  }else
                                                  {
                                                      completionBlock(YES,jsonArray);
                                                  }
                                                 
                                              }
                                              
                                              else if ([data length] == 0 && error == nil){
                                                  failure(NO,nil);
                                              }
                                              
                                              else if (error != nil){
                                                  NSLog(@"Get Feeds Error is %@",[error description]);
                                                  failure(NO,nil);
                                              }
                                              
                                          }];
    
    [postDataTask resume];
}

@end
