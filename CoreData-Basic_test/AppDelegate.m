//
//  AppDelegate.m
//  CoreData-Basic_test
//
//  Created by Yuriy T on 16.12.15.
//  Copyright © 2015 Yuriy T. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.managedObjectContext;
    
//    NSLog(@"%@", [self.managedObjectModel entitiesByName]);
    
    
/*
    ////   Write to db one record  KVC
    NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [student setValue:@"fName" forKey:@"firstName"];
    [student setValue:@"lName" forKey:@"lastName"];
    [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"birthDay"];
    [student setValue:@3.8 forKey:@"score"];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"not saved ((( %@", [error localizedDescription]);
    }
*/

/*
//   read from db records. KVC
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    NSError *errorReq = nil;
    NSArray *resultF = [self.managedObjectContext executeFetchRequest:request error:&errorReq];
    if (errorReq) {
        NSLog(@"error on fetch %@", [errorReq localizedDescription]);
    } else {
        NSLog(@"res: %@", resultF);
    }

    
    for (NSManagedObject *object in resultF) {
        NSLog(@"%@ - %@ - %@", [object valueForKey:@"firstName"], [object valueForKey:@"lastName"], [object valueForKey:@"score"]);
    }
*/
    
    
// ------  Models  --------
    
//    [self createStudent:@"StFN1" andLastName:@"StLN1" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.2f];
//    [self createStudent:@"StFN2" andLastName:@"StLN2" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:4] andScore:@3.5f];
//    [self createStudent:@"StFN3" andLastName:@"StLN3" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:2] andScore:@3.0f];
//    [self createStudent:@"StFN4" andLastName:@"StLN4" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:-10] andScore:@4.2f];
//    [self createStudent:@"StFN5" andLastName:@"StLN5" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:15] andScore:@3.1f];
    
    // With relationships

//    [self removaAll];
    
//    University *univer1 = [self createUniversity:@"Garvard"];
//
//    Student *student1 = [self createStudent:@"StFN1" andLastName:@"StLN1" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.8f];
//    Car *car1 = [self createCar:@"car1"];
//    student1.car = car1;
//
//    Student *student2 = [self createStudent:@"StFN2" andLastName:@"StLN2" andBirthDay:[NSDate dateWithTimeIntervalSinceNow:0] andScore:@3.3f];
//    Car *car2 = [self createCar:@"car2"];
//    student2.car = car2;
//    
//    [univer1 addStudentsObject:student1];  // or student1.university = univer1;
//    [univer1 addStudentsObject:student2];  // or student2.university = univer2;
//
//    Course *course1 = [self createCourse:@"course1"];
//    course1.universitet = univer1;
//    [course1 addStudentsObject:student1];
    
    // **********
        //  [(Course *)[student1.courses anyObject] name];
    // **********
//    [self printAll];

     // remove 1 student with her car via cascade
//    NSArray *students = [self getAllStudents:@"Student"];
//    if ([students count] > 0) {
//        Student *last = [students lastObject];
//        [self.managedObjectContext deleteObject:last];
//    }

    
    // remove car and student via nulify (the student must remain)
//    NSArray *cars = [self getAllStudents:@"Car"];
//    if ([cars count] > 0) {
//        Car *car = [cars lastObject];
//        [self.managedObjectContext deleteObject:car];
//    }
    
    // remove university
//    NSArray *univers = [self getAllStudents:@"University"];
//    if ([univers count] > 0) {
//        University *univer = [univers lastObject];
//        [self.managedObjectContext deleteObject:univer];
//    }
    
//    NSError *err = nil;
//    if(![self.managedObjectContext save:&err]){
//        NSLog(@"%@", [err localizedDescription]);
//    }

//    ********  Fetch  ************
    
//    [self loadFixtures];
    
//    [self printEntity:[self getAllStudents:@"Student"]];
//    NSLog(@"   *******************   ");
//    [self printEntity:[self gueryForCourseEntity]];
//    NSLog(@"   *******************   ");    
//    [self printAll];
    
    
//    ********  Use Manager  ************
    
//    [[DataManager Manager] loadFixtures];
//    [[DataManager Manager] printAll];
    
    DataManager *manager = [DataManager Manager];
    
    [manager printEntity:[manager gueryForCourseEntity]];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager Manager] saveContext];
}
@end
