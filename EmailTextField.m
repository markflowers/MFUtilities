//
//  EmailTextField.m
//  Conversion
//
//  Created by Mark Flowers on 2/16/14.
//  Copyright (c) 2014 Conversion App LLC. All rights reserved.
//

#import "EmailTextField.h"

@interface EmailTextField ()

@property (nonatomic, strong) NSString *previousText;

@end

@implementation EmailTextField

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
    self.keyboardType = UIKeyboardTypeEmailAddress;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.0f;
    _borderColor = [UIColor lightGrayColor];
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
        // Email validation is hard ... via http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex
    BOOL validEmailAddress = [self.text rangeOfString:@"@"].location != NSNotFound && ![self.text isEqualToString:@""];
    return validEmailAddress;
}

- (void)textDidChange:(id)sender {
    BOOL backSpaceDetected = self.text.length <= self.previousText.length;
    
    static NSArray *_domainNames = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _domainNames = @[@"yahoo.com", @"google.com", @"hotmail.com", @"gmail.com", @"me.com", @"aol.com", @"mac.com", @"live.com", @"comcast.net", @"googlemail.com", @"msn.com", @"hotmail.co.uk", @"yahoo.co.uk", @"facebook.com", @"verizon.net", @"sbcglobal.net", @"att.net", @"gmx.com", @"mail.com", @"outlook.com", @"icloud.com"];
    });
    
    NSRange rangeOfAtSign = [self.text rangeOfString:@"@"];
    
    __block NSString *continuationString = @"";
    
    if(rangeOfAtSign.location != NSNotFound && !backSpaceDetected) {
        NSString *domainString = [self.text substringFromIndex:rangeOfAtSign.location + rangeOfAtSign.length];
        
        [_domainNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *domainNameString = obj;
            NSRange rangeOfDomainString = [domainNameString rangeOfString:domainString];
            if(rangeOfDomainString.location == 0) {
                continuationString = [domainNameString substringFromIndex:domainString.length];
                *stop = YES;
            }
        }];
        
        self.text = [self.text stringByAppendingString:continuationString];
        
        UITextRange *selectedRange = [self selectedTextRange];
        UITextPosition *startPos = [self positionFromPosition:selectedRange.end offset:0];
        UITextPosition *endPos = [self positionFromPosition:selectedRange.end offset:-1 * continuationString.length];
        UITextRange *newRange = [self textRangeFromPosition:startPos toPosition:endPos];
        
        [self setSelectedTextRange:newRange];
    }
    
    self.previousText = [self.text stringByReplacingOccurrencesOfString:continuationString withString:@""];
}

- (void)didEndEditing:(id)sender {
    if(![self isValid]) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

@end
