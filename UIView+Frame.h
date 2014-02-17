//
//  UIView+Frame.h
//  Conversion
//
//  Created by Mark Flowers on 2/16/14.
//  Copyright (c) 2014 Conversion App LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)animateX:(CGFloat)x;
- (void)animateY:(CGFloat)y;
- (void)animateWidth:(CGFloat)width;
- (void)animateHeight:(CGFloat)height;
- (void)animateOrigin:(CGPoint)origin;
- (void)animateSize:(CGSize)size;

@end
