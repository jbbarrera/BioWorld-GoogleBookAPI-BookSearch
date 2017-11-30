//
//  NetworkClient.m
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NetworkClient.h"
#import "Book.h"
#import "SearchViewController.h"

@implementation NetworkClient{
    NSMutableArray *dataArray;
    NSInteger nullIndex;
    
}




-(void)bookSearchRequest:(NSString *)searchString {
    //Implement singleton to instantiate our book model
    self.bookInstance = [Book sharedManager];
    
    NSString * inputString =[NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=%@&maxResults=40",searchString];
    NSURL * url = [[NSURL alloc] init];
    NSCharacterSet *allowed = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    url = [NSURL URLWithString:[inputString stringByAddingPercentEncodingWithAllowedCharacters:allowed]];
    NSLog(@"the url=%@", url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                      
                                      self.bookInstance.title = [dataArray valueForKeyPath:@"items.volumeInfo.title"];
                                      
                                      self.bookInstance.author = [dataArray valueForKeyPath:@"items.volumeInfo.authors"];
                                      
                                      self.bookInstance.bookDescription = [dataArray valueForKeyPath:@"items.volumeInfo.description"];
                                      
                                      self.bookInstance.largeImageLink = [dataArray valueForKeyPath:@"items.volumeInfo.imageLinks.thumbnail"];
                                      
                                      self.bookInstance.smallImageLink = [dataArray valueForKeyPath:@"items.volumeInfo.imageLinks.smallThumbnail"];
                                      
                                      self.bookInstance.publisher = [dataArray valueForKeyPath:@"items.volumeInfo.publisher"];
                                      
                                      self.bookInstance.previewLinks = [dataArray valueForKeyPath:@"items.volumeInfo.previewLink"];
                                      
                                      self.bookInstance.pageCountArray = [dataArray valueForKeyPath:@"items.volumeInfo.pageCount"];
                                      
                                      //Reload TableView once we get our results
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadRootViewControllerTable" object:nil];
                                      });
                                  }];
    [task resume];
    
}

@end
