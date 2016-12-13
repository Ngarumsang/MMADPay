//
//  MMADPayUtils.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayUtils.h"

static MMADPayUtils *mmadPayUtils = nil;


@implementation MMADPayUtils {

    
    UIView *blurView;
    UIView *viewActivity;
}



+(instancetype)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        mmadPayUtils = [[MMADPayUtils alloc]init];
    });
    return mmadPayUtils;
}





- (void)showActivity: (UIViewController *)viewController {
    
    blurView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewController.view.bounds.size.width, viewController.view.bounds.size.height)];
    blurView.backgroundColor = [UIColor blackColor];
    blurView.alpha = 0.3;
    [viewController.view addSubview:blurView];
    
    
    viewActivity = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewController.view.bounds.size.width - 40, 120)];
    viewActivity.backgroundColor = [UIColor whiteColor];
    [viewController.view addSubview:viewActivity];
    viewActivity.center = viewController.view.center;
    viewActivity.layer.cornerRadius = 5.0;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(viewActivity.bounds.size.width/2-10, 10, 20, 20)];
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activity startAnimating];
    [viewActivity addSubview:activity];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, activity.frame.origin.y +  activity.frame.size.height + 5, viewActivity.bounds.size.width, 17)];
    [label setFont:[UIFont fontWithName:@"Helvetica neue" size:14.0]];
    label.text = @"Please wait a moment...";
    label.textAlignment = NSTextAlignmentCenter;
    [viewActivity addSubview:label];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, label.frame.origin.y + label.frame.size.height + 5, viewActivity.bounds.size.width, 30)];
    [image setImage:[UIImage imageNamed:@"mmadpay-logo.png"]];
    image.contentMode =UIViewContentModeScaleAspectFit;
    [viewActivity addSubview:image];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, image.frame.origin.y +  image.frame.size.height + 5, viewActivity.bounds.size.width, 17)];
    [label1 setFont:[UIFont fontWithName:@"Helvetica neue" size:12.0]];
    label1.text = @"Contacting your bank";
    label1.textAlignment = NSTextAlignmentCenter;
    [viewActivity addSubview:label1];
    
}

- (void)dismissActivity {
    [viewActivity removeFromSuperview];
    [blurView removeFromSuperview];
}


@end
