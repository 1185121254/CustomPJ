//
//  People.m
//  CustomPJ
//
//  Created by chaojie on 2017/6/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "People.h"

@implementation People

-(void)encodeWithCoder:(NSCoder*)aCoder
{
    
    [aCoder encodeObject:_psw forKey:@"psw"];
    [aCoder encodeObject:_name forKey:@"name"];
    
    
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self=[super init];
    
    if(self) {
        
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.psw=[aDecoder decodeObjectForKey:@"psw"];
    }
    
    return self;
}


@end
