%{ 
#include <stdio.h> 
#include <ctype.h>

int day, month, year;
char* months[] = {"january", "february", "march", "april", "may", "june", "july", "august", "september", "october"};
char* monthsExtended[] = {"november", "december"};

int checkForSeparator(char sign) {
    if(sign == '.' || sign == '-' || sign == '/')
        return 1;
    return 0;
 }

void formatData(char* date) {
    int i = 0, anchor;
    while(date[i] != '\0') {
        if(checkForSeparator(date[i]) && i < 3) {
            anchor = i;
            if(i == 1) {
                printf("0%c", date[i - 1]);
            }
            else {
                printf("%c%c", date[i - 2], date[i - 1]);
            }
            printf("-");
        }
        else if(checkForSeparator(date[i]) && i > 2) {
           if(!isdigit(date[anchor + 1])) {
               int j;
               for(j = anchor + 1; j < i; j++)
                printf("%c", date[j]);
           }
           else {
               if(i - anchor == 2) {
                    printf("%s", months[date[anchor + 1] - '0' - 1]);
               }
               else if(i - anchor == 3) {
                    if(date[anchor + 1] == '0') {
                        printf("%s", months[date[anchor + 2] - '0' - 1]);
                    }
                    else {
                        printf("%s", monthsExtended[date[anchor + 2] - '0' - 1]);
                    }
               }
           }
           printf("-");
           anchor = i;
        }
        else if(date[i + 1] == '\0') {
            printf("%c%c", date[i - 1], date[i]);
        }
        i++;
    }
}

%} 

separator   [\.|\-|\/]
dayFormat [0-9]?[0-9]
monthFormat [0-9]?[0-9]|[a-zA-z]*
dayMonthFormat {dayFormat}{separator}{monthFormat}
yearFormat [0-9]{2,4}
dateFormat {dayFormat}{separator}{monthFormat}{separator}{yearFormat}

%% 

{dateFormat} {formatData(yytext); }

%% 

int main() { 
    yyin=fopen("input.txt", "r"); 
    yylex(); 
    printf("\n");
    exit(0);
}