//
//  StartBannerViewController.m
//  BannerTest
//
//  Copyright (c) 2016 slowmotion. All rights reserved.
//

#import "StartBannerViewController.h"
#import "ServerManager.h"

#import "File.h"
#import "Banner.h"
#import "TGBBanner.h"
#import "OdnoklassnikiBanner.h"
#import "HtmlImageFlashBanner.h"
#import "BannerCell.h"

#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"

#import "TGBBannerViewController.h"
#import "HtmlImageFlashBannerViewController.h"
#import "OdnoklassnikiBannerViewController.h"

#import "KxMenu.h"
#import "SaveLoadSettings.h"

@interface StartBannerViewController () <AFImageCache>


@property (strong, nonatomic) NSDictionary* bannersDictionary;

- (IBAction)SortGroupAction:(UIButton *)sender;


@end

@implementation StartBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* tempArray = [SaveLoadSettings loadSettings:self.numberOfSections andCurrentKey:self.currentKey];
    self.numberOfSections = [tempArray objectAtIndex:0];
    self.currentKey = [tempArray objectAtIndex:1];
    [self getBannersFromLocalStorage];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self
                            action:@selector(updateBanners:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.numberOfSections integerValue];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray* keys = [self.bannersDictionary allKeys];
  
    if ([self.numberOfSections integerValue] == [self.bannersDictionary count]) {
    
        NSString* currentKey = [keys objectAtIndex:section];
        
        NSArray* tempArray = [self.bannersDictionary objectForKey:currentKey];
        
        return [tempArray count];
        
    } else {
        
        NSArray* tempArray = [self.bannersDictionary objectForKey:self.currentKey];
        
        return [tempArray count];
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray* keys = [self.bannersDictionary allKeys];
    
    if ([self.numberOfSections integerValue] == [self.bannersDictionary count]) {
        
        NSString* currentKey = [keys objectAtIndex:section];
        
        return currentKey;
        
    } else {
        
        return self.currentKey;
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifeir = @"BannerCell";
    
    BannerCell* cell = [tableView dequeueReusableCellWithIdentifier:identifeir];
    
    
    NSArray* keys = [self.bannersDictionary allKeys];
    NSArray* tempArray;
    
    if ([self.numberOfSections integerValue] == [self.bannersDictionary count]) {
        
        NSString* currentKey = [keys objectAtIndex:indexPath.section];
        
        tempArray = [self.bannersDictionary objectForKey:currentKey];
        
    } else {
        
        tempArray = [self.bannersDictionary objectForKey:self.currentKey];
        
    }
    
    Banner* banner = [tempArray objectAtIndex:indexPath.row];
    
    cell.bannerTitleLabel.text = [NSString stringWithFormat:@"%@", banner.title];
    
    
    NSString* urlString = [NSString stringWithFormat:@"http:%@", banner.file.imageURL];
    
    NSURL* imageUrl = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl];
  
    if (![self cachedImageForRequest:request]) {
    
    __weak BannerCell* weakCell = cell;
    
    cell.bannerImage.image = nil;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success: ^(NSURLRequest *request, NSHTTPURLResponse * response, UIImage *image) {
                                       weakCell.bannerImage.image = image;
                                       [weakCell layoutSubviews];
                                       [self cacheImage:image forRequest:request];
                                   }
     
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
     
     }];
    } else {
       cell.bannerImage.image = [self cachedImageForRequest:request];
    }

    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard* storyboard = self.storyboard;
    
   
    NSArray* keys = [self.bannersDictionary allKeys];
    NSArray* tempArray;
    
    if ([self.numberOfSections integerValue] == [self.bannersDictionary count]) {
        
        NSString* currentKey = [keys objectAtIndex:indexPath.section];
        
        tempArray = [self.bannersDictionary objectForKey:currentKey];
        
    } else {
        
        tempArray = [self.bannersDictionary objectForKey:self.currentKey];
        
    }

    
    Banner* banner = [tempArray objectAtIndex:indexPath.row];

    
    if ([banner.type isEqualToString:@"TGBBanner"]) {
        
        TGBBannerViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"TGBBannerViewController"];
        
        TGBBanner* tgbBanner = (TGBBanner*) banner;
        
        
        NSString* urlString = [NSString stringWithFormat:@"http:%@", banner.file.imageURL];
        
        NSURL* imageUrl = [NSURL URLWithString:urlString];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl];
        
        
        vc.bannerTitle = tgbBanner.title;
        vc.bannerClickUrl = tgbBanner.clickUrl;
        vc.bannerText = tgbBanner.text;
        vc.bannerName = tgbBanner.text;
        vc.bannerImage= [self cachedImageForRequest:request];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([banner.type isEqualToString:@"OdnoklassnikiBanner"]) {
    
        OdnoklassnikiBannerViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"OdnoklassnikiBannerViewController"];
        
        OdnoklassnikiBanner* odnBanner = (OdnoklassnikiBanner*) banner;
        
        
        NSString* urlString = [NSString stringWithFormat:@"http:%@", odnBanner.file.imageURL];
        
        NSURL* imageUrl = [NSURL URLWithString:urlString];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl];
        
        
        vc.bannerTitle = odnBanner.title;
        vc.bannerText = odnBanner.text;
        vc.bannerName = odnBanner.text;
        vc.bannerImage= [self cachedImageForRequest:request];
        
        
        NSString* urlLogoString = [NSString stringWithFormat:@"http:%@", odnBanner.file.imageURL];
        
        NSURL* imageLogoUrl = [NSURL URLWithString:urlLogoString];
        
        NSURLRequest* requestLogo = [NSURLRequest requestWithURL:imageLogoUrl];
        
        //__weak UIImage* weakLogotype = vc.bannerLogoImage;
        
        if (![self cachedImageForRequest:requestLogo]) {
        
        [vc.bannerLogotype setImageWithURLRequest:requestLogo
                                   placeholderImage:nil
         
                                            success: ^(NSURLRequest *request, NSHTTPURLResponse * response, UIImage *image) {
                                                //weakLogotype = image;
                                               // [weakLogotype layoutSubviews];
                                                [self cacheImage:image forRequest:requestLogo];
                                            }
         
                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                
                                            }];
        } else {
        
        vc.bannerLogoImage = [self cachedImageForRequest:requestLogo];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    
    } else if ([banner.type isEqualToString:@"Html5Banner"] || [banner.type isEqualToString:@"ImageOrFlashBanner"]) {
        
        HtmlImageFlashBannerViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"HtmlImageFlashBannerViewController"];
        
        HtmlImageFlashBanner* htmlBanner = (HtmlImageFlashBanner*) banner;
        
        
        NSString* urlString = [NSString stringWithFormat:@"http:%@", htmlBanner.file.imageURL];
        
        NSURL* imageUrl = [NSURL URLWithString:urlString];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl];
        
        
        vc.bannerClickUrl = htmlBanner.clickUrl;
        vc.bannerImage= [self cachedImageForRequest:request];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }


}




#pragma mark - API

-(void)getBannersFromLocalStorage {
    [self getBannersFromServer:NO];
}

-(void)updateBanners:(UIRefreshControl*)refreshControle {
    [self getBannersFromServer:YES];
}

- (void)getBannersFromServer:(BOOL)fromServer {
        
    [[ServerManager sharedManager] getBannersFromServer:fromServer
                                              onSuccess:^(NSDictionary *banners) {
         
        self.bannersDictionary = banners;
        [self.tableView reloadData];
        
        if (self.refreshControl) {
            NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:ruLocale];
            [formatter setDateFormat:@"d MMMM в kk:mm"];
            NSString *title = [NSString stringWithFormat:@"Последнее обновление: %@", [formatter stringFromDate:[NSDate date]]];
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor grayColor]
                                                                        forKey:NSForegroundColorAttributeName];
            NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
            self.refreshControl.attributedTitle = attributedTitle;
            
            [self.refreshControl endRefreshing];
        }
        
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
          NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
     }];
}

#pragma mark - AFImageCache protocol
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:request];
    return image;
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request {
}

#pragma mark - Actions

- (IBAction)SortGroupAction:(UIButton *)sender {
    
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"Фильтр/группировка"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"Фильтр по TGBBanner"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Фильтр по OdnoklassnikiBanner"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Фильтр по Html5Banner"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Фильтр по ImageOrFlashBanner"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Группировка по типу"
                     image:[UIImage imageNamed:@"group_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void) pushMenuItem:(KxMenuItem*)sender {
   
    if ([sender.title isEqualToString:@"Фильтр по TGBBanner"]) {
        
        self.numberOfSections = @1;
        
        NSArray* keys = [self.bannersDictionary allKeys];
        
        for (NSString* key in keys) {
            
            if ([key isEqualToString:@"TGBBanner"]) {
                
                NSUInteger currentIndex = [keys indexOfObject:key];
                self.currentKey = [keys objectAtIndex:currentIndex];
                
            }
        }
        
        
        [SaveLoadSettings saveSettings:self.numberOfSections andCurrentKey:self.currentKey];
        
        [self.tableView reloadData];
        
    } else if ([sender.title isEqualToString:@"Фильтр по OdnoklassnikiBanner"]) {
        
        self.numberOfSections = @1;
        
        NSArray* keys = [self.bannersDictionary allKeys];
        
        for (NSString* key in keys) {
            
            if ([key isEqualToString:@"OdnoklassnikiBanner"]) {
                
                NSUInteger currentIndex = [keys indexOfObject:key];
                self.currentKey = [keys objectAtIndex:currentIndex];
                
            }
        }
        
        [SaveLoadSettings saveSettings:self.numberOfSections andCurrentKey:self.currentKey];
        
        [self.tableView reloadData];
        
    } else if ([sender.title isEqualToString:@"Фильтр по Html5Banner"]) {
        
        self.numberOfSections = @1;
        
        NSArray* keys = [self.bannersDictionary allKeys];
        
        for (NSString* key in keys) {
            
            if ([key isEqualToString:@"Html5Banner"]) {
                
                NSUInteger currentIndex = [keys indexOfObject:key];
                self.currentKey = [keys objectAtIndex:currentIndex];
                
            }
        }
        [SaveLoadSettings saveSettings:self.numberOfSections andCurrentKey:self.currentKey];
        
        [self.tableView reloadData];
        
        
    } else if ([sender.title isEqualToString:@"Фильтр по ImageOrFlashBanner"]) {
        
        self.numberOfSections = @1;
        
        NSArray* keys = [self.bannersDictionary allKeys];
        
        for (NSString* key in keys) {
            
            if ([key isEqualToString:@"ImageOrFlashBanner"]) {
                
                NSUInteger currentIndex = [keys indexOfObject:key];
                self.currentKey = [keys objectAtIndex:currentIndex];
                
            }
        }
        
        [SaveLoadSettings saveSettings:self.numberOfSections andCurrentKey:self.currentKey];
        
        [self.tableView reloadData];
        
    } else if ([sender.title isEqualToString:@"Группировка по типу"]) {
        
        if ([self.numberOfSections integerValue] != self.bannersDictionary.count) {
        
            self.numberOfSections = @(self.bannersDictionary.count);
        
            [SaveLoadSettings saveSettings:self.numberOfSections andCurrentKey:self.currentKey];
            
            [self.tableView reloadData];
        }
    }
    
}


@end
