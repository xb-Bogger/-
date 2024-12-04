#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid;
    int status;

    // 创建子进程
    pid = fork();

    if (pid < 0) {
        // fork失败
        perror("fork failed");
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        // 子进程
        printf("Child process, PID: %d\n", getpid());
        // 子进程休眠5秒
        sleep(5);
        // 子进程退出，返回值42
        exit(42);
    } else {
        // 父进程
        printf("Parent process, PID: %d\n", getpid());
        // 父进程调用wait等待子进程结束
        if (wait(&status) == -1) {
            perror("wait failed");
            exit(EXIT_FAILURE);
        }
        // 检查子进程是否正常结束
        if (WIFEXITED(status)) {
            int exit_status = WEXITSTATUS(status);
            printf("Child process exited with status %d\n", exit_status);
        }
    }

    return 0;
}
