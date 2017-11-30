//
//  NetworkClient.h
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface NetworkClient : NSObject

-(void)bookSearchRequest:(NSString *)searchString;
@property (strong, nonatomic) Book *bookInstance;

@end
