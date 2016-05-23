//
//  ViewController.m
//  MyGesture
//
//  Created by Anna on 16/3/15.
//  Copyright © 2016年 li. All rights reserved.
//

#import "ViewController.h"
#import "JKLockView.h"

#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<JKLockViewDelegate>
- (IBAction)fanhui;

//播放器视图控制器
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    //打开用户动作响应事件
//    self.MyLabel.userInteractionEnabled = YES;
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"最长的电影字幕版--音悦tai.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

-(MPMoviePlayerViewController *)moviePlayerViewController{
    if (!_moviePlayerViewController) {
        NSURL *url=[self getFileUrl];
        _moviePlayerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
        [self addNotification];
    }
    return _moviePlayerViewController;
}
#pragma mark - UI事件
- (IBAction)playClick:(UIButton *)sender {
    self.moviePlayerViewController=nil;//保证每次点击都重新创建视频播放控制器视图，避免再次点击时由于不播放的问题
    //    [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
    //注意，在MPMoviePlayerViewController.h中对UIViewController扩展两个用于模态展示和关闭MPMoviePlayerViewController的方法，增加了一种下拉展示动画效果
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
}

#pragma mark - 控制器通知
/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayerViewController.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayerViewController.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayerViewController.moviePlayer.playbackState);
}

//代理方法
-(void)lockView:(JKLockView *)lockView didFinshPath:(NSString *)path
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"myString"];
    
    
    
    if ([path isEqualToString:myString])
    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        
//        [self presentViewController:alert animated:YES completion:nil];
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"Danmu"];
        [self presentModalViewController:myview animated:YES];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)fanhui {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"shouye"];
    [self presentModalViewController:myview animated:YES];
}


@end
