//
//  LyricsViewController.h
//
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
    
@property (strong, nonatomic) NSString *largeImageLink;
@property (strong, nonatomic) NSString *titleName;
@property (strong, nonatomic) NSString *bookSummary;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSNumber *numberOfPages;

@property (weak, nonatomic) IBOutlet UILabel *pageCountLabel;

//@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;

@property (weak, nonatomic) IBOutlet UITextView *bookDescriptionView;
@property (weak, nonatomic) IBOutlet UILabel *publisherInfo;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;


@property (strong, nonatomic) IBOutlet UIImageView *bookDetailImage;




@end
