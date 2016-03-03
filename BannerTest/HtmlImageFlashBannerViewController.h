//
//  HtmlImageFlashBannerViewController.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HtmlImageFlashBannerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIButton *bannerClickUrlButton;

@property (strong, nonatomic) NSString* bannerClickUrl;
@property (strong, nonatomic) UIImage* bannerImage;

@end
