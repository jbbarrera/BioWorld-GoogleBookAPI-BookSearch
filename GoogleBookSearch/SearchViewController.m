//
//  SearchViewController.m
//  GoogleBookSearch
//
//  Created by Jason on 11/29/17.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsViewCellTableViewCell.h"
#import "DetailViewController.h"
#import "Book.h"
#import "NetworkClient.h"

@interface SearchViewController (){
    NSMutableArray *dataArray;
    
}
@property (strong, nonatomic) NSMutableArray *trackNames;
@property (strong, nonatomic) NSMutableArray *albumName;
@property (strong, nonatomic) NSMutableArray *artistName;
@property (strong, nonatomic) NSMutableArray *albumImage;
@property (strong, nonatomic) Book *bookInstance;
@property (strong, nonatomic) NSString * imageURL;

@end
@interface SearchViewController()

@end
@implementation SearchViewController
@synthesize resultTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bookSearchBar setDelegate:self];
    self.bookInstance = [Book sharedManager];
    //This observer listens for the network call to finish and then triggers the table reload
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData) name:@"ReloadRootViewControllerTable" object:nil];
   
    //create placeholder to instruct the user to enter an Author,Title etc...
    self.bookSearchBar.placeholder = @"Enter an Author, Title or Subject here...";
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"ResultsTableCell";
    ResultsViewCellTableViewCell *cell = [self.resultTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[ResultsViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSLog(@"image for cell = %@", [self.bookInstance.smallImageLink objectAtIndex:indexPath.row]);
    
    if ([self.bookInstance.title objectAtIndex:indexPath.row] == [NSNull null]){
        cell.titleLabel.text = @"N/A";
    }
    
    else {
        NSLog(@"author on tableview ==%@", [self.bookInstance.title objectAtIndex:indexPath.row]);
        cell.titleLabel.text = [self.bookInstance.title objectAtIndex:indexPath.row];
    }
    NSString * imageURL =[self.bookInstance.smallImageLink objectAtIndex:indexPath.row];
    if ([imageURL isEqual:[NSNull null]]){
        
    } else {
        
        //Download image in the background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData * imageData = [[NSData alloc] init];
            NSLog(@"image url==%@", imageURL);
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            //set the image on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                 cell.cellImageView.image = [UIImage imageWithData:imageData];
            });    
        });
        
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.bookInstance.title count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"lyricSegue" sender:self];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NetworkClient * client = [[NetworkClient alloc] init];
    [client bookSearchRequest:searchBar.text];
    
}

-(void) reloadTableViewData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.resultTableView reloadData];
        [self.view endEditing:YES];
    });
    
    
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}


//passing all of our Book info to the DetailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"lyricSegue"]) {
        
        NSIndexPath *indexPath = [self.resultTableView  indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.titleName = [self.bookInstance.title objectAtIndex:indexPath.row];
        destViewController.largeImageLink = [self.bookInstance.largeImageLink objectAtIndex:indexPath.row];
        destViewController.bookSummary = [self.bookInstance.bookDescription objectAtIndex:indexPath.row];
        destViewController.publisher = [self.bookInstance.publisher  objectAtIndex:indexPath.row];
        destViewController.numberOfPages = [self.bookInstance.pageCountArray objectAtIndex:indexPath.row];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
