//
//  FileUtil.m
//  CmouseUtil
//
//  Created by snail on 13-6-9.
//  Copyright (c) 2013年 snail. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

//传入一个文件名获得其路径
+ (NSString *) getFilePath:(NSString *) fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

//写入文件
+ (BOOL) writeToFile:(id) file fileName: (NSString *) fileName{
    /**
     * 要写的文件存在则删除
     */
	if ([self fileISExist:fileName]) {
        [self deleteFile:fileName];
	}
    /**
     * 根据不同的数据类型写文件
     */
	if ([file isKindOfClass:[NSArray class]]) {
		NSArray *arry = (NSArray *)file;
		return [arry writeToFile:[self getFilePath:fileName] atomically:YES];
	} else if([file isKindOfClass:[NSMutableArray class]]){
		NSMutableArray *arry = (NSMutableArray *)file;
		return [arry writeToFile:[self getFilePath:fileName] atomically:YES];
	} else if([file isKindOfClass:[NSDictionary class]]){
		NSDictionary *arry = (NSDictionary *)file;
		return [arry writeToFile:[self getFilePath:fileName] atomically:YES];
	} else if([file isKindOfClass:[NSMutableDictionary class]]){
		NSMutableDictionary *arry = (NSMutableDictionary *)file;
		return [arry writeToFile:[self getFilePath:fileName] atomically:YES];
	} else if([file isKindOfClass:[NSString class]]){
		NSString *arry = (NSString *)file;
		return [arry writeToFile:[self getFilePath:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
	} else {
		return NO;
	}
}

+ (BOOL) fileISExist:(NSString *)filename{
    NSFileManager *nsmaager = [NSFileManager defaultManager];
    return [nsmaager fileExistsAtPath:[self getFilePath:filename]];
}

+ (void) deleteFile:(NSString *) fileName{
    NSLog(@"deleteFile:%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[self getFilePath:fileName] error:nil];
}

+ (NSMutableDictionary *) getPListFile:(NSString *) listName{
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *cardPath = [bundle pathForResource:listName ofType:@"plist"];
	return  [[NSMutableDictionary alloc] initWithContentsOfFile:cardPath];
}

+ (BOOL) ISUPDATE{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *cardPath = [bundle pathForResource:@"translation" ofType:@"json"];
    return cardPath != nil;
}

+ (NSString *) findFileOfpath:(NSString *) path filename:(NSString *) _fileName{

    if (path == nil) {
        path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    NSString *rtnPath = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //遍历这个目录的第一种方法：（深度遍历，会递归枚举它的内容）
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    
    while ((path = [dirEnum nextObject]) != nil){
        if ([path containsString:[NSString stringWithFormat:@"/%@",_fileName]]) {
            rtnPath = path;
            break;
        }
//        NSLog(@"%@",path);
    }
    
    return rtnPath;
}

@end
