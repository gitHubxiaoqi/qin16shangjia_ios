//
//  JTSendMessageViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-12.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTSendMessageViewController.h"

@interface JTSendMessageViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UIScrollView * _bigScrollView;
    UITextView * _textView;
}
@end

@implementation JTSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"消息中心";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:22];
    [navBgImgview addSubview:navTitailLab];
    
    UIImageView * bigBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44)];
    bigBgImgview.image=[UIImage imageNamed:@"大背景.png"];
    bigBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:bigBgImgview];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 80, NAV_HEIGHT);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navBgImgview addSubview:leftBtn];
    
    UIImageView * backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView.frame=CGRectMake(20, (NAV_HEIGHT-15)/2, 10, 15);
    [leftBtn addSubview:backImgView];
    
    
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _bigScrollView.userInteractionEnabled=YES;
    [self.view addSubview:_bigScrollView];
    
    
    UIImageView * textViewBgImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录按钮框.png"]];
    textViewBgImgView.tag=60;
    textViewBgImgView.frame=CGRectMake(8,8, SCREEN_WIDTH-16, 144);
    [_bigScrollView addSubview:textViewBgImgView];
    
    _textView=[[UITextView alloc] init];
    _textView.frame=CGRectMake(10,10, SCREEN_WIDTH-20,140);
    _textView.textColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:14];
    _textView.delegate=self;
    _textView.backgroundColor=[UIColor clearColor];
    [_bigScrollView addSubview:_textView];
    
    UILabel * placeHolderLab=[[UILabel alloc] init];
    placeHolderLab.frame=CGRectMake(2, 0, 200, 30);
    placeHolderLab.text = @"想要告诉会员点儿什么呢。。";
    placeHolderLab.tag=40;
    placeHolderLab.textColor=[UIColor grayColor];
    //placeHolderLab.enabled = NO;//lable必须设置为不可用
    placeHolderLab.font=[UIFont systemFontOfSize:16];
    placeHolderLab.backgroundColor = [UIColor clearColor];
    [_textView addSubview:placeHolderLab];
    
    
    UIButton * commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame=CGRectMake(10,8+CGRectGetHeight(textViewBgImgView.frame)+15, SCREEN_WIDTH-20, 35);
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮框旧.png"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"推送消息" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commentBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    commentBtn.tag=50;
    [commentBtn addTarget:self action:@selector(commentBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:commentBtn];

}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIImageView * textViewBgImgView=(UIImageView *)[_bigScrollView viewWithTag:60];
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 8+textViewBgImgView.frame.size.height+15+35+253+10);
}
-(void)textViewDidChange:(UITextView *)textView
{
    UILabel * placeHoderLab=(UILabel *)[textView viewWithTag:40];
    
    if (textView.text.length == 0)
    {
        placeHoderLab.text =@"想要告诉会员点儿什么呢。。";
    }
    else
    {
        placeHoderLab.text = @"";
        NSDictionary * dic=[[NSDictionary alloc] initWithObjectsAndKeys:textView.font,NSFontAttributeName, nil];
        CGSize autoSize=[textView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        if (autoSize.height<140)
        {
            autoSize.height=140;
        }
        textView.frame=CGRectMake(10,10, self.view.frame.size.width-20, autoSize.height);
        UIImageView * textViewBgImgView=(UIImageView *)[_bigScrollView viewWithTag:60];
        textViewBgImgView.frame=CGRectMake(8,8, self.view.frame.size.width-8*2, autoSize.height+4);
        UIButton * commentBtn=(UIButton *)[_bigScrollView viewWithTag:50];
        commentBtn.frame=CGRectMake(10,10+autoSize.height+15, self.view.frame.size.width-20, 35);

        _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width,10+autoSize.height+50+10+253);
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    UIImageView * textViewBgImgView=(UIImageView *)[_bigScrollView viewWithTag:60];
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 8+textViewBgImgView.frame.size.height+50+10);
}
-(void)commentBtn
{
    [self.view endEditing:YES];
    if ([_textView.text isEqualToString:@""])
    {
        NSString * str=@"推送内容不能为空...";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"亲，确定向会员发送此消息吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0)
    {
        
        if ([SOAPRequest checkNet])
        {
            AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"userId",_textView.text,@"message",nil];
            NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Jpush_SendMessageMerchant] jsonDic:jsondic]];
            
            if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"推送成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK，我知道了。。", nil];
                [alertView show];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
        }

    }
    else
    {
    }

}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
