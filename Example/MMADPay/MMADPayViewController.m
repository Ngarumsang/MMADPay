//
//  MMADPayViewController.m
//  MMADPay
//
//  Created by Ngarumsang on 12/07/2016.
//  Copyright (c) 2016 Ngarumsang. All rights reserved.
//

#import "MMADPayViewController.h"
#import "MMADPayConstants.h"
#import "MMADPayPaymentViewController.h"
#import "MMADPayPaymentModelParams.h"
#include <CommonCrypto/CommonDigest.h>
#import "MMADPayDemoCollectionViewCell.h"
#import "ProductDetailsViewController.h"


static NSString *cellId = @"MMADPayDemoCollectionViewCell";


@interface MMADPayViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    NSArray *keys;
    NSMutableArray *values;
    NSMutableString *hashInfoString;
    
    NSArray *priceArray;
    NSArray *imageArray;
    NSArray *productNameArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MMADPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MMADPay Demo";
    self.automaticallyAdjustsScrollViewInsets = false;
    imageArray = @[@"iphone-7", @"timex-watch", @"apple-wearable", @"apple-ipod", @"sennheiser-earpiece"];
    priceArray = @[@"70000", @"2000", @"22000", @"17000",@"1000"];
    productNameArray = @[@"iPhone 7", @"Timex Watch", @"Apple Wearable", @"Apple iPod", @"Sennheiser Earpiece"];
    
    
    
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imageArray count];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CGFloat cellSize = self.view.bounds.size.width/2 - 10;
    
    return CGSizeMake(cellSize, cellSize*1.5);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MMADPayDemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.imageViewProduct.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",[imageArray objectAtIndex:indexPath.row]]];
    cell.lblProductName.text = [productNameArray objectAtIndex:indexPath.row];
    cell.lblPrice.text = [NSString stringWithFormat:@"Rs %@",[priceArray objectAtIndex:indexPath.row]];
    cell.btnView.layer.cornerRadius = 3.0;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailsViewController *productDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailsViewController"];
    productDetails.imageProduct = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",[imageArray objectAtIndex:indexPath.row]]];
    productDetails.productName = [productNameArray objectAtIndex:indexPath.row];
    productDetails.productPrice = [priceArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:productDetails animated:YES];
}








@end
