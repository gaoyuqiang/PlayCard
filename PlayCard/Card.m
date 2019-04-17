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

- (instancetype)initWithP1:(NSString *)p1 p2:(NSString *)p2 {
    if(self = [super init]) {
        _p1 = p1;
        _p2 = p2;
        
        _allNumArray = @[@"W", @"w", @"2", @"A", @"K", @"Q", @"J", @"0", @"9", @"8", @"7", @"6", @"5", @"4", @"3"];
        _bigArray =  @[@"W", @"w", @"2"];
    }
    return self;
}

//单牌
- (NSArray *)single:(NSString *)p {
//    return [self find:p number:1];
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < p.length; i++) {
        NSString *ch = [p charStrOfIndex:i];
        if(![result containsObject:ch]) {
            [result addObject:ch];
        }
    }
    return [result copy];
}


//双牌
- (NSArray *)two:(NSString *)p {
    return [self find:p number:2];
}

//仨牌
- (NSArray *)three:(NSString *)p {
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
- (NSArray *)succee:(NSString *)p length:(int)length {
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *lastC = nil;      //上张牌
    int lastFindCount = 0;      //找到跟上张相同的次数
    NSMutableString *lastFindStr = [NSMutableString string];
    for (int i = 0; i < p.length; i++) {
        NSString *c = [p substringWithRange:NSMakeRange(i, 1)];
        if([_bigArray containsObject:c]) {
            continue;
        }
        if([c isEqualToString:lastC]) {
            continue;
        }
        
        if([_allNumArray indexOfObject:lastC] == [_allNumArray indexOfObject:c] - 1) {
            lastFindCount++;
            [lastFindStr appendString:c];

            if(lastFindCount >= length - 1) {
                [result addObject:[lastFindStr substringFromIndex:lastFindStr.length - length]];//44444
            }
        } else {
            lastFindCount = 0;
            lastFindStr = [NSMutableString stringWithString:c];
        }
        
        lastC = c;
    }
    
    return [result copy];
}

//三带一   w222AKKKJ9993
- (NSArray *)threeAndOne:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    //三张牌数组
    NSMutableArray *threeArray = [[self find:p number:3] mutableCopy];
    //单牌数组
    NSArray *singleArray = [self single:p];
    
    for (NSString *str in threeArray) {
        for (NSString *singleStr in singleArray) {
            if(![[str substringToIndex:1] isEqualToString:singleStr]) {//除了三个以外的任意单牌
                NSString *temp = [str stringByAppendingString:singleStr];
                [result addObject:temp];
            }
        }
    }
    
    return [result copy];
}

//三带2   w222AA KKKJJ 99933
- (NSArray *)threeAndTwo:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    //三张牌数组
    NSMutableArray *threeArray = [[self find:p number:3] mutableCopy];
    //对牌数组
    NSArray *twoArray = [self find:p number:2];
    
    for (NSString *str in threeArray) {
        for (NSString *twoStr in twoArray) {
            if(![[str substringToIndex:1] isEqualToString:[twoStr substringToIndex:1]]) {//除了三个以外的任意对牌
                NSString *temp = [str stringByAppendingString:twoStr];
                [result addObject:temp];
            }
        }
    }
    
    return [result copy];

}

//四带二   w2222AKKKKJJ9994433 （可以是对）
- (NSArray *)fourAndTwo:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    //四张牌数组
    NSMutableArray *fourArray = [[self find:p number:4] mutableCopy];

    for (NSString *str in fourArray) {
        NSString *tempP = [p stringByReplacingOccurrencesOfString:str withString:@""];
        
        for (int j = 0; j < tempP.length - 1; j++) {
            for (int k = j+1; k < tempP.length ; k++) {
                NSString *resultStr = [NSString stringWithFormat:@"%@%@%@", str, [tempP charStrOfIndex:j], [tempP charStrOfIndex:k]];
                if(![result containsObject:resultStr]) {
                    [result addObject:resultStr];
                }
            }
        }
    }
    
    return [result copy];
}

//四带两对   w2222AKKKKJJ9994433 （可以是对）
- (NSArray *)fourAndDouble:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    //四张牌数组
    NSMutableArray *fourArray = [[self find:p number:4] mutableCopy];

    for (NSString *str in fourArray) {
        NSString *tempP = [p stringByReplacingOccurrencesOfString:str withString:@""];
        NSMutableArray *twoArray = [[self find:tempP number:2] mutableCopy];

        for (int j = 0; j < twoArray.count - 1; j++) {
            for (int k = j+1; k < twoArray.count ; k++) {
                NSString *resultStr = [NSString stringWithFormat:@"%@%@%@", str, twoArray[j], twoArray[k]];
                if(![result containsObject:resultStr]) {
                    [result addObject:resultStr];
                }
            }
        }
    }
    return [result copy];
}

//连对
- (NSArray *)succeeDouble:(NSString *)p length:(int)length {//最少3对
    NSMutableArray *result = [NSMutableArray array];
    
    //对牌数组
    NSMutableArray *twoArray = [[self find:p number:2] mutableCopy];
    NSMutableString *singleStr = [NSMutableString string];
    for (NSString *twoStr in twoArray) {
        [singleStr appendString:[twoStr charStrOfIndex:0]];
    }
    NSArray *resultTemp = [self succee:singleStr length:length];
    for (NSString *tempStr in resultTemp) {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < tempStr.length; i++) {
            NSString *ss = [tempStr charStrOfIndex:i];
            [str appendFormat:@"%@%@", ss, ss];
        }
        [result addObject:str];
    }

    return [result copy];
}

////TODO:    拖拉机
//- (NSArray *):(NSString *)p length:(int)length {//最少3对
//    NSMutableArray *result = [NSMutableArray array];
//
//    return [result copy];
//}
////单牌
//- (NSArray *)single:(NSString *)p {
//
//}

- (NSArray *)wangzha:(NSString *)p {
    if([p containsString:@"Ww"]) {
        return @[@"Ww"];
    }
    return @[];
}

//炸弹
- (NSArray *)bomb:(NSString *)p {
    return [self find:p number:4];
}

@end

@implementation NSString (subChar)

- (NSString *)charStrOfIndex:(int)index {
    return [self substringWithRange:NSMakeRange(index, 1)];
}

@end
