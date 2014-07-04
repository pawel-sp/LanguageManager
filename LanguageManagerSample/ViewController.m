//
//  ViewController.m
//  LanguageManagerSample
//
//  Created by Paweł Sporysz on 04.07.2014.
//  Copyright (c) 2014 Paweł Sporysz. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

-(void)setup
{
    self.textLabel.text = NSLocalizedStringFromTable(@"key", @"Texts", nil);
}

- (IBAction)switchToEnglish:(UIButton *)sender
{
    [[LanguageManager sharedManager] setAppLanguage:@"en"];
}

- (IBAction)switchToPolish:(UIButton *)sender
{
    [[LanguageManager sharedManager] setAppLanguage:@"pl"];
}


@end
