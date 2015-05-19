//
//  JTDianpuPersonalGoodsDetailViewController.m
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalGoodsDetailViewController.h"

@interface JTDianpuPersonalGoodsDetailViewController()<UIWebViewDelegate>
{
   
    UIScrollView * _bigScrollView;
    UIWebView * _webView;
}
@property(nonatomic ,strong)JTSortModel * model;
@end
@implementation JTDianpuPersonalGoodsDetailViewController
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
- (void)viewDidLoad
{
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
    navTitailLab.text=@"商品详情";
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
    _bigScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_bigScrollView];
}
-(void)readyUIAgain
{
    UILabel * nameLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 65, 20)];
    nameLab.text=@"商品名称:";
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
    detailLab.text=@"商品信息:";
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

    priceLab.text=@"商品价格:";
    priceLab.font=[UIFont systemFontOfSize:15];
    priceLab.textColor=[UIColor blackColor];
    priceLab.textAlignment=NSTextAlignmentRight;
    priceLab.tag=30;
    [_bigScrollView addSubview:priceLab];
    
    UILabel * priceValueLab=[[UILabel alloc] initWithFrame:CGRectMake(95,10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10, self.view.frame.size.width-65-40, 20)];
    if(self.model.cost==nil)
    {
        self.model.cost=@"0";
    }
    priceValueLab.text=[NSString stringWithFormat:@"%@元",self.model.cost];
    priceValueLab.font=[UIFont systemFontOfSize:14];
    priceValueLab.textColor=[UIColor grayColor];
    priceValueLab.textAlignment=NSTextAlignmentLeft;
    priceValueLab.tag=31;
    [_bigScrollView addSubview:priceValueLab];
    
    UILabel * typeLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10, 65, 20)];
    typeLab.text=@"商品类型:";
    typeLab.font=[UIFont systemFontOfSize:15];
    typeLab.textColor=[UIColor blackColor];
    typeLab.textAlignment=NSTextAlignmentRight;
    typeLab.tag=40;
    [_bigScrollView addSubview:typeLab];
    
    UILabel * typeValueLab=[[UILabel alloc] initWithFrame:CGRectMake(95, 10+nameValueLab.frame.size.height+10+_webView.frame.size.height+10+20+10, self.view.frame.size.width-65-40, 20)];
    typeValueLab.text=self.model.type;
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
    picLab.text=@"商品图片:";
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
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendPost
{
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:self.sortmodel.idStr,@"id", nil];
        
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_getMerchantShopGoodsDetail] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            NSDictionary * resultDic=[[NSDictionary alloc] initWithDictionary:[zaojiaoDic objectForKey:@"shopGoods"] ];
            //_imgUrlArr= [resultDic objectForKey:@"images"];
            _model=[[JTSortModel alloc] init];
            _model=self.sortmodel;
            _model.idStr=[resultDic objectForKey:@"id"];
            _model.fuId=[resultDic objectForKey:@"shopId"];
            _model.title=[resultDic objectForKey:@"name"];
            _model.imgUrlStr=[resultDic objectForKey:@"imgUrl"];
            _model.clickTime=[resultDic objectForKey:@"viewTimes"];
            _model.description1=[resultDic objectForKey:@"description"];
            _model.type=[resultDic objectForKey:@"typeValue"];
            _model.typeID=[resultDic objectForKey:@"type"];
            _model.cost=[resultDic objectForKey:@"price"];
            _model.isCanSeal=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"onShelves"]];
            _model.style=[resultDic objectForKey:@"pickey"];
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }
    
}


@end
