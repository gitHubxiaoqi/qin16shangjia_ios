//
//  JTDianpuPersonalPicViewController.m
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalPicViewController.h"
@interface JTDianpuPersonalPicViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString * _oldImgUrlStr;
    UIImagePickerController * imagePicker;
    UIImageView * photo;
    BOOL isChange;
}
@property(nonatomic,strong)NSString * headImgData;

@end
@implementation JTDianpuPersonalPicViewController
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
    if(isChange==0)
    {
        [self sendPost];
        [self readyUIAgain];
    }
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isChange=0;
    _oldImgUrlStr=@"";
    self.headImgData=@"";
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
    navTitailLab.text=@"店铺封面设置";
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
    

    
    UIButton * tiJiaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tiJiaoBtn.frame=CGRectMake(50, 64+150+20, self.view.frame.size.width-100, 30);
    [tiJiaoBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮框旧.png"] forState:UIControlStateNormal ];
    [tiJiaoBtn setTitle:@"修改照片" forState:UIControlStateNormal];
    [tiJiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tiJiaoBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [tiJiaoBtn addTarget:self action:@selector(tiJiaoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoBtn];
    
    
}
-(void)readyUIAgain
{
    photo=[[UIImageView alloc] initWithFrame:CGRectMake(25, 64+15, self.view.frame.size.width-25*2, 120)];
    photo.contentMode=UIViewContentModeScaleAspectFit;
    [photo setImageWithURL:[NSURL URLWithString:_oldImgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    [self.view addSubview:photo];
}

-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tiJiaoBtn:(UIButton *)sender
{
    if (isChange==0)
    {
        UIActionSheet *sheet;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
        else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        
        sheet.tag = 255;
        
        [sheet showInView:self.view];
        isChange=1;
        [sender setTitle:@"提交" forState:UIControlStateNormal];
        
    }
    else if (isChange==1)
    {
        AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
        
        
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appDelegate.appUser.userShangjiaID],@"id",_headImgData,@"cover", nil];
            NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SaveMerchantShopCover] jsonDic:jsondic]];
            if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"封面图片修改成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
        }

        isChange=0;
        [sender setTitle:@"修改照片" forState:UIControlStateNormal];
    }
    
    
}
#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        

        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
    
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage * savedImage=[NSString  fixOrientation:[[UIImage alloc] initWithContentsOfFile:fullPath]];
    [photo setImage:savedImage];
    
    // NSData * data=UIImagePNGRepresentation(savedImage);
    NSData *data=UIImageJPEGRepresentation(savedImage, 0.0001);
    self.headImgData=[data base64EncodedString];
    
    self.headImgData = [self.headImgData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    self.headImgData = [self.headImgData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.headImgData = [self.headImgData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

-(void)sendPost
{
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appDelegate.appUser.userShangjiaID],@"id", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetMerchantShopCover] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            
            _oldImgUrlStr=[zaojiaoDic objectForKey:@"picUrl"];
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }

    }

}
@end
