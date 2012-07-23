//
//  DataManager.h
//
//  Created by Александр Сергеев on 11/17/11.
//  Copyright (c) 2012 Aleksandr Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSString (SafeSearchString)
-(NSString *) safeSearchString;
@end

@interface DataManager : NSObject {
  NSManagedObjectContext *managedObjectContext_;
  NSManagedObjectModel *managedObjectModel_;
  NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

//@property (nonatomic, retain) NSManagedObjectContext * managedContext;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign) BOOL isFirstLaunch;

-(void) firstStartup;
-(NSURL *) sqlDatabaseURL;


+(DataManager *) sharedDataManager;
+(DataManager *) userDataManager;

-(NSManagedObject *) insertInto:(NSString *) entity withData:(NSDictionary *) reciptData;

-(BOOL) insertUniqueInto:(NSString *) entity withData:(NSDictionary *) reciptData;
-(NSManagedObject *) updateOrInsert:(NSString *) entity withData:(NSDictionary *) reciptData;
-(NSManagedObject *) updateOrInsert:(NSString *) entity withData:(NSDictionary *) reciptData where:(NSPredicate *)predicate;
-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate;
-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sortBy:(NSSortDescriptor *) sort;
-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sort:(NSArray *) sort;
-(NSArray *) selectFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate sort:(NSArray *) sort fields:(NSSet *) fields;
-(void) removeFrom:(NSString *) entity usingPredicate:(NSPredicate *) predicate;

-(NSUInteger) countIn:(NSString *) entity usingPredicate:(NSPredicate *) predicate;

-(void) save;

-(void) firstStartup;
-(NSString *) modelName;
@end
