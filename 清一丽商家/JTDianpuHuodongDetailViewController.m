//
//  JTDianpuHuodongDetailViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-2.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuHuodongDetailViewController.h"

@interface JTDianpuHuodongDetailViewController ()<UIWebViewDelegate>
{
    UIScrollView * _bigScrollView;
    UIWebView * _webView;
}
@property(nonatomic ,strong)JTSortModel * model;
@end

@implementation JTDianpuHuodongDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self sendPost];
    CGSize size1=CGSizeMake(self.view.frame.size.width-65-40, MAXFLOAT);
    CGSize autoSize1=[self.model.title boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    if (autoSize1.height<20)
    {
        autoSize1.height=20;
    }
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(95, 20+autoSize1.height, self.view.frame.size.width-10-95, 30)];
    _webView.tag=1111;
    [_webView setScalesPageToFit:NO];
    _webView.scrollView.scrollEnabled=NO;
    _webView.backgroundColor=[UIColor clearColor];
    [_webView loadHTMLString:_model.description1 baseURL:nil];
    _webView.delegate=self;

    [self readyUIAgain];
}
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
    navTitailLab.text=@"活动详情";
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
    
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    _bigScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_bigScrollView];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)readyUIAgain
{
    UILabel * nameLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 65, 20)];
    nameLab.text=@"活动名称:";
    nameLab.font=[UIFont systemFontOfSize:15];
    nameLab.textColor=[UIColor blackColor];
    nameLab.textAlignment=NSTextAlignmentRight;
    nameLab.tag=10;
    [_bigScrollView addSubview:nameLab];
    
    UILabel * nameValueLab=[[UILabel alloc] initWithFrame:CGRectMake(95, 10, self.view.frame.size.width-65-40, 20)];
    nameValueLab.text=self.model.title;
    CGSize size1=CGSizeMake(self.view.frame.size.width-65-40, MAXFLOAT);
    CGSize autoSize1=[nameValueLab.text boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    if (autoSize1.height<20)
    {
        autoSize1.height=20;
    }
    nameValueLab.frame=CGRectMake(95, 10, autoSize1.width, autoSize1.height);
    nameValueLab.font=[UIFont systemFontOfSize:14];
    nameValueLab.textColor=[UIColor grayColor];
    nameValueLab.textAlignment=NSTextAlignmentLeft;
    nameValueLab.numberOfLines=0;
    nameValueLab.tag=11;
    [_bigScrollView addSubview:nameValueLab];
    
    
    UILabel * detailLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10+nameValueLab.frame.size.height+10, 65, 20)];
    detailLab.text=@"活动介绍:";
    detailLab.font=[UIFont systemFontOfSize:15];
    detailLab.textColor=[UIColor blackColor];
    detailLab.textAlignment=NSTextAlignmentRight;
    detailLab.tag=20;
    [_bigScrollView addSubview:detailLab];
    
    while (_webView.tag!=9999)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    [_bigScrollView addSubview:_webView];

    
    UILabel * priceLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10,65, 20)];
    
    priceLab.text=@"活动时间:";
    priceLab.font=[UIFont systemFontOfSize:15];
    priceLab.textColor=[UIColor blackColor];
    priceLab.textAlignment=NSTextAlignmentRight;
    priceLab.tag=30;
    [_bigScrollView addSubview:priceLab];
    
    UILabel * priceValueLab=[[UILabel alloc] initWithFrame:CGRectMake(95,10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10, self.view.frame.size.width-65-40, 20)];
    if(self.model.openTime==nil)
    {
        self.model.openTime=@"暂无";
    }
    priceValueLab.text=[NSString stringWithFormat:@"%@",self.model.openTime];
    priceValueLab.font=[UIFont systemFontOfSize:14];
    priceValueLab.textColor=[UIColor grayColor];
    priceValueLab.textAlignment=NSTextAlignmentLeft;
    priceValueLab.tag=31;
    [_bigScrollView addSubview:priceValueLab];
    
    UILabel * typeLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10, 65, 20)];
    typeLab.text=@"已报名:";
    typeLab.font=[UIFont systemFontOfSize:15];
    typeLab.textColor=[UIColor blackColor];
    typeLab.textAlignment=NSTextAlignmentRight;
    typeLab.tag=40;
    [_bigScrollView addSubview:typeLab];
    
    UILabel * typeValueLab=[[UILabel alloc] initWithFrame:CGRectMake(95, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10, self.view.frame.size.width-65-40, 20)];
    typeValueLab.text=[NSString stringWithFormat:@"%@人(总名额:%@)",self.model.cost,self.model.registTime];
    CGSize size3=CGSizeMake(self.view.frame.size.width-65-40, MAXFLOAT);
    CGSize autoSize3=[typeValueLab.text boundingRectWithSize:size3 options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    if (autoSize3.height<20)
    {
        autoSize3.height=20;
    }
    typeValueLab.frame=CGRectMake(95, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10, autoSize3.width, autoSize3.height);
    typeValueLab.font=[UIFont systemFontOfSize:14];
    typeValueLab.textColor=[UIColor grayColor];
    typeValueLab.textAlignment=NSTextAlignmentLeft;
    typeValueLab.numberOfLines=0;
    typeValueLab.tag=41;
    [_bigScrollView addSubview:typeValueLab];
    
    UILabel * picLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10+typeValueLab.frame.size.height+10+20, 65, 20)];
    picLab.text=@"活动图片:";
    picLab.font=[UIFont systemFontOfSize:15];
    picLab.textColor=[UIColor blackColor];
    picLab.textAlignment=NSTextAlignmentRight;
    picLab.tag=50;
    [_bigScrollView addSubview:picLab];
    
    UIImageView * picValueImgView=[[UIImageView alloc] initWithFrame:CGRectMake(95, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10+typeValueLab.frame.size.height+10, 80, 60)];
    if (self.model.imgUrlStr==nil)
    {
        self.model.imgUrlStr=@"";
    }
    [picValueImgView setImageWithURL:[NSURL URLWithString:self.model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    [_bigScrollView addSubview:picValueImgView];

    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10+typeValueLab.frame.size.height+10+60+20);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=220;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth)*1.5;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    
    CGRect frame = webView.frame;
    frame.size.height= height+5;
    webView.frame = frame;
    webView.tag=9999;
}
-(void)sendPost
{
    
    AppDelegate * appDelegate= [UIApplication sharedApplication].delegate;
    
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:self.sortmodel.idStr,@"id",appDelegate.appUser.userShangjiaID,@"userId", nil];
        
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_shopActivity] jsonDic:jsondic]];
        
        if ([[zaojiaoDic objectForKey:@"resultCode"] intValue]==1000)
        {
            NSDictionary * resultDic=[[NSDictionary alloc] initWithDictionary:[[zaojiaoDic objectForKey:@"model"] objectForKey:@"shopActivity"]];
            //_imgUrlArr= [resultDic objectForKey:@"images"];
            _model=[[JTSortModel alloc] init];
            _model=self.sortmodel;
            _model.imgUrlStr=[resultDic objectForKey:@"imgUrl"];
            _model.title=[resultDic objectForKey:@"name"];
            _model.description1=[resultDic objectForKey:@"description"];
            _model.openTime=[NSString stringWithFormat:@"%@至%@",[resultDic objectForKey:@"startDate"],[resultDic objectForKey:@"endDate"]];
            _model.cost=[resultDic objectForKey:@"registedCount"];
            _model.registTime=[resultDic objectForKey:@"quota"];
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        
    }

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
