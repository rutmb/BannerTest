//
//  HtmlImageFlashBannerViewController.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "HtmlImageFlashBannerViewController.h"

@interface HtmlImageFlashBannerViewController ()

@end

@implementation HtmlImageFlashBannerViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.bannerClickUrlButton setTitle:self.bannerClickUrl
                               forState:UIControlStateNormal];
    self.bannerImageView.image = self.bannerImage;
    
}

- (IBAction)goToUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.bannerClickUrl]];
}

@end
