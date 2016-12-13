//
//  ProductDetailsViewController.h
//  MMADPay
//
//  Created by Vashum on 13/12/16.
//  Copyright © 2016 Ngarumsang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnBuyNow;

@property (strong,nonatomic) NSString *productName;
@property (strong,nonatomic) NSString *productPrice;
@property (strong,nonatomic) UIImage *imageProduct;


@end
