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
    char scwd[LINE_MAX] = "";
    char const *cwd;
    char const *slash, *nslash;

    if(argc > 1) {
        cwd = argv[1];
    } else {
        cwd  = getcwd(NULL, 0);
    }

    /* Replace home path */
    if(!strncmp(cwd, home, strlen(home))) {
        strncpy(scwd, HOME_REPL, LINE_MAX);
        slash = strstr(cwd+strlen(home), "/");
    } else {
        slash = strstr(cwd, "/");

        /* If there is no '/', print the whole thing and finish */
        if (!slash) {
            strncpy(scwd, cwd, LINE_MAX);
            goto done;
        }

        /* If cwd does not start with '/', we abbreviate a relative directory */
        if (cwd[0] != '/') {
            strncat(scwd, cwd, DIR_LEN);
        }
    }

    /* If there is no '/' left, print cwd and finish */
    if (!slash) {
        goto done;
    }

    /* Abbreviate intermediate dirs */
    while((nslash = strstr(slash+1, "/"))) {
        strncat(scwd, slash, DIR_LEN+1);
        slash = nslash;
    }

    /* Add current base dir */
    strcat(scwd, slash);

done:
    printf("%s", scwd);
    return 0;
}
