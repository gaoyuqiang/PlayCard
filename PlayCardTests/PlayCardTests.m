//
//  PlayCardTests.m
//  PlayCardTests
//
//  Created by gao on 2019/4/17.
//  Copyright © 2019 58. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"

@interface PlayCardTests : XCTestCase

@property (nonatomic, strong) Card *card;
@property (nonatomic, strong) NSString * p;



@end

@implementation PlayCardTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _card = [[Card alloc] initWithP1:nil p2:nil];
    _p = @"Ww222AAAAKKQJJJ099877655543";
}

- (void)testAllKind {
    NSArray *result = [_card allKind:@"09988876543"];
    NSLog(@"%@",result);
    XCTAssertTrue(YES);
}

- (void)testSingle{
    NSArray *result = [_card single:_p];
    NSLog(@"%@",result);
    BOOL isEqual = [result isEqualToArray:@[@"W", @"w", @"2", @"A", @"K", @"Q", @"J", @"0", @"9", @"8", @"7", @"6", @"5", @"4", @"3"]];
    XCTAssertTrue(isEqual);
}

- (void)testTwo {
    NSArray *result = [_card two:_p];
    NSLog(@"%@",result);
    BOOL isEqual = [result isEqualToArray:@[@"22", @"AA", @"KK", @"JJ", @"99", @"77", @"55"]];
    XCTAssertTrue(isEqual);
}

- (void)testThree {
    NSArray *result = [_card three:_p];
    NSLog(@"%@",result);
    BOOL isEqual = [result isEqualToArray:@[@"222", @"AAA", @"JJJ", @"555"]];
    XCTAssertTrue(isEqual);
}

- (void)testSuccee{
    NSArray *result = [_card succee:_p length:5];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testThreeAndOne{
    NSArray *result = [_card threeAndOne:_p];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testThreeAndTwo{
    NSArray *result = [_card threeAndTwo:_p];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testFourAndTwo{
    NSArray *result = [_card fourAndTwo:_p];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testFourAndDouble{
    NSArray *result = [_card fourAndDouble:_p];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testSucceeDouble {
    NSArray *result = [_card succeeDouble:@"Ww22AAKKQQJJ009988776554433" length:5];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testWangZha {
    NSArray *result = [_card wangzha:@"Ww22AAKKQQJJ009988776554433"];
    NSLog(@"%@",result);
    BOOL isEqual = YES;
    XCTAssertTrue(isEqual);
}

- (void)testBomb{
    NSArray *result = [_card bomb:_p];
    NSLog(@"%@",result);
    BOOL isEqual = [result isEqualToArray:@[@"AAAA"]];
    XCTAssertTrue(isEqual);//Ww222AAAAKKQJJJ099877655543
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
