#import <objc/Object.h>

@interface code : Object
{
   char buffer[100];
}

- init;
- addStringValue:(const char*)astring;
- print;
- clear;

@end

//ogfileid:27
