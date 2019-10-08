//
//  Card.h
//  PlayCard
//
//  Created by gao on 2019/4/16.
//  Copyright © 2019 58. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

- (instancetype)initWithP1:(NSString *)p1 p2:(NSString *)p2;

- (void)play:(int)depth;

- (NSArray *)allKind:(NSString *)p;

- (NSArray *)single:(NSString *)p;//1

- (NSArray *)two:(NSString *)p;//2

- (NSArray *)three:(NSString *)p;//3

- (NSArray *)find:(NSString *)p number:(int)num;

//- (NSArray *)succee:(NSString *)p;
- (NSArray *)succee:(NSString *)p length:(NSInteger)length;//5-12

- (NSArray *)threeAndOne:(NSString *)p;//4

- (NSArray *)threeAndTwo:(NSString *)p;//5

- (NSArray *)fourAndTwo:(NSString *)p;//6

- (NSArray *)fourAndDouble:(NSString *)p;//8

- (NSArray *)succeeDouble:(NSString *)p length:(NSInteger)length;//3-12对！这是对呀！！！！！！！！

- (NSArray *)wangzha:(NSString *)p;//2

- (NSArray *)bomb:(NSString *)p;//4

@end

@interface  NSString (subChar)

- (NSString *)charStrOfIndex:(int)index;
- (NSString *)deleteString:(NSString *)str;
//比较单牌是否比对方大
- (BOOL)bigger:(NSString *)single;

@end

NS_ASSUME_NONNULL_END
