//
//  DataManager.m
//  Talerka
//
//  Created by Александр Сергеев on 11/17/11.
//  Copyright (c) 2012 Aleksandr Sergeev. All rights reserved.
//

#import "DataManager.h"
#import "NSArray+FirstObject.h"

@implementation NSString (SafeSearchString)
-(NSString *) safeSearchString {
  return [self stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}
@end


@implementation DataManager

@synthesize isFirstLaunch;

-(void) dealloc {
  
  [managedObjectContext_ release];
  [managedObjectModel_ release];
  [persistentStoreCoordinator_ release];
  [super dealloc];
}

+(DataManager *) loadDataManager {
  DataManager * dataManager = [[[DataManager alloc]init]autorelease];
  return dataManager;
}

+(DataManager *) sharedDataManager {
  static DataManager * manager = [[self loadDataManager] retain];
  return manager;
}



-(void) save {
  if ([[self managedObjectContext] hasChanges]) {
    NSError * error (0);
    [[self managedObjectContext] save:&error];
    if (0 != error) {
      NSLog(@"En error occured while saving chages in \"%@\": %@", [self modelName], [error localizedDescription]);
    }
  }
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
  
  if (managedObjectContext_ != nil) {
    return managedObjectContext_;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    managedObjectContext_ = [[NSManagedObjectContext alloc] init];
    [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
  }
  return managedObjectContext_;
}

-(NSString *) modelName {
  return 0;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
  
  if (managedObjectModel_ != nil) {
    return managedObjectModel_;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:@"momd"];
  managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
  //  managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
  NSLog(@"Bundle location is %@ object is %p", [modelURL absoluteString], managedObjectModel_);
  return managedObjectModel_;
}


-(NSURL *) sqlDatabaseURL {
  return 0;
}

-(void) firstStartup {
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  
  if (persistentStoreCoordinator_ != nil) {
    return persistentStoreCoordinator_;
  }
  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
  
  
  NSURL *storeURL = [self sqlDatabaseURL];
  NSLog(@"Loading store from %@", [storeURL absoluteString]);
  BOOL firstLaunch = [self isFirstLaunch];
  if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]] && NO == firstLaunch) {
    [self setIsFirstLaunch:YES];
    [self firstStartup];
  }
  
  NSError *error = nil;
  persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSPersistentStore * store = [persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
  if (nil == store || nil != error) {
    // Removing bad sql table
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:0];
    [persistentStoreCoordinator_ autorelease];
    persistentStoreCoordinator_ = 0;
    return [self persistentStoreCoordinator];
    
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
     
     Typical reasons for an error here include:
     * The persistent store is not accessible;
     * The schema for the persistent store is incompatible with current managed object model.
     Check the error message to determine what the actual problem was.
     
     
     If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
     
     If you encounter schema incompatibility errors during development, you can reduce their frequency by:
     * Simply deleting the existing store:
     [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
     
     * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
     [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
     
     Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }    
  
  return persistentStoreCoordinator_;
}
-(BOOL) primaryKeyIsNil:(NSDictionary *) data {
  return nil == [data objectForKey:@"id"];
}

-(NSManagedObject *) insertInto:(NSString *) entity withData:(NSDictionary *) reciptData {
  NSManagedObject * obj =[NSEntityDescription 
                                insertNewObjectForEntityForName:entity 
                                inManagedObjectContext:[self managedObjectContext]];
  [obj setValuesForKeysWithDictionary:reciptData];  
  return obj;
}

-(BOOL) insertUniqueInto:(NSString *) entity withData:(NSDictionary *) data {
  if (![self primaryKeyIsNil:data]) {
    const NSUInteger rId = [[data objectForKey:@"id"] unsignedIntValue];
    NSArray * objs = [self selectFrom:entity usingPredicate:[NSPredicate predicateWithFormat:@"id == %u", rId]];
    if (0 ==[objs count]) { // Insert 
      [self insertInto:entity withData:data];
      return YES;
    }
  } else {
    NSLog(@"%@ key is nil", entity);
    abort();    
  }  
  return NO;
}

-(NSManagedObject *) updateOrInsert:(NSString *) entity withData:(NSDictionary *) data where:(NSPredicate *)predicate {
  NSArray * needUpdate = [self selectFrom:entity usingPredicate:predicate];
  if ([needUpdate count] > 0) {
    NSManagedObject * o = [needUpdate firstObject];
    [o setValuesForKeysWithDictionary:data];
    return 0;
  } else {
    return [self insertInto:entity withData:data];
  }
  return 0;
}

-(NSManagedObject *) updateOrInsert:(NSString *) entity withData:(NSDictionary *) data {
  if (![self primaryKeyIsNil:data]) {
    const NSUInteger rId = [[data objectForKey:@"id"] unsignedIntValue];
    NSArray * objs = [self selectFrom:entity usingPredicate:[NSPredicate predicateWithFormat:@"id == %u", rId]];
    if (0 ==[objs count]) { // Insert 
      return [self insertInto:entity withData:data];
    } else if (1 == [objs count]) {
      NSManagedObject * obj = [objs lastObject];
      [obj setValuesForKeysWithDictionary:data];
      return obj;
    } else {
      NSLog(@"There is more than one %@ with id %u",entity, [[data objectForKey:@"id"] unsignedIntValue]);
      abort();
    }
  } else {
    NSLog(@"%@ key is nil", entity);
    abort();    
  }
  return 0;
}

-(NSEntityDescription *) entityNamed:(NSString *) name {
  NSEntityDescription * const result = [NSEntityDescription entityForName:name inManagedObjectContext:[self managedObjectContext]];
	return result;
}

-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sortBy:(NSSortDescriptor *) sort {
  return [self selectFrom:entity usingPredicate:predicate sort:[NSArray arrayWithObject:sort]];
}

-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sort:(NSArray *) sort {
  return [self selectFrom:entity usingPredicate:predicate sort:sort fields:0];
}

-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sort:(NSArray *) sort fields:(NSSet *) fields {
  NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];  
  [request setEntity:[self entityNamed:entity]];
  [request setPredicate:predicate];
  [request setSortDescriptors:sort];
  if (fields) {
    [request setPropertiesToFetch:[fields allObjects]];
  }
  return [[self managedObjectContext] executeFetchRequest:request error:0];   
  
}

-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate {
  return [self selectFrom:entity usingPredicate:predicate sort:0];
}

-(NSUInteger) countIn:(NSString *) entity usingPredicate:(NSPredicate *) predicate {
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];  
    [request setEntity:[self entityNamed:entity]];
    [request setPredicate:predicate];
    return [[self managedObjectContext] countForFetchRequest:request error:0];
//    return [[managedContext executeFetchRequest:request error:0] count];     
}

-(void) removeFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate {
  NSArray * objects = [self selectFrom:entity usingPredicate:predicate];
  for (NSManagedObject * o in objects) {
    [[self managedObjectContext] deleteObject:o];
  }
}

@end
