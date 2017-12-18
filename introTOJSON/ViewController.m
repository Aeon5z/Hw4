//
//  ViewController.m
//  introTOJSON
//
//  Created by user on 12/11/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"
#import "AccountsTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblWeatherValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateButton:(UIButton *)sender {
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
            
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if ([object isKindOfClass:[NSArray class]]) {
                NSDictionary *mainObject = object[5];
                
           //     NSDictionary *weatherObject = [object valueForKey:@"weather"][0];
                
                NSString *textString = [NSString stringWithFormat:@"Account Number: %@" ,mainObject[@"accountNumber"]];
                
                dispatch_sync(dispatch_get_main_queue(), ^{self.lblWeatherValue.text = textString;});
            }
        }
    }];
    [task resume];
}



@end
