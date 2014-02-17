//
//  UIView+Frame.m
//
//  Created by Mark Flowers on 2/16/14.
//  Copyright (c) 2014 Mark Flowers. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - Getters

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGSize)size {
    return self.frame.size;
}

#pragma mark - Setters

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

#pragma mark - Animation

- (void)animateX:(CGFloat)x {
    [UIView animateWithDuration:0.35f animations:^{
        self.x = x;
    }];
}

- (void)animateY:(CGFloat)y {
    [UIView animateWithDuration:0.35f animations:^{
        self.y = y;
    }];
}

- (void)animateWidth:(CGFloat)width {
    [UIView animateWithDuration:0.35f animations:^{
        self.width = width;
    }];
}

- (void)animateHeight:(CGFloat)height {
    [UIView animateWithDuration:0.35f animations:^{
        self.height = height;
    }];
}

- (void)animateOrigin:(CGPoint)origin {
    [UIView animateWithDuration:0.35f animations:^{
        self.origin = origin;
    }];
}

- (void)animateSize:(CGSize)size {
    [UIView animateWithDuration:0.35f animations:^{
        self.size = size;
    }];
}

@end
