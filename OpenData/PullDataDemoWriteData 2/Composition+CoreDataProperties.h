//
//  Composition+CoreDataProperties.h
//  
//
//  Created by Crystal on 16/9/1.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Composition.h"

NS_ASSUME_NONNULL_BEGIN

@interface Composition (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *safety;
@property (nullable, nonatomic, retain) NSString *used;
@property (nullable, nonatomic, retain) NSString *compositionId;
@property (nullable, nonatomic, retain) NSNumber *sort;
@property (nullable, nonatomic, retain) Product *product;

@end

NS_ASSUME_NONNULL_END
