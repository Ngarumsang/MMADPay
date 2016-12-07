//
//  InfoTableViewCell.h
//  SampleMMADAppSdk
//
//  Created by Vashum on 29/11/16.
//  Copyright © 2016 mmadapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblKey;
@property (weak, nonatomic) IBOutlet UITextField *tfValue;

@end
