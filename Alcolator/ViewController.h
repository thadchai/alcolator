//
//  ViewController.h
//  Alcolator
//
//  Created by Work on 1/7/15.
//  Copyright (c) 2015 Thadchai Sattayatam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;

- (void)buttonPressed:(UIButton *)sender;
@end
