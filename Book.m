//
//  Book.m
//  Copyright © 2017 Jason. All rights reserved.
//

#import "Book.h"

@implementation Book


+ (id)sharedManager {
    static Book *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

@end
