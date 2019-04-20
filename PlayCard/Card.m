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
@property (nonatomic, assign) BOOL p1Turn;

@property (nonatomic, strong) NSArray *allNumArray;
@property (nonatomic, strong) NSArray *bigArray;
@end

@implementation Card {
    NSString * _lastCard;
    int _depth;
    NSString *_bestCard;
}

- (instancetype)initWithP1:(NSString *)p1 p2:(NSString *)p2 {
    if(self = [super init]) {
        _p1 = p1;
        _p2 = p2;
        
        _allNumArray = @[@"W", @"w", @"2", @"A", @"K", @"Q", @"J", @"0", @"9", @"8", @"7", @"6", @"5", @"4", @"3"];
        _bigArray =  @[@"W", @"w", @"2"];
        
        _lastCard = @"";
    }
    return self;
}

- (NSArray *)allKind:(NSString *)p lastCard:(NSString *)lastCard {
    NSMutableArray *result = [NSMutableArray array];
    //me王炸
    NSArray *wangzhaArray = [self wangzha:p];
    //me王炸+炸弹
    NSArray *wangzhaAndBombArray = [wangzhaArray arrayByAddingObjectsFromArray:[self bomb:p]];
    //分析打的上张牌的类型
    if (lastCard.length == 0) {
        //不要=====>
        
        [result addObjectsFromArray:[self wangzha:p]];
        [result addObjectsFromArray:[self bomb:p]];
        [result addObjectsFromArray:[self single:p]];
        [result addObjectsFromArray:[self two:p]];
        [result addObjectsFromArray:[self three:p]];
        for (int i = 5; i <= 12; i++) {
            [result addObjectsFromArray:[self succee:p length:i]];
        }
        [result addObjectsFromArray:[self threeAndOne:p]];
        [result addObjectsFromArray:[self threeAndTwo:p]];
        [result addObjectsFromArray:[self fourAndTwo:p]];
        [result addObjectsFromArray:[self fourAndDouble:p]];
        for (int i = 3; i <= 12; i++) {
            [result addObjectsFromArray:[self succeeDouble:p length:i]];
        }

    } else if (lastCard.length == 1) {
        //单牌=====>
        [result addObjectsFromArray:wangzhaAndBombArray];
        NSArray *biggerArray = [self findBiggerSameType:[self single:p] lastCard:lastCard];
        [result addObjectsFromArray:biggerArray];

    } else if (lastCard.length == 2) {
        if([self two:lastCard].count == 1) {
            //对牌=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self two:p] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
            
        } else if ([self wangzha:lastCard]){
            //王炸=====>
        }
    } else if (lastCard.length == 3) {
        //三牌=====>
        [result addObjectsFromArray:wangzhaAndBombArray];
        NSArray *biggerArray = [self findBiggerSameType:[self three:p] lastCard:lastCard];
        [result addObjectsFromArray:biggerArray];
        
    } else if (lastCard.length == 4) {
        if ([self bomb:lastCard]) {
            //炸弹=====>
            {
                //me王炸
                [result addObjectsFromArray:wangzhaArray];
                //me炸弹
                NSArray *biggerArray = [self findBiggerSameType:[self bomb:p] lastCard:lastCard];
                [result addObjectsFromArray:biggerArray];
                
            }
        } else if ([self threeAndOne:lastCard]){
            //三带一=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self threeAndOne:p] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
        }
    } else if (lastCard.length >= 5) {
        if ([[self succee:lastCard length:lastCard.length] containsObject:lastCard]) {
            //顺子=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self succee:p length:lastCard.length] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
            
        } else if ([[self succeeDouble:lastCard length:lastCard.length] containsObject:lastCard]){
            //连对=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self succeeDouble:p length:lastCard.length] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
            
        } else {
            if(lastCard.length == 6) {
                //四带2=====>
                [result addObjectsFromArray:wangzhaAndBombArray];
                NSArray *biggerArray = [self findBiggerSameType:[self fourAndTwo:p] lastCard:lastCard];
                [result addObjectsFromArray:biggerArray];
                
            } else if (lastCard.length == 8) {
                //四带二对=====>
                [result addObjectsFromArray:wangzhaAndBombArray];
                NSArray *biggerArray = [self findBiggerSameType:[self fourAndDouble:p] lastCard:lastCard];
                [result addObjectsFromArray:biggerArray];
            }
        }
    }
    
    if(result.count == 0) {
        [result addObject:@""];
    }

    return [result copy];
    
}

- (NSArray *)findBiggerSameType:(NSArray *)array lastCard:(NSString *)lastCard {
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *card in array) {
        //第一个字符在allArray里的Index比较
        if([self compareValueOfSameType:card value2:lastCard]) {
            [result addObject:card];
        }
    }
    return [result copy];
}

- (BOOL)compareValueOfSameType:(NSString *)value1  value2:(NSString *)value2 {
    NSString *str1 = [value1 charStrOfIndex:0];
    NSString *str2 = [value2 charStrOfIndex:0];
    return [_allNumArray indexOfObject:str1] < [_allNumArray indexOfObject:str2];
}

- (void)play:(int)depth {
    _depth = depth;
    int result = [self MaxMin:depth mode:0 alpha:-100000000 beta:100000000];
    NSLog(@"result:    %d", result);
}

- (int) MaxMin:(int) depth mode:(int)mode alpha:(int)alpha beta:(int)beta {
//    int best = -100000000;//player_mode是参照物，如果当前落子是人，则返回一个很小的值，反之返回很大
    if (depth <= 0) {//当前以局面为博弈树的root
        return 0;
    }
    //    　GenerateLegalMoves(); //生成当前所有着法
    NSArray *allResult = [self allKind:mode == 0 ? _p1 : _p2 lastCard:_lastCard];
    
    for (NSString *card in allResult) {//遍历每一个着法
        /** 走一步 */
        NSString *saveP1 = _p1;
        NSString *saveP2 = _p2;
        NSString *saveLast = _lastCard;
        
        if(mode == 0) {
            NSRange range = [_p1 rangeOfString:card];
            if(range.location != NSNotFound) {
                _p1 = [_p1 stringByReplacingCharactersInRange:range withString:@""];
            }
        } else {
            NSRange range = [_p2 rangeOfString:card];
            if(range.location != NSNotFound) {
                _p2 = [_p2 stringByReplacingCharactersInRange:range withString:@""];
            }
        }
        
        _lastCard = card;
        
        /** 估值 */
        int val = 0;
        if([self isWin]) {
            val = 1000000;
        } else {
            val = -[self MaxMin:depth - 1  mode:mode == 0 ? 1 : 0 alpha:-beta beta:-alpha];//换位思考
        }
        
        /** 撤销一步*/
        _p1 = saveP1;
        _p2 = saveP2;
        _lastCard = saveLast;
        
        if (val >= beta) {
            return beta;
        }
        if (val > alpha) {
            alpha = val;
                    if(depth == _depth) {
                        NSLog(@"value:  %d, card:  %@, %@", val, card, val == 1000000 ? @"✅" : @"❌");
                    }
        }

    }
    //打印结果
    if(depth == _depth) {
        NSLog(@"best:%d ", alpha);
    }
    return alpha;
}

- (BOOL)isWin {
    if(_p1.length == 0 || _p2.length == 0) {
        return YES;
    }
    return NO;
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
    if (p.length < 2) {
        return @[];
    }
    
    return [self find:p number:2];
}

//仨牌
- (NSArray *)three:(NSString *)p {
    if (p.length < 3) {
        return @[];
    }
    
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
- (NSArray *)succee:(NSString *)p length:(NSInteger)length {
    if (p.length < 5) {
        return @[];
    }
    
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
    if (p.length < 4) {
        return @[];
    }
    
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
    if (p.length < 5) {
        return @[];
    }
    
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
    if (p.length < 6) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    //四张牌数组
    NSMutableArray *fourArray = [[self find:p number:4] mutableCopy];

    for (NSString *str in fourArray) {
        NSRange range = [p rangeOfString:str];
        NSString *tempP = p;
        if(range.location != NSNotFound) {
            tempP = [p stringByReplacingCharactersInRange:range withString:@""];
        }
        
        if(tempP.length > 0) {
            for (int j = 0; j < tempP.length - 1; j++) {
                for (int k = j+1; k < tempP.length ; k++) {
                    NSString *resultStr = [NSString stringWithFormat:@"%@%@%@", str, [tempP charStrOfIndex:j], [tempP charStrOfIndex:k]];
                    if(![result containsObject:resultStr]) {
                        [result addObject:resultStr];
                    }
                }
            }
        }
    }
    
    return [result copy];
}

//四带两对   w2222AKKKKJJ9994433 （可以是对）
- (NSArray *)fourAndDouble:(NSString *)p {
    if (p.length < 8) {
        return @[];
    }
    NSMutableArray *result = [NSMutableArray array];
    
    //四张牌数组
    NSMutableArray *fourArray = [[self find:p number:4] mutableCopy];

    for (NSString *str in fourArray) {
        NSRange range = [p rangeOfString:str];
        NSString *tempP = p;
        if(range.location != NSNotFound) {
            tempP = [p stringByReplacingCharactersInRange:range withString:@""];
        }
        NSMutableArray *twoArray = [[self find:tempP number:2] mutableCopy];

        if (twoArray.count > 0) {
            for (int j = 0; j < twoArray.count - 1; j++) {
                for (int k = j+1; k < twoArray.count ; k++) {
                    NSString *resultStr = [NSString stringWithFormat:@"%@%@%@", str, twoArray[j], twoArray[k]];
                    if(![result containsObject:resultStr]) {
                        [result addObject:resultStr];
                    }
                }
            }
        }
    }
    return [result copy];
}

//连对
- (NSArray *)succeeDouble:(NSString *)p length:(NSInteger)length {//最少3对
    if (p.length < 6) {
        return @[];
    }
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
    if (p.length < 2) {
        return @[];
    }
    
    if([p containsString:@"Ww"]) {
        return @[@"Ww"];
    }
    return @[];
}

//炸弹
- (NSArray *)bomb:(NSString *)p {
    if (p.length < 4) {
        return @[];
    }
    
    return [self find:p number:4];
}

@end

@implementation NSString (subChar)

- (NSString *)charStrOfIndex:(int)index {
    return [self substringWithRange:NSMakeRange(index, 1)];
}

@end
