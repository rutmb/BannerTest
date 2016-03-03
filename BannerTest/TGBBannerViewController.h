//
//  TGBBannerViewController.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TGBBannerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *bannerTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *bannerClickUrlButton;
@property (weak, nonatomic) IBOutlet UILabel *bannerTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannerNameLabel;

@property (strong, nonatomic) NSString* bannerTitle;
@property (strong, nonatomic) NSString* bannerClickUrl;
@property (strong, nonatomic) NSString* bannerText;
@property (strong, nonatomic) NSString* bannerName;
@property (strong, nonatomic) UIImage* bannerImage;

@end
