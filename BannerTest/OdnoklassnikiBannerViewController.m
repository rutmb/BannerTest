//
//  OdnoklassnikiBannerViewController.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "OdnoklassnikiBannerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"

@interface OdnoklassnikiBannerViewController ()

@end

@implementation OdnoklassnikiBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerTextLabel.text = self.bannerText;
    self.bannerTitleLabel.text = self.bannerTitle;
    self.bannerNameLabel.text = self.bannerName;
    self.bannerImageView.image = self.bannerImage;
    self.bannerLogotype.image = self.bannerLogoImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
