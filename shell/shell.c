


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define TOK_DELIM " \t\r\n\a"

int main() {
    char *line = NULL;
    size_t bufsize = 0;
    
    while (1) {
        printf("myshell> ");
        if (getline(&line, &bufsize, stdin) == -1) break;

        char *args[64];
        int i = 0;
        char *token = strtok(line, TOK_DELIM);
        while (token != NULL && i < 63) {
            args[i++] = token;
            token = strtok(NULL, TOK_DELIM);
        }
        args[i] = NULL;

        if (args[0] == NULL) continue;
        if (strcmp(args[0], "exit") == 0) break;

        if (strcmp(args[0], "cd") == 0) {
            if (args[1] == NULL) fprintf(stderr, "expected argument to \"cd\"\n");
            else if (chdir(args[1]) != 0) perror("myshell");
            continue;
        }

        pid_t pid = fork();
        if (pid == 0) {
            if (execvp(args[0], args) == -1) perror("myshell");
            exit(EXIT_FAILURE);
        } else if (pid < 0) perror("myshell");
        else waitpid(pid, NULL, 0);
    }
    free(line);
    return 0;
}


