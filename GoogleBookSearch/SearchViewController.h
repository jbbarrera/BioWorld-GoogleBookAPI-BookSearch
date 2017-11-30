//
//  SearchViewController.h
//  GoogleBookSearch
//
//  Created by Jason on 11/29/17.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
}

@property (strong, nonatomic) IBOutlet UITableView *resultTableView;

@property (strong, nonatomic) IBOutlet UISearchBar *bookSearchBar;


@end
