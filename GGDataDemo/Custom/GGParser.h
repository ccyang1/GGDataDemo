//
//  NSObject+GGParser.h
//  GGDataDemo
//
//  Created by MacBook on 16/3/30.
//  Copyright © 2016年 xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GGParser)

/*@
 *@brief object to NSDictionary
 */
- (NSDictionary*)GGDictionary;

/*@
 *@brief object to NSString
 */
-(NSString*)GGString;

/*@
 *@brief object to NSData
 */
-(NSData*)GGData;

@end


@interface NSDictionary (GGParser)
/*@
 *@brief Dictionary to object
 */
- (id)GGDictionaryToModel:(NSString*)className;

@end


@interface NSArray (GGParser)
/*@
 *@brief Array to object
 */
- (id)GGArrayToModel:(NSString*)className;

@end

@interface NSData (GGParser)
/*@
 *@brief Data to object
 */
- (id)GGDataToModel:(NSString*)className;

@end

@interface NSString (GGParser)
/*@
 *@brief String to object
 */
- (id)GGStringToModel:(NSString*)className;

@end
