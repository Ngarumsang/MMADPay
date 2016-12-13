//
//  SuccessViewController.h
//  MMADPay
//
//  Created by Vashum on 13/12/16.
//  Copyright © 2016 Ngarumsang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionId;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end
