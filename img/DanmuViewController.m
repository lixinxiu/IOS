//
//  DanmuViewController.m
//  海道生鲜
//
//  Created by Anna on 16/4/26.
//  Copyright © 2016年 wangyilin. All rights reserved.
//

#import "DanmuViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface DanmuViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isOpened;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器

@end

@implementation DanmuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
    self.isOpened = false;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addlabel) userInfo:nil repeats:YES];
    
    [self.timer setFireDate:[NSDate distantFuture]];
    [self _initSwitch];
    [self _returnBtn];
}

//转换成横屏显示
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
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

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
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
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addlabel{
    
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    NSInteger height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect = CGRectMake(width, rand()%height, 100, 50);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"String" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *str_1 = [dict objectForKey:@"string1"];
    NSString *str_2 = [dict objectForKey:@"string2"];
    NSString *str_3 = [dict objectForKey:@"string3"];
    NSString *str_4 = [dict objectForKey:@"string4"];
    NSString *str_5 = [dict objectForKey:@"string5"];
    NSMutableArray *array= [NSMutableArray array];
    [array addObject:str_1];
    [array addObject:str_2];
    [array addObject:str_3];
    [array addObject:str_4];
    [array addObject:str_5];
    
    int index = rand()%array.count;
    label.text = array[index];
    
    //NSArray *content = [NSArray arrayWithObjects:@"字符串1",@"字符串2",@"字符串3", nil];
    //int index = rand()%content.count;
    //label.text = content[index];
    
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    //NSLog(@"正在打印");
    
    //添加完成之后，label需要移动
    [self movelabel:label];
}

- (void) movelabel: (UILabel *)label{
    [UIView animateWithDuration:8 animations:^{
        label.frame = CGRectMake(0-label.frame.size.width, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
    } completion:^(BOOL finished){
        [label removeFromSuperview];
    }];
    
}

//手动添加按钮，开启弹幕和关闭按钮弹幕
- (void) _initSwitch{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 80, 50);
    [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void) clickedBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (self.isOpened) {
        [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
        self.isOpened = NO;
        [self removeLabels];
    }
    else{
        [btn setTitle:@"关闭弹幕" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate date]];
        self.isOpened = YES;
    }
    //改变title内容
    
}

- (void) _returnBtn{
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(100, 10, 80, 50);
    [returnBtn setTitle:@"退出" forState:UIControlStateNormal];
    [returnBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(clickedRetrun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
}

- (void)clickedRetrun:(id)sender{
    
    [self.moviePlayer stop];
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"jiugongge"];
    [self presentModalViewController:myview animated:YES];
    
}

- (void)removeLabels{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
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
