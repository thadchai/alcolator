//
//  ViewController.m
//  Alcolator
//
//  Created by Work on 1/7/15.
//  Copyright (c) 2015 Thadchai Sattayatam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    //BUTTON PRESS UPDATES THE LABEL
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount <= 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
        self.title = [NSString stringWithFormat:@"Wine %.1f glass", numberOfWineGlassesForEquivalentAlcoholAmount];
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
        self.title = [NSString stringWithFormat:@"Wine %.1f glasses", numberOfWineGlassesForEquivalentAlcoholAmount];
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}


- (void)loadView {
    // To allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // To allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // To add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];

    // To assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
    // This calls the superclass's implementation
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // This sets our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor whiteColor];
    
    // This sets the title
    self.title = NSLocalizedString(@"Wine", @"wine");
    
    // This tells the text field that 'self', this instance of 'BLCViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // This sets the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // SETTING TEXTFIELD'S BACKGROUND COLOR to WHITE (per Assignment)
    self.beerPercentTextField.backgroundColor = [UIColor lightGrayColor];
    
    // SETTING TEXTFIELD'S FONT to (per Assignment)
    self.beerPercentTextField.font = [UIFont fontWithName:@"Avenir" size:18];
    
    // This tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderValueDidChange:]'.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // This sets the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // This tells 'self.calculateButton' that when a finger is lifted from the button while inside of its bounds to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // This sets the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // This tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // This gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = 320;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;

    self.beerPercentTextField.frame = CGRectMake(padding, padding * 4, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 2);
    
    self.resultLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
 
    self.calculateButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
