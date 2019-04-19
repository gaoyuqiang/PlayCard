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

- (void)play;

- (NSArray *)allKind:(NSString *)p;

- (NSArray *)single:(NSString *)p;

- (NSArray *)two:(NSString *)p;

- (NSArray *)three:(NSString *)p;

- (NSArray *)find:(NSString *)p number:(int)num;

//- (NSArray *)succee:(NSString *)p;
- (NSArray *)succee:(NSString *)p length:(int)length;

- (NSArray *)threeAndOne:(NSString *)p;

- (NSArray *)threeAndTwo:(NSString *)p;

- (NSArray *)fourAndTwo:(NSString *)p;

- (NSArray *)fourAndDouble:(NSString *)p;

- (NSArray *)succeeDouble:(NSString *)p length:(int)length;

- (NSArray *)wangzha:(NSString *)p;

- (NSArray *)bomb:(NSString *)p;

@end

@interface  NSString (subChar)

- (NSString *)charStrOfIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
