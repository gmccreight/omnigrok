#import "code.h"

@implementation code

- init
{
   [super init];
   [self clear];
   return self;
}

- addStringValue:(const char*)astring
{
   strcat(buffer, astring);
   return self;
}

- print
{
   printf("%s\n", buffer);
   [self clear];
   return self;
}

- clear
{
   strcpy(buffer, "");
   return self;
}

@end

//ogfileid:28
