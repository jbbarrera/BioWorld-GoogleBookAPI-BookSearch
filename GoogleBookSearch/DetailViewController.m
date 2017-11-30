//
//  LyricsViewController.m
//
//  Copyright © 2017 Jason. All rights reserved.
//

#import "DetailViewController.h"
#import "Book.h"

@interface DetailViewController (){
    
    
    
    
}

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLabels];
    [self loadImages];
}



-(void)loadImages {
    //If image links are Null we use our default placeholder image
    if (![self.largeImageLink isEqual:[NSNull null]]  || [self.largeImageLink isEqual:@"<null>"]) {
        NSData * imageData = [[NSData alloc] init];
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.largeImageLink]];
        self.bookDetailImage.image = [UIImage imageWithData:imageData];
        
    }
}

-(void)loadLabels {
    //Adjust padding
    self.artistLabel.adjustsFontSizeToFitWidth = NO;
    self.artistLabel.numberOfLines = 3;
    //self.albumLabel.numberOfLines = 20;
    self.bookDescriptionView.textContainerInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    //Check publisher
    if ([self.publisher  isEqual: [NSNull null]]){
        self.publisherInfo.text = @"N/A";
    } else {
        self.publisherInfo.text = self.publisher;
    }
    
    //Check numberOfPages
    NSLog(@"number of pages = %@", self.numberOfPages);
    if ([self.numberOfPages isKindOfClass:[NSNull class]]){
        self.pageCountLabel.text = @"N/A";
    } else{
        self.pageCountLabel.text = self.numberOfPages.stringValue;
    }
    
    //Check bookDescription
    if ([self.bookSummary isEqual:@"<null>"] || [self.bookSummary isEqual:[NSNull null]]) {
        self.bookDescriptionView.text = @"N/A";
        
    } else {
        self.bookDescriptionView.text = self.bookSummary;
    }
    
    //Check Title
    if ([self.titleName isEqual:@"<null>"] || [self.titleName isEqual:[NSNull null]]) {
        self.artistLabel.text = @"N/A";
    } else {
        self.artistLabel.text = self.titleName;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}




@end
