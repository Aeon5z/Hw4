//
//  AccountTableViewCell.h
//  introTOJSON
//
//  Created by Aeonz on 12/13/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblAccountNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountCurrency;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountBal;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountAvailable;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountType;

@end
