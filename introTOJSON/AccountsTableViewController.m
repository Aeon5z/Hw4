//
//  AccountsTableViewController.m
//  introTOJSON
//
//  Created by user on 12/13/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "AccountsTableViewController.h"
#import "AccountTableViewCell.h"

@interface AccountsTableViewController () <UISearchBarDelegate>
@property (strong , nonatomic) NSArray *object;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) BOOL isFiltered;
@property (strong , nonatomic) NSMutableArray *filteredaccts;
@property (strong , nonatomic) NSMutableArray *filteredaccts1;



@end

@implementation AccountsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFiltered = false ;
    self.searchBar.delegate = self;

    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://www.toyocat.net/ricardo.json"]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data == nil){
            NSLog(@"No data recived");
        }
        else{
            NSLog(@"Recived data, need to parse JSON");
            NSLog(@"JSON Data:%@" , data);
            
           // id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            self.object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if ([self.object isKindOfClass:[NSArray class]]) {
                
                for(int i = 0; i < [self.object count]; i++)
                NSLog(@"Main object count: %@" , self.object[i]);
                
                //     NSDictionary *weatherObject = [object valueForKey:@"weather"][0];
                
      //          NSString *textString = [NSString stringWithFormat:@"Account Number: %@" ,mainObject[@"accountNumber"]];
                
             //   dispatch_sync(dispatch_get_main_queue(), ^{self.lblWeatherValue.text = textString;});
            }
        }
    }];
    [task resume];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered) {
        return [self.filteredaccts count];
    }
    else{
    return [self.object count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"account" forIndexPath:indexPath];
   
    if (self.isFiltered) {
        cell.textLabel.text = self.filteredaccts[indexPath.row];
        cell.lblAccountBal.text = @"";
        cell.lblAccountAvailable.text = @"";
        cell.lblAccountNumber.text = @"";
        cell.lblAccountCurrency.text = self.filteredaccts1[indexPath.row];
        cell.lblAccountType.text = @"";
        
      
        
        
    }
    else{
    cell.lblAccountNumber.text = self.object[indexPath.row][@"accountNumber"];
    cell.lblAccountBal.text = self.object[indexPath.row][@"accountBalance"];
    cell.lblAccountCurrency.text =self.object[indexPath.row][@"accountCurrency"];
    cell.lblAccountAvailable.text = self.object[indexPath.row][@"accountAvailable"];
    cell.lblAccountType.text = self.object[indexPath.row][@"accountType"];
    }
    
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - search bar delegate method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        self.isFiltered = false;
    }
    else if ([self.object valueForKey:@"accountType"]) {
        self.isFiltered = true;
        self.filteredaccts = [[NSMutableArray alloc]init];
 
        for (NSString *accts in [self.object valueForKey:@"accountType"]){
             
         NSRange nameRange = [accts rangeOfString:searchText options:NSCaseInsensitiveSearch];
         if ( nameRange.location != NSNotFound) {
         [self.filteredaccts addObject:accts];
         NSLog(@"%@" , self.filteredaccts);
             
         }
         }
    }
    
    else {
        self.isFiltered = true;
        self.filteredaccts1 = [[NSMutableArray alloc]init];
        
        for (NSString *accts1 in [self.object valueForKey:@"accountCurrency"]){
            
            NSRange nameRange = [accts1 rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if ( nameRange.location != NSNotFound) {
                [self.filteredaccts1 addObject:accts1];
                NSLog(@"%@" , self.filteredaccts1);
                
            }
        }
    }
    
    [self.tableView reloadData];
     }




@end
