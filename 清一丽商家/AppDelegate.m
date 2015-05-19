//
//  AppDelegate.m
//  清一丽商家后台
//
//  Created by 小七 on 15-2-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"

@interface AppDelegate ()<UIAlertViewDelegate,IChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (SIMULATOR==0)
    {
        //极光推送
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
        [APService setupWithOption:launchOptions];

    }
    
    self.viewController=[[ViewController alloc] init];
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController=nav;
    
     [self onCheckVersion];
    

        [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}
-(void)onCheckVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_GetLastIOSVersionForMerchant] jsonDic:@{}]];
        if ( [[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            NSString *lastVersion =[[zaojiaoDic objectForKey:@"version"] objectForKey:@"versionCode"];
            if (![lastVersion isEqualToString:currentVersion]&&[lastVersion floatValue]>[currentVersion floatValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"更新", nil];
                [alert show];
            }
            
        }
        
    }

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/qyli/id975978285?mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }

}
#pragma mark---- 注册推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}
#pragma mark ----  推送注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error
{
    
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"&&&&&&&&&&&%@",userInfo);
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"通知" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok,我知道了", nil];
    [alert show];
      //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
