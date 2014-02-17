//
//  PhoneNumberTextField.m
//
//  Created by Mark Flowers on 2/16/14.
//  Copyright (c) Mark Flowers All rights reserved.
//

#import "PhoneNumberTextField.h"

@implementation PhoneNumberTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(didEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    self.keyboardType = UIKeyboardTypePhonePad;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.0f;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)setValid:(BOOL)valid {
    if(valid) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

- (BOOL)isValid {
    NSString *phoneNumberString = [self removePhoneFormatting:self.text];
    BOOL validPhoneNumber = phoneNumberString.length == 7 || phoneNumberString.length == 10 || [self.text isEqualToString:@""];
    return validPhoneNumber;
}

- (void)textDidChange:(id)sender {
    NSString *unformatted = [self removePhoneFormatting:self.text];
    
    self.text = [self formatPhoneNumber:self.text];
    if(unformatted.length > 10) {
        self.text = [self formatPhoneNumber:[unformatted substringToIndex:10]];
    }
}

- (void)didEndEditing:(id)sender {
    if(![self isValid]) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

- (NSString*)formatPhoneNumber:(NSString*)phoneNumberString {
    
    phoneNumberString = [self removePhoneFormatting:phoneNumberString];
    
    if(phoneNumberString.length > 3 &&phoneNumberString.length <= 7) {
        phoneNumberString = [NSString stringWithFormat:@"%@-%@", [phoneNumberString substringToIndex:3], [phoneNumberString substringFromIndex:3]];
    } else if(phoneNumberString.length >= 7) {
        phoneNumberString = [NSString stringWithFormat:@"(%@)%@-%@", [phoneNumberString substringToIndex:3], [phoneNumberString substringWithRange:NSMakeRange(3,3)], [phoneNumberString substringFromIndex:6]];
    }
    
    return phoneNumberString;
}

- (NSString*)removePhoneFormatting:(NSString*)phoneNumberString {
    NSMutableString *unformattedString = [[NSMutableString alloc] initWithString:phoneNumberString];
    NSRange wholeRange = NSMakeRange(0, unformattedString.length);
    
    [unformattedString replaceOccurrencesOfString:@"(" withString:@"" options:0 range:wholeRange];
    wholeRange = NSMakeRange(0, unformattedString.length);
    [unformattedString replaceOccurrencesOfString:@")" withString:@"" options:0 range:wholeRange];
    wholeRange = NSMakeRange(0, unformattedString.length);
    [unformattedString replaceOccurrencesOfString:@"-" withString:@"" options:0 range:wholeRange];
    return unformattedString;
}

@end
