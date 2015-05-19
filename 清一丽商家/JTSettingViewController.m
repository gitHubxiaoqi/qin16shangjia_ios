//
//  JTSettingViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-5.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTSettingViewController.h"
#import "JTGOChangePswViewController.h"
#import "JTSettingAboutViewController.h"

@interface JTSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    UITableView * _tabView;
    NSArray * _titleArr;
    int fileCount;
}

@end

@implementation JTSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fileCount=0;
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
    navTitailLab.text=@"设置";
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
    
    //表
    _tabView=[[UITableView alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 132) style:UITableViewStylePlain];
    _tabView.dataSource=self;
    _tabView.delegate=self;
    _tabView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tabView];
    _titleArr=@[@"修改密码",@"清理缓存",@"关于"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.text=[_titleArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor=[UIColor whiteColor];
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
        imgView.frame=CGRectMake(self.view.frame.size.width-20-20, 17, 8, 10);
        [cell addSubview:imgView];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            JTGOChangePswViewController * vc=[[JTGOChangePswViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            [self clearCache];
        }
            break;
        case 2:
        {
            JTSettingAboutViewController * vc=[[JTSettingAboutViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }

}
-(void)clearCache
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       fileCount=[[NSString stringWithFormat:@"%ld",[files count]] intValue];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}
-(void)clearCacheSuccess
{
    NSString * str=@"";
    if (fileCount!=0)
    {
      str=[NSString stringWithFormat:@"清一丽为您成功清理掉%d个缓存文件",fileCount];
    }
    else
    {
      str=@"没有要清理的文件";
    }
    [JTAlertViewAnimation startAnimation:str view:self.view];
}

-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
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
