//
//  main.m
//  CurvedPathDecoder
//
//  Created by Joël Spaltenstein on 9/19/13.
//  Copyright (c) 2013 Spaltenstein Natural Image. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPRCurvedPath.h"
#import "N3BezierPath.h"

void printHelp();


int main(int argc, const char * argv[])
{
    int pathArg = 1;
    BOOL tessellate = NO;
    if (argc == 3) {
        if (strcmp(argv[1], "--tessellate") == 0) {
            pathArg = 2;
            tessellate = YES;
        } else {
            printHelp();
            return 1;
        }
    } else if (argc != 2) {
        printHelp();
        return 1;
    }
    
    @autoreleasepool {
        NSString *path = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:argv[pathArg] length:strlen(argv[pathArg])];
        BOOL isDirectory = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] == NO || isDirectory == YES) {
            printHelp();
            return 1;
        }
        
        CPRCurvedPath *curvedPath;
        @try {
            curvedPath = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
        @catch (NSException *exception) {
            printf("%s\n", [[exception reason] UTF8String]);
            printf("\n");
            printHelp();
            return 1;
        }
        N3BezierPath *bezierPath = curvedPath.bezierPath;
        if (tessellate) {
            bezierPath = [bezierPath bezierPathByFlattening:N3BezierDefaultFlatness];
        }
        printf("%s", [[bezierPath  description] UTF8String]);
    }
    return 0;
}


void printHelp()
{
    printf("Usage:\n");
    printf("curvedPathDecoder [--tessellate] <curvedPathFile>\n");
}
