//
//  ViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-2-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    UIScrollView * _bigScrollView;
}
@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UITextField * psdTextField;
@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    
    UIImageView * bigBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    bigBgImgview.image=[UIImage imageNamed:@"大背景.png"];
    bigBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:bigBgImgview];
    
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    _bigScrollView.backgroundColor=[UIColor clearColor];
    _bigScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_bigScrollView];
    
    UIImageView * smallBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/5.0, self.view.frame.size.width-40, self.view.frame.size.height/2.0)];
    smallBgImgview.image=[UIImage imageNamed:@"登录背景.png"];
    smallBgImgview.userInteractionEnabled=YES;
    [_bigScrollView addSubview:smallBgImgview];
    
    UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, smallBgImgview.frame.size.width, smallBgImgview.frame.size.height/6.0)];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=@"登录界面";
    lab.textColor=[UIColor whiteColor];
    lab.font=[UIFont systemFontOfSize:22];
    [smallBgImgview addSubview:lab];
    
    UIButton * exitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame=CGRectMake(smallBgImgview.frame.size.width-40, (smallBgImgview.frame.size.height/6.0-20)/2.0, 20,20);
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
    [smallBgImgview addSubview:exitBtn];
    
    //用户名和密码

    UIImageView * nameBgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(20, smallBgImgview.frame.size.height*4.0/15.0, smallBgImgview.frame.size.width-40, smallBgImgview.frame.size.height*2.0/15.0)];
    nameBgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
    nameBgImgView.userInteractionEnabled=YES;
    [smallBgImgview addSubview:nameBgImgView];
    
    UIImageView * nameImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户名.png"]];
    nameImgView.frame=CGRectMake(20, 5, nameBgImgView.frame.size.height-10, nameBgImgView.frame.size.height-10);
    [nameBgImgView addSubview:nameImgView];
    
    _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(20+nameBgImgView.frame.size.height-10+5, 5, nameBgImgView.frame.size.width-(20+nameBgImgView.frame.size.height-10+10), nameBgImgView.frame.size.height-10)];
    _nameTextField.placeholder=@"用户名";
    _nameTextField.delegate=self;
   // [_nameTextField becomeFirstResponder];
    [nameBgImgView addSubview:_nameTextField];

    UIImageView * psbBgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(20, smallBgImgview.frame.size.height*7.0/15.0, smallBgImgview.frame.size.width-40, smallBgImgview.frame.size.height*2.0/15.0)];
    psbBgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
    psbBgImgView.userInteractionEnabled=YES;
    [smallBgImgview addSubview:psbBgImgView];
    
    
    UIImageView * psdImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码.png"]];
    psdImgView.frame=CGRectMake(20, 5, psbBgImgView.frame.size.height-10, psbBgImgView.frame.size.height-10);
    [psbBgImgView addSubview:psdImgView];
    
    _psdTextField=[[UITextField alloc] initWithFrame:CGRectMake(20+psbBgImgView.frame.size.height-10+5, 5, psbBgImgView.frame.size.width-(20+psbBgImgView.frame.size.height-10+10), psbBgImgView.frame.size.height-10)];
    _psdTextField.secureTextEntry=YES;
    _psdTextField.placeholder=@"密码";
    _psdTextField.delegate=self;
    [psbBgImgView addSubview:_psdTextField];
    
    UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(20, smallBgImgview.frame.size.height*7.0/10.0, smallBgImgview.frame.size.width-40, smallBgImgview.frame.size.height*2.0/15.0);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮框旧.png"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:22];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [smallBgImgview addSubview:loginBtn];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+(235-self.view.frame.size.height*3.0/10.0));
    _bigScrollView.contentOffset=CGPointMake(0, 235-self.view.frame.size.height*3.0/10.0);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _bigScrollView.contentOffset=CGPointMake(0, 0);
}
-(void)loginBtnClick
{
    [self.view endEditing:YES];
    if ([_nameTextField.text isEqualToString:@""]||[_psdTextField.text isEqualToString:@""])
    {
        NSString * str=@"用户名或密码不能为空！";
        [JTAlertViewAnimation startAnimation:str view:self.view];
    }
    else
    {
        if ([SOAPRequest checkNet])
            {
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_nameTextField.text,@"loginName",[MyMD5 md5:_psdTextField.text],@"password", nil];
                
                NSDictionary * dic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_MobileLoginURL] jsonDic:jsondic]];
                
                if ([[dic objectForKey:@"resultCode"] intValue]==1001)
                {
                    NSString * str=@"用户名或密码已变更或过期，请检测后重新登录";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else if([[dic objectForKey:@"resultCode"] intValue]==2009)
                {
                    NSString * str=@"用户名不存在";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else if([[dic objectForKey:@"resultCode"] intValue]==2010)
                {
                    NSString * str=@"密码不正确";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else if([[dic objectForKey:@"resultCode"] intValue]==1000)
                {
                    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录成功！" delegate:nil cancelButtonTitle:nil   otherButtonTitles:@"OK，我知道了。。", nil];
                    [alertView show];
                    
                    JTUser * user=[[JTUser alloc] init];
                    NSDictionary * userDic=[dic objectForKey:@"user"];
                    user.userID=[[userDic objectForKey:@"id"] intValue];
                    user.loginName=[userDic objectForKey:@"loginName"];
                    user.password=[userDic objectForKey:@"password"];
                    user.userName=[userDic objectForKey:@"userName"];
                    user.headPortraitImgUrlStr=[userDic objectForKey:@"imageValue"];
                    if (user.headPortraitImgUrlStr==nil)
                    {
                        user.headPortraitImgUrlStr=@"";
                    }
                    //user.headPortraitImgUrlStr=@"http://image.qin16.com/imageaddress/iilog/11524/shop201503181438352304491_161240logo.jpg";
                    user.pointsTitle=[userDic objectForKey:@"pointsTitle"];
                    user.userType=[userDic objectForKey:@"userType"];
                    
                    user.userShangjiaType=[NSString stringWithFormat:@"%@",[userDic objectForKey:@"merchantType"]];
                    user.userShangjiaID=[NSString stringWithFormat:@"%@",[userDic objectForKey:@"merchantInfoId"]];
                    user.status=[NSString stringWithFormat:@"%@",[userDic objectForKey:@"status"]];
                    user.EMuserLoginName=[userDic objectForKey:@"easemobUsername"];
                    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
                    appDelegate.appUser=user;
                    
                    
                    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.EMuserLoginName
                                                                        password:user.EMuserLoginName
                                                                      completion:
                     ^(NSDictionary *loginInfo, EMError *error) {
                         //[self hideHud];
                         if (loginInfo && !error) {
                             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:NO];
                             //发送自动登陆状态通知
                             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                             //将旧版的coredata数据导入新的数据库
                             EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                             if (!error) {
                                 error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                                 
                             }
                         }else {
                             switch (error.errorCode) {
                                 case EMErrorServerNotReachable:
                                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                                     break;
                                 case EMErrorServerAuthenticationFailure:
                                     TTAlertNoTitle(error.description);
                                     break;
                                 case EMErrorServerTimeout:
                                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                                     break;
                                 default:
                                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Logon failure"));
                                     break;
                             }
                         }
                     } onQueue:nil];
                    
                    JTPeopleViewController * peopleVC=[[JTPeopleViewController alloc] init];
                    [self.navigationController pushViewController:peopleVC animated:YES];
                }
                else
                {
                    NSString * str=@"服务器异常，请稍后重试...";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
            }
    }
    
}
- (void)exitApplication {
    
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (error && error.errorCode != EMErrorServerNotLogin) {
                [self showHint:error.description];
            }
            else{
                //[[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        } onQueue:nil];
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    UIWindow * window=[UIApplication sharedApplication].keyWindow;
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
