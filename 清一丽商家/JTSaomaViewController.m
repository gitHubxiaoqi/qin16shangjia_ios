//
//  JTSaomaViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-13.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTSaomaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZBarSDK.h"
#import "ZBarReaderView.h"
#import "ZBarCameraSimulator.h"

@interface JTSaomaViewController ()<ZBarReaderViewDelegate,UIAlertViewDelegate>
{
    
    
    NSString *_kechengming;
    NSString *_kechengid;
    
}
@property(nonatomic, retain)ZBarReaderView *zbarReaderView;//定义自动扫描界面
@property(nonatomic,retain)ZBarCameraSimulator *zbarCameraSimulator;//定义扫描相机模拟器
@property(nonatomic, retain)UIImageView *scannerLine; //扫描线框
@property(nonatomic, retain)UIImageView *lineView; //扫描线


@end

@implementation JTSaomaViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readyUI];
    [self createReaderView];
    [self getBarcodesControllerViewDidLoad];
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
    navTitailLab.text=@"扫一扫";
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
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createReaderView
{
    
    
    
    _zbarReaderView = [[ZBarReaderView alloc] init];
    //关闭闪光灯
    _zbarReaderView.torchMode = 0;
    
    
    
    
    //背景框
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan.png"]];
    imageview.alpha = 0.5;
    
    
    
    //扫描框
    _scannerLine = [[UIImageView alloc] init];
    _scannerLine.image = [UIImage imageNamed:@"扫描框.png"];
    
    
    
    //扫描线
    UIImage *image1 = [UIImage imageNamed:@"saomiaoLine.png"];
    UIImage *image2 = [UIImage imageNamed:@"saomiaoLine.png"];
    
    NSArray *array = [NSArray arrayWithObjects:image1,image2,nil];
    _lineView = [[UIImageView alloc] init];
    _lineView.animationImages = array;
    [_lineView startAnimating];
    
    
    
    //通知label
    UILabel *label=[[UILabel alloc]init];
    label.numberOfLines=0;
    label.text=@"通知：\n提示入场成功，才能进场参与活动哦~~";
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_zbarReaderView addSubview:label];
    
    
    
    label.frame=CGRectMake((SCREEN_WIDTH-280)/2,SCREEN_HEIGHT-200, 280, 50);
    
    
    
    _zbarReaderView.frame = CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    imageview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    
    
    
    if (SCREEN_HEIGHT==480) {
        _scannerLine.frame = CGRectMake(55, 170, 215, 180);
        _lineView.frame = CGRectMake(65, 170, 190, 0.5);
        
    }else if (SCREEN_HEIGHT==568){
        _scannerLine.frame = CGRectMake(55, 190, 215, 220);
        _lineView.frame = CGRectMake(65,190, 190, 0.5);
        
        
        
    }else if(SCREEN_HEIGHT==667){
        _scannerLine.frame = CGRectMake(65, 212, 252, 270);
        _lineView.frame = CGRectMake(75, 212, 230, 0.5);
        
        
    }else if(SCREEN_HEIGHT==736){
        
        _scannerLine.frame = CGRectMake(75, 232, 272, 295);
        _lineView.frame = CGRectMake(85, 232, 250, 0.5);
        
        
    }
    
    
    
    
    if (SCREEN_HEIGHT==480)
    {
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            _lineView.frame = CGRectMake(60,170+_scannerLine.frame.size.height, 200, 0.5);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else if (SCREEN_HEIGHT==568)
    {
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            _lineView.frame = CGRectMake(60,190+_scannerLine.frame.size.height, 200, 0.5);
            
        } completion:^(BOOL finished) {
            
        }];
    }else if(SCREEN_HEIGHT==667)
    {
        
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            _lineView.frame = CGRectMake(75,212+_scannerLine.frame.size.height-10, 230, 0.5);
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else if(SCREEN_HEIGHT==736)
    {
        
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            _lineView.frame = CGRectMake(85,232+_scannerLine.frame.size.height-10, 250, 0.5);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
    //扫描区域,如果不设置扫描区域，启动扫描功能时镜头会颤动
    CGRect scanMaskRect = CGRectMake(0,0, 400, 500);
    _zbarReaderView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:_zbarReaderView.bounds];
    
    
    
    
    
    [self.view addSubview:_zbarReaderView];
    [self.view addSubview:imageview];
    [self.view addSubview:_lineView];
    [self.view addSubview:_scannerLine];
    
    
    
    
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
- (void)readerView:(ZBarReaderView*)view didReadSymbols:(ZBarSymbolSet*) syms fromImage: (UIImage*) img
{
    
    for(ZBarSymbol *sym in syms)
    {
         
        //刷新扫描缓冲区
        [_zbarReaderView flushCache];
        [_lineView stopAnimating];
        
        NSString *symbolStr = sym.data;
        
        // zbar需要将默认的日文编码改为UTF8，否则扫描会出现乱码
        if ([symbolStr canBeConvertedToEncoding:NSShiftJISStringEncoding])
        {
            symbolStr = [NSString stringWithCString:[symbolStr cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        
        
        //NSLog(@"-------sym.data%@------symbolStr%@",sym.data,symbolStr);
        if(symbolStr!=nil)
        {
            
            if ([SOAPRequest checkNet])
            {
                AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"belongId",symbolStr,@"id",nil];
                NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_recieveRegistration] jsonDic:jsondic]];
                
                if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"恭喜，该券有效，入场成功！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"3005"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，该券已被使用，您不能入场！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"3004"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，该券已过期，您不能入场！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"3003"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，该券非本店活动券，您不能入场！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"3006"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，该券不存在，您不能入场！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"3007"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请注意，券号异常，您不能入场！" message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很抱歉，服务器异常，您暂不能入场，请稍后重试..." message:[NSString stringWithFormat:@"活动券编号：%@",symbolStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道啦。。", nil];
                    [alert show];
                }
            }

            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    [_zbarReaderView stop];
    
    
}
-(void)getBarcodesControllerViewDidLoad
{
    _zbarReaderView.readerDelegate = self;
    if(TARGET_IPHONE_SIMULATOR)
    {
        
        _zbarCameraSimulator = [[ZBarCameraSimulator alloc]initWithViewController: self];
        _zbarCameraSimulator.readerView.backgroundColor = [UIColor redColor];
        _zbarCameraSimulator.readerView = _zbarReaderView;
        
    }
    
    
    
    //关闭扫描线
    _zbarReaderView.tracksSymbols=NO;
    _zbarReaderView.trackingColor = [UIColor clearColor];
    
    _scannerLine.hidden=NO;
    //扫描界面启动扫描
    [_zbarReaderView start];
    
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
