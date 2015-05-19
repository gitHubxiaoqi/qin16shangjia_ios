//
//  JTPeopleViewController.m
//  Qyli
//
//  Created by 小七 on 14-7-29.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTPeopleViewController.h"

#import "JTSettingViewController.h"

#import "JTDianpuPersonalMsgViewController.h"
#import "JTDianpuPersonalPicViewController.h"
#import "JTDianpuPersonalLOGOViewController.h"
#import "JTDianpuPeosonalGoodsListViewController.h"
#import "JTDianpuPersonalDaijinquanViewController.h"
#import "JTDianpuPersonalJiesuanViewController.h"
#import "JTDianpuHuodongViewController.h"
#import "JTSendMessageViewController.h"
#import "JTHuoyuanListViewController.h"
#import "JTHistoryViewController.h"

#import "JTSaomaViewController.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface JTPeopleViewController ()<UIAlertViewDelegate,IChatManagerDelegate>
{

    NSArray * _jigouShangjiaTitleArr;
    NSArray * _jigouShangjiaImgNameArr;

    NSArray * _dianpuShangjiaTitleArr;
    NSArray * _dianpuShangjiaImgNameArr;
    
    UIButton * _exitBtn;
    
    UIScrollView * _bigScrollView;
    
    
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@end

@implementation JTPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    
    [self unregisterNotifications];
}
-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}
// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
//    if (_chatListVC) {
//        if (unreadCount > 0) {
//            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            _chatListVC.tabBarItem.badgeValue = nil;
//        }
//    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _jigouShangjiaTitleArr=[[NSArray alloc] initWithObjects:@"基本信息",@"封面设置",@"LOGO设置",@"我的代金券",@"结算清单",@"课程管理",@"教师管理",@"报名管理", nil];
    _dianpuShangjiaTitleArr=[[NSArray alloc] initWithObjects:@"基本信息",@"封面设置",@"LOGO设置",@"我的代金券",@"结算清单",@"商品管理",@"活动管理",@"我的会员",@"推送消息",@"访问记录",@"在线服务", nil];
    _jigouShangjiaImgNameArr=[[NSArray alloc] initWithObjects:@"基本信息.png",@"封面设置.png",@"LOGO设置.png",@"我的代金券.png",@"结算清单.png",@"商品课程管理.png",@"教师管理.png",@"报名管理.png", nil];
    _dianpuShangjiaImgNameArr=[[NSArray alloc] initWithObjects:@"基本信息.png",@"封面设置.png",@"LOGO设置.png",@"我的代金券.png",@"结算清单.png",@"商品管理.png",@"活动管理.png",@"我的会员.png",@"推送消息.png",@"访问记录.png",@"在线咨询.png",nil];
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    //自定义导航条    
    UIImageView * navBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navBgImgview.image=[UIImage imageNamed:@"小横条.png"];
    navBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:navBgImgview];
    
    UIButton * setBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame=CGRectMake(self.view.bounds.size.width-38, 10, 24, 24);
    [setBtn setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [navBgImgview addSubview:setBtn];
    
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=appDelegate.appUser.userName;
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:22];
    [navBgImgview addSubview:navTitailLab];
    
    UIImageView * bigBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44)];
    bigBgImgview.image=[UIImage imageNamed:@"大背景.png"];
    bigBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:bigBgImgview];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 2, 50, 40);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navBgImgview addSubview:leftBtn];
    
    UIImageView * jiantouImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"扫一扫.png"]];
    jiantouImgView.frame=CGRectMake(20, 12,20, 20);
    [leftBtn addSubview:jiantouImgView];

    
    [self didUnreadMessagesCountChanged];
//把self注册为SDK的delegate
    [self registerNotifications];
    [self setupUnreadMessageCount];
    

    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-70)];
    _bigScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_bigScrollView];
    
    if ([appDelegate.appUser.userType isEqualToString:@"MERCHANT"])
    {
        if([appDelegate.appUser.userShangjiaType intValue]==1)
        {
            for (int i=0; i<_jigouShangjiaTitleArr.count; i++)
            {
                UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:[_jigouShangjiaImgNameArr objectAtIndex:i]] forState:UIControlStateNormal];
                btn.frame=CGRectMake(self.view.frame.size.width/15.0+(i%3)*(self.view.frame.size.width/3.0), 26+(i/3)*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0), self.view.frame.size.width/5.0, self.view.frame.size.width/5.0);
                btn.tag=100+i;
                [btn addTarget:self action:@selector(jigou:) forControlEvents:UIControlEventTouchUpInside];
                [_bigScrollView addSubview:btn];
                
                UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake((i%3)*(self.view.frame.size.width/3.0), 26+self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/8.0+(i/3)*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0), self.view.frame.size.width/3.0, self.view.frame.size.width/5.0/4.0)];
                lab.textAlignment=NSTextAlignmentCenter;
                lab.text=[_jigouShangjiaTitleArr objectAtIndex:i];
                lab.textColor=[UIColor whiteColor];
                lab.font=[UIFont systemFontOfSize:16];
                [_bigScrollView addSubview:lab];
                
                _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 26+self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/8.0+(_jigouShangjiaTitleArr.count-1)/3*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0)+self.view.frame.size.width/5.0/4.0+10);
            }
            
        }
        else if ([appDelegate.appUser.userShangjiaType intValue]==2)
        {
            for (int i=0; i<_dianpuShangjiaTitleArr.count; i++)
            {
                UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:[_dianpuShangjiaImgNameArr objectAtIndex:i]] forState:UIControlStateNormal];
                btn.frame=CGRectMake(self.view.frame.size.width/15.0+(i%3)*(self.view.frame.size.width/3.0), 26+(i/3)*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0), self.view.frame.size.width/5.0, self.view.frame.size.width/5.0);
                btn.tag=200+i;
                [btn addTarget:self action:@selector(dianpu:) forControlEvents:UIControlEventTouchUpInside];
                [_bigScrollView addSubview:btn];
                
                UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake((i%3)*(self.view.frame.size.width/3.0), 26+self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/8.0+(i/3)*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0), self.view.frame.size.width/3.0, self.view.frame.size.width/5.0/4.0)];
                lab.textAlignment=NSTextAlignmentCenter;
                lab.text=[_dianpuShangjiaTitleArr objectAtIndex:i];
                lab.font=[UIFont systemFontOfSize:16];
                lab.textColor=[UIColor whiteColor];
                [_bigScrollView addSubview:lab];
            }
            _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 26+self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/8.0+(_dianpuShangjiaTitleArr.count-1)/3*(self.view.frame.size.width/5.0+self.view.frame.size.width/5.0/2.0)+self.view.frame.size.width/5.0/4.0+10);
        }
        
        
    }
    else
    {
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据异常~" delegate:nil cancelButtonTitle:nil   otherButtonTitles:@"OK，我知道了。。", nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    _exitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame=CGRectMake(20, self.view.frame.size.height-60, self.view.frame.size.width-40, 35);
    [_exitBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮框旧.png"] forState:UIControlStateNormal];
    [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    _exitBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    _exitBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    _exitBtn.titleLabel.textColor=[UIColor whiteColor];
    [_exitBtn addTarget:self action:@selector(shangjiaExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exitBtn];

    

    
}

-(void)setting
{
    JTSettingViewController * setVC=[[JTSettingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}
-(void)jigou:(UIButton *)sender
{
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"抱歉，暂未开放，敬请期待！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK，我知道了。。", nil];
    [alertView show];

}
-(void)dianpu:(UIButton *)sender
{
    switch (sender.tag-200)
    {
        case 0:
        {
            JTDianpuPersonalMsgViewController * msgVC=[[JTDianpuPersonalMsgViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 1:
        {
            JTDianpuPersonalPicViewController * msgVC=[[JTDianpuPersonalPicViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 2:
        {
            JTDianpuPersonalLOGOViewController * msgVC=[[JTDianpuPersonalLOGOViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 3:
        {
            JTDianpuPersonalDaijinquanViewController * msgVC=[[JTDianpuPersonalDaijinquanViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 4:
        {
            JTDianpuPersonalJiesuanViewController * msgVC=[[JTDianpuPersonalJiesuanViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 5:
        {
            JTDianpuPeosonalGoodsListViewController * msgVC=[[JTDianpuPeosonalGoodsListViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
            

        }
            break;
        case 6:
        {
            JTDianpuHuodongViewController * msgVC=[[JTDianpuHuodongViewController alloc] init];
            [self.navigationController pushViewController:msgVC animated:YES];
            
        }
            break;
        case 7:
        {
            JTHuoyuanListViewController * huiyuanVC=[[JTHuoyuanListViewController alloc] init];
            [self.navigationController pushViewController:huiyuanVC animated:YES];
        }
            break;
        case 8:
        {
            JTSendMessageViewController * messageVC=[[JTSendMessageViewController alloc] init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }
            break;
        case 9:
        {
            JTHistoryViewController * historyVC=[[JTHistoryViewController alloc] init];
            [self.navigationController pushViewController:historyVC animated:YES];
        }
            break;
        case 10:
        {
            ListViewController * mainVC=[[ListViewController alloc] init];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
            break;

        default:
            break;
    }
}
-(void)shangjiaExit
{
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定注销当前用户吗？" delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        
    }
    else
    {
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (error && error.errorCode != EMErrorServerNotLogin) {
                [self showHint:error.description];
            }
            else{
                //[[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        } onQueue:nil];
        AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
        appDelegate.appUser=nil;
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)leftBtnCilck
{
    JTSaomaViewController * saomaVC=[[JTSaomaViewController alloc] init];
    [self.navigationController pushViewController:saomaVC animated:YES];
}



// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        [self showNotificationWithMessage:message];
    }else {
        [self playSoundAndVibration];
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    [self showHint:NSLocalizedString(@"receiveCmd", @"receive cmd message")];
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = NSLocalizedString(@"您有一条新消息", @"you have a new message");
    
//去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
