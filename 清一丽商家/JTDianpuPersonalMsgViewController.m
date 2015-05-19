//
//  JTDianpuPersonalMsgViewController.m
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalMsgViewController.h"
#import "JTCustomView.h"

@interface JTDianpuPersonalMsgViewController()<UITextViewDelegate,UITextFieldDelegate>
{
    UIScrollView * _bigScrollView;
     NSArray * _placeHoderStrArr;
}
@property(nonatomic ,strong)JTSortModel * model;
@end

@implementation JTDianpuPersonalMsgViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self sendPost];
    [self refreshUI1];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _placeHoderStrArr=[[NSArray alloc] initWithObjects:@"",@"请对店铺进行简述",@"",@"",@"请填写有效地址", nil];
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
    navTitailLab.text=@"店铺基本信息";
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
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.height-64);
    _bigScrollView.userInteractionEnabled=YES;
    _bigScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_bigScrollView];
    
    
    //11111111111111111
    
    JTCustomView * view1=[[JTCustomView alloc] init];
     view1.backgroundColor=[UIColor clearColor];
    view1.frame=CGRectMake(10, 10, self.view.frame.size.width-20, 40);
    view1.smallLab.text=@"店铺名称：";
    view1.textFiled.placeholder=@"请填写店铺名称";
    view1.textFiled.delegate=self;
    
    view1.textFiled.tag=41;
    view1.tag=21;
    view1.maxCount=30;
    
    view1.textFiled.keyboardType=UIKeyboardTypeDefault;
   
    [_bigScrollView addSubview:view1];
    
    //22222222222222222222
    UIView * view2=[[UIView alloc] init];
     view2.backgroundColor=[UIColor clearColor];
    view2.frame=CGRectMake(10, 10+view1.frame.size.height+10, self.view.frame.size.width-20, 40);
    view2.tag=22;
    view2.userInteractionEnabled=YES;
    [_bigScrollView addSubview:view2];
    
    UILabel * smallLab2=[[UILabel alloc] initWithFrame:CGRectMake(5, view2.frame.size.height/2-20, 85, 40)];
    smallLab2.textAlignment=NSTextAlignmentCenter;
    smallLab2.textColor=[UIColor blackColor];
    smallLab2.font=[UIFont systemFontOfSize:17];
    smallLab2.text=@"店铺描述：";
    [view2 addSubview:smallLab2];
    
    UITextView * textView2=[[UITextView alloc] init];
    textView2.frame=CGRectMake(90, 5, self.view.frame.size.width-20-90-10, 30);
    textView2.tag=42;
    textView2.text=@"";
    textView2.delegate=self;
    textView2.backgroundColor=[UIColor clearColor];
    [view2 addSubview:textView2];
    
    UILabel * placeHolderLab2=[[UILabel alloc] init];
    placeHolderLab2.frame=CGRectMake(2, 0, self.view.frame.size.width-20-90-10, 30);
    placeHolderLab2.tag=2+60;
    placeHolderLab2.text =[_placeHoderStrArr objectAtIndex:textView2.tag-41];;
    placeHolderLab2.enabled = NO;//lable必须设置为不可用
    placeHolderLab2.textColor=[UIColor lightGrayColor];
    placeHolderLab2.textAlignment=NSTextAlignmentLeft;
    placeHolderLab2.font=[UIFont systemFontOfSize:14];
    placeHolderLab2.backgroundColor = [UIColor clearColor];
    [textView2 addSubview:placeHolderLab2];
    

    
    //33333333333333333333333333
    
    JTCustomView * view3=[[JTCustomView alloc] init];
     view3.backgroundColor=[UIColor clearColor];
    view3.frame=CGRectMake(10, 10+view1.frame.size.height+10+view2.frame.size.height+10, self.view.frame.size.width-20, 40);
    view3.smallLab.text=@"联 系 人：";
    view3.textFiled.placeholder=@"汉字或字母";
    view3.textFiled.delegate=self;
    view3.textFiled.tag=43;
    view3.tag=23;
    view3.maxCount=15;
    [_bigScrollView addSubview:view3];
    
    //444444444444444444444444444
    
    JTCustomView * view4=[[JTCustomView alloc] init];
     view4.backgroundColor=[UIColor clearColor];
    view4.frame=CGRectMake(10, 10+view1.frame.size.height+10+view2.frame.size.height+10+view3.frame.size.height+10, self.view.frame.size.width-20, 40);
    view4.smallLab.text=@"联系电话：";
    view4.textFiled.placeholder=@"手机或固话";
    view4.textFiled.delegate=self;
    view4.textFiled.tag=44;
    view4.tag=24;
    view4.maxCount=11;
    view4.textFiled.keyboardType=UIKeyboardTypeNumberPad;
    [_bigScrollView addSubview:view4];

    
    //5555555555555555555555555555555555
    UIView * view5=[[UIView alloc] init];
     view5.backgroundColor=[UIColor clearColor];
    view5.frame=CGRectMake(10, 10+view1.frame.size.height+10+view2.frame.size.height+10+view3.frame.size.height+10+view4.frame.size.height+10, self.view.frame.size.width-20, 40);
    view5.tag=25;
    view5.userInteractionEnabled=YES;
    [_bigScrollView addSubview:view5];
    
    UILabel * smallLab5=[[UILabel alloc] initWithFrame:CGRectMake(5, view2.frame.size.height/2-20, 85, 40)];
    smallLab5.textAlignment=NSTextAlignmentCenter;
    smallLab5.textColor=[UIColor blackColor];
    smallLab5.font=[UIFont systemFontOfSize:17];
    smallLab5.text=@"联系地址：";
    [view5 addSubview:smallLab5];
    
    UITextView * textView5=[[UITextView alloc] init];
    textView5.frame=CGRectMake(90, 5, self.view.frame.size.width-20-90-10, 30);
    textView5.tag=45;
    textView5.text=@"";
    textView5.delegate=self;
    textView5.backgroundColor=[UIColor clearColor];
    [view5 addSubview:textView5];
    
    UILabel * placeHolderLab5=[[UILabel alloc] init];
    placeHolderLab5.frame=CGRectMake(2, 0, self.view.frame.size.width-20-90-10, 30);
    placeHolderLab5.tag=5+60;
    placeHolderLab5.text =[_placeHoderStrArr objectAtIndex:textView5.tag-41];;
    placeHolderLab5.enabled = NO;//lable必须设置为不可用
    placeHolderLab5.textColor=[UIColor lightGrayColor];
    placeHolderLab5.textAlignment=NSTextAlignmentLeft;
    placeHolderLab5.font=[UIFont systemFontOfSize:14];
    placeHolderLab5.backgroundColor = [UIColor clearColor];
    [textView5 addSubview:placeHolderLab5];
    
    
    //修改按钮
    UIButton * fbBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    fbBtn.tag=80;
    [fbBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮框旧.png"] forState:UIControlStateNormal];
    [fbBtn setTitle:@"修    改" forState:UIControlStateNormal];
    [fbBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fbBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    fbBtn.frame=CGRectMake((self.view.frame.size.width-120)/2.0, 10+5*50+20, 120, 40);
    [fbBtn addTarget:self action:@selector(xiugaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:fbBtn];
    [self refreshUI];
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20);
    
    
}
-(void)refreshUI1
{
    JTCustomView *  view1=(JTCustomView *)[_bigScrollView viewWithTag:21];
    JTCustomView *  view3=(JTCustomView *)[_bigScrollView viewWithTag:23];
    JTCustomView *  view4=(JTCustomView *)[_bigScrollView viewWithTag:24];
    UITextView * textView2=(UITextView *)[_bigScrollView viewWithTag:42];
    UITextView * textView5=(UITextView *)[_bigScrollView viewWithTag:45];
    view1.textFiled.text=self.model.title;
    view3.textFiled.text=self.model.linkman;
    view4.textFiled.text=self.model.tel;
    textView2.text=self.model.description1;
    textView5.text=self.model.infoAddress;
    [self textViewDidChange:textView2];
    [self textViewDidChange:textView5];
    [self refreshUI];
}
#pragma mark-输入框代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIView *  view2=[_bigScrollView viewWithTag:22];
    UIView *  view5=[_bigScrollView viewWithTag:25];
    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20+216+40);
}
-(void)textViewDidChange:(UITextView *)textView
{
    UILabel * placeHoderLab=(UILabel *)[textView viewWithTag:textView.tag+20];
    
    if (textView.text.length == 0)
    {
        placeHoderLab.text =[_placeHoderStrArr objectAtIndex:textView.tag-41];
        textView.frame=CGRectMake(90,5, self.view.frame.size.width-20-90-10, 30);
    }
    else
    {
        placeHoderLab.text = @"";
        textView.font=[UIFont systemFontOfSize:14];
        CGSize autoSize=[textView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20-90-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :textView.font} context:nil].size;
        if (autoSize.height<30)
        {
            autoSize.height=30;
        }
        textView.frame=CGRectMake(90,5, self.view.frame.size.width-20-90-10, autoSize.height);
        [textView superview].bounds=CGRectMake(0, 0, self.view.frame.size.width-20, autoSize.height+10);
        
        UIView *  view2=[_bigScrollView viewWithTag:22];
        UIView *  view5=[_bigScrollView viewWithTag:25];
        
        _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20+216+40);
        [self refreshUI];
    }
}
-(void)refreshUI
{
    int height=10;
    for (int i=1; i<6; i++)
    {
        UIView * aView=[_bigScrollView viewWithTag:i+20];
        if (i>1)
        {
            CGRect rect=aView.frame;
            rect.origin.y=height;
            aView.frame=rect;
        }
        height+=aView.frame.size.height+10;
    }
    UIView *  view2=[_bigScrollView viewWithTag:22];
    UIView *  view5=[_bigScrollView viewWithTag:25];

    UIButton * fbBtn=(UIButton *)[_bigScrollView viewWithTag:80];
    CGRect rect=fbBtn.frame;
    rect.origin.y=10+3*50+view2.frame.size.height+view5.frame.size.height+20;
    fbBtn.frame=rect;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    UIView *  view2=[_bigScrollView viewWithTag:22];
    UIView *  view5=[_bigScrollView viewWithTag:25];
    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20);
}

#pragma mark-textField代理方法

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView *  view2=[_bigScrollView viewWithTag:22];
    UIView *  view5=[_bigScrollView viewWithTag:25];
    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20+216+40);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    JTCustomView * view=(JTCustomView *)[textField superview];
    if (range.location>=view.maxCount)
    {
        return NO;
    }
    return YES;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    UIView *  view2=[_bigScrollView viewWithTag:22];
    UIView *  view5=[_bigScrollView viewWithTag:25];
    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+4*50+view2.frame.size.height+view5.frame.size.height+20);
}

-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sendPost
{
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appDelegate.appUser.userShangjiaID],@"id", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetMerchantShopForEdit] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            NSDictionary * resultDic=[[NSDictionary alloc] initWithDictionary:[zaojiaoDic objectForKey:@"shop"] ];
            _model=[[JTSortModel alloc] init];
            _model.idStr=[resultDic objectForKey:@"id"];
            _model.title=[resultDic objectForKey:@"name"];
            _model.description1=[resultDic objectForKey:@"descript"];
            _model.description1=[NSString filterHTML:_model.description1];
            _model.linkman=[resultDic objectForKey:@"linkman"];
            _model.tel=[resultDic objectForKey:@"tel"];
            _model.provinceIDStr=[resultDic objectForKey:@"provinceId"];
            _model.cityIDStr=[resultDic objectForKey:@"cityId"];
            _model.quIDStr=[resultDic objectForKey:@"regionId"];
            _model.streetIDStr=[resultDic objectForKey:@"streetId"];
            _model.infoAddress=[resultDic objectForKey:@"address"];
          
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }

    }

}
-(void)xiugaiBtnClick
{
    
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    JTCustomView *  view1=(JTCustomView *)[_bigScrollView viewWithTag:21];
    JTCustomView *  view3=(JTCustomView *)[_bigScrollView viewWithTag:23];
    JTCustomView *  view4=(JTCustomView *)[_bigScrollView viewWithTag:24];
    UITextView * textView2=(UITextView *)[_bigScrollView viewWithTag:42];
    UITextView * textView5=(UITextView *)[_bigScrollView viewWithTag:45];
    if ([view1.textFiled.text isEqualToString:@""]||view1.textFiled.text==nil||[view3.textFiled.text isEqualToString:@""]||view3.textFiled.text==nil||[view4.textFiled.text isEqualToString:@""]||view4.textFiled.text==nil||[textView2.text isEqualToString:@""]||textView2.text==nil||[textView5.text isEqualToString:@""]||textView5.text==nil)
    {
        NSString * str=@"请完整填写以上信息";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appDelegate.appUser.userShangjiaID],@"id",view1.textFiled.text,@"name",textView2.text,@"descript",view3.textFiled.text,@"linkMan",view4.textFiled.text,@"tel",_model.provinceIDStr,@"province",_model.cityIDStr,@"city",_model.quIDStr,@"region",_model.streetIDStr,@"street",textView5.text,@"address", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SaveMerchantShopForEdit] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            
            UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"恭喜，店铺信息修改成功！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

@end


