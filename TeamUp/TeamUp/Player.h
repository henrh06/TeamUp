//
//  Player.h
//  TeamUp
//
//  Created by Henrik Heggland on 06.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property(nonatomic, retain) NSString *firstName;
@property(nonatomic, retain)NSString *lastName;
@property(nonatomic, retain)NSString *position;
@property int rating;
@property int number;


@end
