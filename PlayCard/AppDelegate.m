//
//  AppDelegate.m
//  PlayCard
//
//  Created by gao on 2019/4/16.
//  Copyright © 2019 58. All rights reserved.
//

#import "AppDelegate.h"
#import "Card.h"


@interface AppDelegate ()

@property (nonatomic, strong) Card *card;
@property (nonatomic, strong) NSString * p;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
//    NSString *p1 = @"22JJ8888553";
//    NSString *p2 = @"WQQJ099996664";
//        NSString *p1 = @"2K8765444333";
//        NSString *p2 = @"WAQQQJ0088553";
//    NSString *p1 = @"QJ8877663";
//    NSString *p2 = @"2AA00965";
//    NSString *p1 = @"2K98776654";
//    NSString *p2 = @"W2AQJJ964";
//    NSString *p1 = @"KK998773"; //4
//    NSString *p2 = @"A006";
//        NSString *p1 = @"KKJ998644";//5
//        NSString *p2 = @"WwAKQ977643";
//    NSString *p1 = @"2K8877664443"; //6
//    NSString *p2 = @"WwAAKQQQ00974";
//    NSString *p1 = @"2KQ8877664"; //7
//    NSString *p2 = @"2KQ554433";
//    NSString *p1 = @"2KJ00098"; //8
//    NSString *p2 = @"WwAA976";
//      NSString *p1 = @"KKKJ9987653"; //9
//        NSString *p2 = @"Ww2Q0965543";
//        NSString *p1 = @"KQQ76544443"; //10
//        NSString *p2 = @"w22AKQJ999766";
//    NSString *p1 = @"2AKK9665"; //11
//    NSString *p2 = @"2KK988";
//    NSString *p1 = @"QJ09985444"; //12
//    NSString *p2 = @"AAAKKQ988763";
//    NSString *p1 = @"0999876554433"; //13
//    NSString *p2 = @"222AKQJ08753";
    NSString *p1 = @"";
    NSString *p2 = @"";
    p1 = @"2AAQ087654";//14
    p2 = @"2AKJ09877733";
    p1 = @"2KJ7765533";//15
    p2 = @"AQ00";
    p1 = @"WKKJ99554";//16
    p2 = @"22AA9886";
    p1 = @"AQJ8888766543";//17  碰到点小问题，打开日志时居然等了十来秒都没跑完第一组，其实答案是在第二组。后来把日志关了，1.5秒就成功了。后面优化：如果连中有炸弹那么不要带上炸弹
    p2 = @"Ww22KJ9765443";
    p1 = @"Q098765433";//18  猜到了第三组才成功，不过时间耗时才0.5秒
    p2 = @"KKQJ987654";
    p1 = @"22JJ8888553";//19  答案在第8组，耗时0.3s
    p2 = @"WQQJ099996664";
    p1 = @"AKK8887664";//20
    p2 = @"w22AQ97763";
    p1 = @"AQQ855333";//21 第8组 0.31s
    p2 = @"22AQJ00866644";
    p1 = @"2K8765444333";//22
    p2 = @"WAQQQJ0088553";
    p1 = @"KQQJJ0977";//23
    p2 = @"AAKJ098743";
    p1 = @"AAQ77644";//24
    p2 = @"A008";
    p1 = @"AKK008664";//25
    p2 = @"22QJJ88753";
    p1 = @"WwAKQJ0066";//26
    p2 = @"A997777444";
    p1 = @"AKKQJ0433";//27
    p2 = @"AKQJ0955";
    p1 = @"AKK99887443";//28
    p2 = @"wAQQ76";
    p1 = @"2AJ998855";//29
    p2 = @"2QQ0877766643";
    p1 = @"Ww0995533";//30
    p2 = @"AAAKKQ8844";
    p1 = @"228765433";//31
    p2 = @"2QQQQJJJ00984";
    p1 = @"22A05533";//32
    p2 = @"2AJJ";
    p1 = @"KKQ98765433";//34
    p2 = @"AAKJ9876553";
    p1 = @"wQQ98765543";//35
    p2 = @"W22KJ007433";
    p1 = @"2JJ55443";//36
    p2 = @"W007";
    p1 = @"AKKQ088444";//37
    p2 = @"22AAQJJ009776";
    p1 = @"w2AAJJ933";//38
    p2 = @"22AAK0886665";
    p1 = @"Q099664444";//39
    p2 = @"AAJJ77733";
    p1 = @"099888864";//40
    p2 = @"2AAAQJJ965";
    
    p1 = @"2Q999643";//困难1
    p2 = @"WAAJ43";
    p1 = @"QJJ0988744";//困难5
    p2= @"WwAA97633";
    p1 = @"Q0096433";//困难5
    p2 = @"2076633";
    p1 = @"22AQJ99664";//困难9 //这个案例比较特殊  很慢 可以用来分析改进算法
    p2 = @"WAKKQJJ088744";
    
    p1 = @"2Q9766554";//困难10  稍微慢点 可以用来分析改进算法
    p2 = @"KKQJ09766433";
    
    p1 = @"2J00655533";//困难11
    p2 = @"wAAK7763";
    
    p1 = @"KKKJ88533";//困难12
    p2 = @"AAQJJ09553";
    
    p1 = @"K9987533";//困难13
    p2 = @"QJ866";
    p1 = @"WAKQJ8644";//困难14
    p2 = @"22AKQ0097553";
    
    p1 = @"K07755433";//专家1
    p2 = @"Q88664";
    p1 = @"AKJ988653";
    p2 = @"2KJ08854";
    p1 = @"J00777763";
    p2 = @"WAAJ0844";
    p1 = @"AQQJ9988653";
    p2 = @"2KQJJ095433";
    p1 = @"AJ0776554";
    p2 = @"JJ9665";
    p1 = @"K07755433";//专家1
    p2 = @"Q88664";
    

    _card = [[Card alloc] initWithP1:p1 p2:p2 lastCard:@""];
    _card.openlog = YES;
    [_card play:40];

    return YES;
}


- (void)addMethod {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
