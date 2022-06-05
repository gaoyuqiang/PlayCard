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
@property(nonatomic, strong) UISwitch *switchLogControl;
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
    
    _switchLogControl = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, _button.frame.origin.y + 10, 60, 40)];
    _switchLogControl.on = YES;

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 420, 300, 200)];

    [self.view addSubview:_p1TextField];
    [self.view addSubview:_p2TextField];
    [self.view addSubview:_button];
    [self.view addSubview:_switchLogControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)clickButton {
    Card *card = [[Card alloc] initWithP1:_p1TextField.text p2:_p2TextField.text];
    card.openlog = _switchLogControl.on;
    NSString *result = [card play:40];
    self.p1TextField.text = result;
}

- (void)textChanged:(NSNotification *)notif {
    //自动将小写转化成大写，除了小王w
    UITextField *textField = notif.object;
    if(textField.text.length > 0) {
        NSString *last = [textField.text substringFromIndex:textField.text.length - 1];
        if(![last isEqualToString:@"w"]) {
            textField.text = [textField.text stringByReplacingOccurrencesOfString:last withString:[last uppercaseString]];
        }
    }
}


@end
