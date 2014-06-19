//
//  Note.m
//  TestSwift
//
//  Created by Jason Li on 6/3/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

#import "Note.h"
#import "TestSwift-Swift.h"

@implementation Note

- (void)log {
    NSLog(@"I am Objective-C Note!");
}

- (void)attachBook {
    Book *book = [Book new];
    [book log];
}

@end
