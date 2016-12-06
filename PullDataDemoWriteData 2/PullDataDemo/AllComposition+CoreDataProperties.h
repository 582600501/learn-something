//
//  AllComposition+CoreDataProperties.h
//  
//
//  Created by Crystal on 16/8/31.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AllComposition.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllComposition (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cas_num;
@property (nullable, nonatomic, retain) NSString *ename;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *other_name;
@property (nullable, nonatomic, retain) NSString *safety;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *used;

@end

NS_ASSUME_NONNULL_END
