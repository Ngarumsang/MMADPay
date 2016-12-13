//
//  MMADPayDemoCollectionViewCell.h
//  MMADPay
//
//  Created by Vashum on 13/12/16.
//  Copyright © 2016 Ngarumsang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMADPayDemoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnView;

@end
