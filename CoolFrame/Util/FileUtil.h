//
//  FileUtil.h
//  CmouseUtil
//
//  Created by snail on 13-6-9.
//  Copyright (c) 2013年 snail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

//获取文件路径(沙盒)
+ (NSString *) getFilePath:(NSString *) fileName;

//写入文件
+ (BOOL) writeToFile:(id) file fileName: (NSString *) fileName;

//文件是否存在
+ (BOOL) fileISExist:(NSString *) filename;

//删除文件
+ (void) deleteFile:(NSString *) fileName;

//读取plist
+ (NSMutableDictionary *) getPListFile:(NSString *) listName;

/**
 *  @brief  获得指定目录下，指定后缀名的文件列表
 *
 *  @param  path        目录 传 nil 时 ,搜索 Document
 *  @param  _fileName    文件名
 *
 *  @return 文件路径
 */
+ (NSString *) findFileOfpath:(NSString *) path filename:(NSString *) _fileName;

+ (BOOL) ISUPDATE;
@end
