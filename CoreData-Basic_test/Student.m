//
//  Student.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 17.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//

#import "Student.h"

@implementation Student

// Insert code here to add functionality to your managed object subclass

- (void)setFirstName:(NSString *)firstName {
    
    [self willChangeValueForKey:@"firstName"];
    
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    
    [self didChangeValueForKey:@"firstName"];
    
//    NSLog(@"Setter firstName");
    
}

- (NSString*) firstName {
    
    NSString *result = nil;
    [self willAccessValueForKey:@"firstName"];
        result = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    
//    NSLog(@"Getter firstName");
    
    return result;
}

- (BOOL) validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@"Student validateForDelete");
    
    return YES;
}

/*
- (BOOL) validateValue:(id  _Nullable __autoreleasing *)value forKey:(NSString *)key error:(NSError * _Nullable __autoreleasing *)error {
    
    
    
    return YES;
}
*/
/*
- (BOOL) validateLastName:(id  _Nullable __autoreleasing *)value error:(NSError * _Nullable __autoreleasing *)error {
    
    *error = [NSError errorWithDomain:@"lastName validation error" code:101 userInfo:nil];
    
    return YES;
}
*/
@end
