//
//  Card.m
//  PlayCard
//
//  Created by gao on 2019/4/16.
//  Copyright © 2019 58. All rights reserved.
//

#import "Card.h"

//     W w 2 A K Q J 0 9 8 7 6 5 4 3
//
//
@interface Card ()

@property (nonatomic, strong) NSString *p1;
@property (nonatomic, strong) NSString *p2;

@property (nonatomic, strong) NSArray *allNumArray;
@property (nonatomic, strong) NSArray *bigArray;
@end

@implementation Card

- (void)playWithP1:(NSString *)p1 p2:(NSString *)p2 {
    _p1 = p1;
    _p2 = p2;
    
    _allNumArray = @[@"W", @"w", @"2", @"A", @"K", @"Q", @"J", @"0", @"9", @"8", @"7", @"6", @"5", @"4", @"3"];
    _bigArray =  @[@"W", @"w", @"2"];
}

//单牌
- (NSArray *)single:(NSString *)p {
    return [self find:p number:1];
}


//双牌
- (NSArray *)two:(NSString *)p {
    return [self find:p number:2];
}

//仨牌
- (NSArray *)three:(NSString *)p number:(int)num {
    return [self find:p number:3];
}

- (NSArray *)find:(NSString *)p number:(int)num {
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *lastC = nil;      //上张牌
    int lastFindCount = 0;      //找到跟上张相同的次数
    for (int i = 0; i < p.length; i++) {
        NSString *c = [p substringWithRange:NSMakeRange(i, 1)];
        if([lastC isEqualToString:c]) {
            lastFindCount++;
            
            if(lastFindCount == num - 1) {
                NSMutableString *temp = [NSMutableString string];
                for (int j = 0; j < num; j++) {
                    [temp appendString:c];
                }
                [result addObject:temp];//44444
            }
        } else {
            lastFindCount = 0;
        }
        
        lastC = c;
    }
    
    return [result copy];
    
}

//顺子
- (NSArray *)succee:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *lastC = nil;      //上张牌
    int lastFindCount = 0;      //找到跟上张相同的次数
    NSMutableArray *lastFindResult = [NSMutableArray array];
    for (int i = 0; i < p.length; i++) {
        NSString *c = [p substringWithRange:NSMakeRange(i, 1)];
        if([_bigArray containsObject:c]) {
            continue;
        }
        
        if([_allNumArray indexOfObject:lastC] - [_allNumArray indexOfObject:c] == 1) {
            lastFindCount++;
            [lastFindResult addObject:c];
            
            if(lastFindCount >= 4) {
                [result addObject:[lastFindResult copy]];//44444
            }
        } else {
            lastFindCount = 0;
            [lastFindResult removeAllObjects];
        }
        
        lastC = c;
    }
    
    return [result copy];
}

//单牌
- (NSArray *)single:(NSString *)p {
    
}

//单牌
- (NSArray *)single:(NSString *)p {
    
}

//单牌
- (NSArray *)single:(NSString *)p {
    
}

//单牌
- (NSArray *)single:(NSString *)p {
    
}

//炸弹
- (NSArray *)bomb:(NSString *)p {
    return [self find:p number:4];
}

@end
