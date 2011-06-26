#import "code.h"

int main()
{
   id p = [[code alloc] init];
   [p addStringValue:"Hello World!"];
   [p print];
   [p free];
}
