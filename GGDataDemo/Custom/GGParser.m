//
//  NSObject+GGParser.m
//  GGDataDemo
//
//  Created by MacBook on 16/3/30.
//  Copyright © 2016年 xm. All rights reserved.
//

#import "GGParser.h"
#import <objc/runtime.h>

@implementation NSObject (GGParser)
/*@
 *@brief object to NSDictionary
 */
- (NSDictionary*)GGDictionary{
    if(!self) return nil;
    
    if([self isKindOfClass:[NSDictionary class]]){
        
        return (NSDictionary*)self;
    }
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    
    return props;
}

/*@
 *@brief object to NSString
 */
-(NSString*)GGString{
    if(!self)return nil;
    if([self isKindOfClass:[NSString class]]) {
        return (NSString*)self;
    }
    return [[NSString alloc] initWithData:[self GGData] encoding:NSUTF8StringEncoding];
}

/*@
 *@brief object to NSData
 */
-(NSData*)GGData{
    
    if(!self)return nil;
    
    if ([self isKindOfClass:[NSData class]]){
        return (NSData*)self;
    }
    return [NSJSONSerialization dataWithJSONObject:[self GGDictionary] options:NSJSONWritingPrettyPrinted error:nil];
}

@end

@implementation NSDictionary (GGParser)

- (id)GGDictionaryToModel:(NSString*)className{
    
    if(!self) return nil;
    Class cla = objc_getClass([className UTF8String]);
    __block id model = [[cla alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[NSDictionary class]]){
            
            id subObj = [obj GGDictionaryToModel:[key capitalizedStringWithLocale:[NSLocale currentLocale]]];
            
            [model setValue:subObj forKey:key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            id subObj =  [obj GGArrayToModel:[key capitalizedStringWithLocale:[NSLocale currentLocale]]];
            [model setValue:subObj forKey:key];
        }else{
            [model setValue:obj forKey:key];
        }
    }];
    
    return model;
}
-(NSData*)GGData{
    if(!self) return nil;
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

@end

@implementation NSArray (GGParser)

- (id)GGArrayToModel:(NSString*)className{
    if(!self) return nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[NSDictionary class]]){
            [arr addObject:[obj GGDictionaryToModel:className]];
        }else if ([obj isKindOfClass:[NSArray class]]){
            [arr addObject:[obj GGArrayToModel:className]];
        }else{
            [arr addObject:obj];
        }
        
    }];
    return arr;
}

-(NSString*)GGString{
    if(!self) return nil;
    return [self componentsJoinedByString:@","];
}

@end

@implementation NSData (GGParser)

- (id)GGDataToModel:(NSString*)className{
    
    if(!self)return nil;
    /*
     *解析data数据
     */
    id json = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:nil];
    if(!json)return nil;
    
    id model = nil;
    if([json isKindOfClass:[NSDictionary class]]){
        model = [(NSDictionary*)json GGDictionaryToModel:className];
    }else if ([json isKindOfClass:[NSString class]]){
        
        model = [(NSString*)json GGStringToModel:className];
    }
    return model;
}
- (NSDictionary*)GGDictionary{
    if(!self) return nil;
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:nil];
}

-(NSString*)GGString{
    if(!self) return nil;
     return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (GGParser)

- (id)GGStringToModel:(NSString*)className{
    if(!self) return nil;
    
    id model = [[self GGDictionary] GGDictionaryToModel:className];
    return model;
}

- (NSDictionary*)GGDictionary{
    if(!self) return nil;
     return [NSJSONSerialization JSONObjectWithData:[self GGData] options:NSJSONReadingMutableLeaves error:nil];
}

-(NSData*)GGData{
    if(!self) return nil;
     return [(NSString*)self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSArray*)GGArray{
    if(!self) return nil;
    return [NSMutableArray arrayWithArray:[self    componentsSeparatedByString:@","]];
}

@end

