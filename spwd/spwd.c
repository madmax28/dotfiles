#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include <string.h>
#include <limits.h>
#include <stdio.h>

#define DIR_LEN         1
#define HOME_REPL       "~"

int main(int argc, char **argv) {

    char const *home = getpwuid(getuid())->pw_dir;
    char const *cwd  = getwd(NULL);
    char scwd[LINE_MAX];

    char const *slash, *nslash;

    /* Replace home path */
    if(!strncmp(cwd, home, strlen(home))) {
        strcpy(scwd, HOME_REPL);
    }

    /* Abbreviate intermediate dirs */
    slash = strstr(cwd+strlen(home), "/");
    while((nslash = strstr(slash+1, "/"))) {
        strncat(scwd, slash, DIR_LEN+1);
        slash = nslash;
    }

    /* Add current base dir */
    strcat(scwd, slash);

    printf("%s", scwd);
    return 0;
}
