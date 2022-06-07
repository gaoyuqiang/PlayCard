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
@property(nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) Card *card;
@property(nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _p1TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _p1TextField.borderStyle = UITextBorderStyleRoundedRect;
    _p1TextField.autocapitalizationType=UITextAutocapitalizationTypeNone;


    _p2TextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    _p2TextField.borderStyle = UITextBorderStyleRoundedRect;
    _p2TextField.autocapitalizationType=UITextAutocapitalizationTypeNone;

    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"计算" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.frame = CGRectMake(100, 300, 120, 50);
    [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = [UIColor cyanColor];
    
    _switchLogControl = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, _button.frame.origin.y + 10, 60, 40)];
    _switchLogControl.on = NO;

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, _button.frame.origin.y + _button.frame.size.height + 30, self.view.frame.size.width - 20*2, 100)];
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.autocapitalizationType=UITextAutocapitalizationTypeNone;
    [_textView clipsToBounds];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setTitle:@"计算" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button2.frame = CGRectMake(100, _textView.frame.origin.y + _textView.frame.size.height + 0, 120, 50);
    [_button2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    _button2.backgroundColor = [UIColor cyanColor];
    
//    _p1TextField.text = @"K07755433";//专家1
//    _p2TextField.text = @"Q88664";
    
    [self.view addSubview:_p1TextField];
    [self.view addSubview:_p2TextField];
    [self.view addSubview:_button];
    [self.view addSubview:_switchLogControl];
    [self.view addSubview:_textView];
    [self.view addSubview:_button2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)clickButton {
    Card *card = [[Card alloc] initWithP1:_p1TextField.text p2:_p2TextField.text lastCard:@""];
    card.openlog = _switchLogControl.on;
    NSString *result = [card play:40];
    self.textView.text = [NSString stringWithFormat:@"%@ -",  result];
    _card = card;
}

- (void)clickButton2 {
    NSString *textLog = _textView.text;
    textLog = [textLog stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    textLog = [NSString stringWithFormat:@"%@", textLog];
    for (NSInteger i = 0; i < _card.allLogArray.count; i++) {
        NSString *log = [_card.allLogArray objectAtIndex:i];
        if ([log isEqualToString:textLog]) {
            NSLog(@"fuck: %@", _card.allLogArray[i - 1]);
//            _textView.text = _card.allLogArray[i - 1];
            _textView.text = [NSString stringWithFormat:@"%@ -",  _card.allLogArray[i - 1]];
            
        }
    }
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
