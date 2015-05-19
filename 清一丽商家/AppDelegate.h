//
//  AppDelegate.h
//  清一丽商家后台
//
//  Created by 小七 on 15-2-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)JTUser * appUser;

@end

