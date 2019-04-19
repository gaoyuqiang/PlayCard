//
//  ViewController.m
//  PlayCard
//
//  Created by gao on 2019/4/16.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"

@interface ViewController ()

@property(nonatomic, strong) UITextField *p1TextField;
@property(nonatomic, strong) UITextField *p2TextField;
@property(nonatomic, strong) UIButton *button;

@property(nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _p1TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _p1TextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _p2TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    _p2TextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"计算" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.frame = CGRectMake(100, 300, 120, 50);
    [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = [UIColor cyanColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 420, 300, 200)];

    [self.view addSubview:_p1TextField];
    [self.view addSubview:_p2TextField];
    [self.view addSubview:_button];
}

- (void)clickButton {
    Card *card = [[Card alloc] initWithP1:_p1TextField.text p2:_p2TextField.text];
    [card play:15];
}



@end
