//
//  TGBBannerViewController.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "TGBBannerViewController.h"

@implementation TGBBannerViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.bannerTitleLabel.text = self.bannerTitle;
    [self.bannerClickUrlButton setTitle:self.bannerClickUrl
                               forState:UIControlStateNormal];
    self.bannerTextLabel.text = self.bannerText;
    self.bannerNameLabel.text = self.bannerName;
    
    self.bannerImageView.image = self.bannerImage;

}

- (IBAction)goToUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.bannerClickUrl]];
}

@end
