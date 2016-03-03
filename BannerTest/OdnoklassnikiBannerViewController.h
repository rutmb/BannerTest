//
//  OdnoklassnikiBannerViewController.h
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OdnoklassnikiBannerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *bannerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannerTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bannerLogotype;

@property (strong, nonatomic) NSString* bannerTitle;
@property (strong, nonatomic) NSString* bannerText;
@property (strong, nonatomic) NSString* bannerName;
@property (strong, nonatomic) UIImage* bannerImage;
@property (strong, nonatomic) UIImage* bannerLogoImage;

@end
