//
//  Book.h
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSMutableArray *title;
@property (nonatomic, strong) NSMutableArray *author;
@property (nonatomic, strong) NSMutableArray *publisher;
@property (nonatomic, strong) NSMutableArray *bookDescription;
@property (nonatomic, strong) NSMutableArray *smallImageLink;
@property (nonatomic, strong) NSMutableArray *largeImageLink;
@property (nonatomic, strong) NSMutableArray *previewLinks;
@property (nonatomic, strong) NSMutableArray *pageCountArray;


+ (id)sharedManager;



@end
