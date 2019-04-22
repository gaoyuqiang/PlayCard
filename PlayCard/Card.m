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
        NSArray *threeArray = [self three:p];
        [result addObjectsFromArray:threeArray];
        
        [result addObjectsFromArray:[self fourAndTwo:p]];
        [result addObjectsFromArray:[self fourAndDouble:p]];
        [result addObjectsFromArray:[self wangzha:p]];
        
        NSArray *bombArray = [self bomb:p];
        [result addObjectsFromArray:bombArray];
        
        NSArray *twoArray = [self two:p];
        [result addObjectsFromArray:twoArray];
        
        NSArray *singleArray = [self single:p];
        for (NSString *singleCard in singleArray) {
            BOOL isFind = NO;
            for (NSString *card2 in twoArray) {//看对的有没有
                if ([card2 rangeOfString:singleCard].location != NSNotFound) {//找到了
                    isFind = YES;
                    break;
                }
            }
            
            if (isFind == YES) {
                [result insertObject:singleCard atIndex:0];  //已经是组合的了单牌，优先级低，不推荐走，所以放在0位置（其实是最后）
            } else {
                [result addObject:singleCard];//纯粹的单牌
            }
        }
        
        
        [result addObjectsFromArray:[self threeAndOne:p]];
        [result addObjectsFromArray:[self threeAndTwo:p]];
        
        for (int i = 5; i <= 12; i++) {
            [result addObjectsFromArray:[self succee:p length:i]];
            
//            faafafasdf//第22关，怎么写呢？如果连的最后一张和最后两张都是三对的话 连的最后一张就别算到连里了，倒第二张看情况定
        }
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
            
        } else if ([self wangzha:lastCard].count == 1){
            //王炸=====>
        }
    } else if (lastCard.length == 3) {
        //三牌=====>
        [result addObjectsFromArray:wangzhaAndBombArray];
        NSArray *biggerArray = [self findBiggerSameType:[self three:p] lastCard:lastCard];
        [result addObjectsFromArray:biggerArray];
        
    } else if (lastCard.length == 4) {
        if ([self bomb:lastCard].count == 1) {//fix bug: [self bomb:lastCard]永远成立
            //炸弹=====>
            {
                //me王炸
                [result addObjectsFromArray:wangzhaArray];
                //me炸弹
                NSArray *biggerArray = [self findBiggerSameType:[self bomb:p] lastCard:lastCard];
                [result addObjectsFromArray:biggerArray];
                
            }
        } else if ([self threeAndOne:lastCard].count == 1){
            //三带一=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self threeAndOne:p] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
        }
    } else if (lastCard.length >= 5) {
        if (lastCard.length == 5 && [self threeAndTwo:lastCard].count == 1) {
            //三带二======>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self threeAndTwo:p] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
        }
        if ([[self succee:lastCard length:lastCard.length] containsObject:lastCard]) {
            //顺子=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self succee:p length:lastCard.length] lastCard:lastCard];
            [result addObjectsFromArray:biggerArray];
            
        } else if (lastCard.length %2 == 0 && [[self succeeDouble:lastCard length:lastCard.length/2] containsObject:lastCard]){//先判断偶数
            //连对=====>
            [result addObjectsFromArray:wangzhaAndBombArray];
            NSArray *biggerArray = [self findBiggerSameType:[self succeeDouble:p length:lastCard.length/2] lastCard:lastCard];
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
    
    //上张牌是不出，这些一定得出牌，不能不出； 如果上张牌有值，那么可以不出
//    if(![lastCard isEqualToString:@""]) {
//        [result addObject:@""];
//    }
    if(result.count == 0) {
        [result addObject:@""];
    }

    return [[result reverseObjectEnumerator] allObjects];

//    return [result copy];
    
}

- (int) MaxMin:(int) depth mode:(int)mode alpha:(int)alpha beta:(int)beta lastAllCard:(NSString *)lastAllCard {
    //    int best = -100000000;//player_mode是参照物，如果当前落子是人，则返回一个很小的值，反之返回很大
    if (depth <= 0) {//当前以局面为博弈树的root
        NSLog(@"+++++ %@",lastAllCard);
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
            _p1 = [_p1 deleteString:card];
        } else {
            _p2 = [_p2 deleteString:card];
        }
        
        _lastCard = card;
        
        
        static int openlog = 0;
        if (depth == _depth && [card isEqualToString:@"KQJ098"]) {
            openlog = 1;
            NSLog(@"%@",@"en");
        } else if(openlog == 1 && depth != _depth){
            openlog = 1;
        } else {
            openlog = 0;
        }
        
        /** 估值 */
        int val = 0;
        
        static int jj = 0;
        jj++;
        if (jj % 100000 == 0) {
            NSLog(@"jj:%d", jj);
        }

        if([self isWin:mode]) {
            static int i = 0;
            NSString * tempAll = [NSString stringWithFormat:@"%@ %@%@%@", lastAllCard, mode == 0 ? @"" : @"-", [card isEqualToString:@""] ? @"不要" : card, mode == 1 ? @" " : @" "];
            i++;
            if(openlog == 1) {
                
                NSLog(@"===== %@ %@",tempAll, _p1.length == 0 ? @"赢了++" : @"输了");
            }
            val = 1000000;
            /* 这行是alpha-beta算法之外的，是斗地主的特殊情况！ */
            if(depth == _depth) {
                NSLog(@"win-value:  %d, card:  %@, %@", val, card, val == 1000000 ? @"✅" : @"❌");
            }
            return val;//直接返回 你就是最大的了 节点最大的了，不存在+无穷
            
        } else {
            NSString * tempAll = [NSString stringWithFormat:@"%@ %@%@%@", lastAllCard, mode == 0 ? @"" : @"-", [card isEqualToString:@""] ? @"不要" : card, mode == 1 ? @" " : @" "];
            if(openlog == 1) {
//                NSLog(@"===== %@",tempAll);
            }
            
            val = -[self MaxMin:depth - 1  mode:mode == 0 ? 1 : 0 alpha:-beta beta:-alpha lastAllCard:tempAll];//换位思考
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
        if(depth == _depth) {
            NSLog(@"===value:  %d, card:  %@, %@", val, card, val == 1000000 ? @"✅" : @"❌");
        }
    }
    //打印结果
    if(depth == _depth) {
        NSLog(@"best:%d ", alpha);
    }
    return alpha;
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

- (void)play:(int)depth{
    _depth = depth;
    int result = [self MaxMin:depth mode:0 alpha:-100000000 beta:100000000 lastAllCard:@""];
    NSLog(@"result:    %d", result);
}


- (BOOL)isWin:(int)mode {
    if(_p1.length == 0 || _p2.length == 0) {
        return YES;
    }
    
    
    NSString *p1 = mode == 0 ? _p1 : _p2;
    NSString *p2 = mode == 0 ? _p2 : _p1;
    
    NSString *p1Last = [p1 charStrOfIndex:(int)(p1.length - 1)];
    NSString *p2Last = [p2 charStrOfIndex:(int)(0)];
    
//    if ([_allNumArray indexOfObject:p1Last] <= [_allNumArray indexOfObject:p2Last] && p2.length >= 2 && [self bomb:p2].count == 0) {
//        //最小的牌比最大的牌还大, p2至少2张牌，p2没有炸弹，必赢
//        return YES;
//    }
    
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
- (NSArray *)succee:(NSString *)p length:(NSInteger)length {
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

//专门删除字符串的，包括三带一，如98444里4449但是不挨的情况
- (NSString *)deleteString:(NSString *)str {
    NSString *currentSelf = [self copy];
    
    for (int i = 0; i < str.length; i++) {
        NSString *currentStr = [str charStrOfIndex:i];
        
        NSRange range = [currentSelf rangeOfString:currentStr];
        if(range.location != NSNotFound) {
            currentSelf = [currentSelf stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    
    NSAssert(self.length - str.length == currentSelf.length, @"长度不一致");
    return currentSelf;
}
@end
