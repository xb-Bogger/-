#undef UNICODE
#include <stdio.h>
#include <windows.h>
#include <time.h>
#include <string>


int i = 0;
std::string name[5] = { "0","1","2","3","4" };
int a[5] = { 1,1,1,1,1 };
int random(void) {
	int a = time(NULL);
	srand(a);
	return (rand() % 400 + 100);
}
//子线程函数  
DWORD WINAPI philosopher(LPVOID lpParam) {
	srand((unsigned)time(NULL));
	int id = i++;
	int time;
	HANDLE right, left;
	left = OpenSemaphore(SEMAPHORE_ALL_ACCESS, FALSE, name[id].c_str());//通过信号量名，获得信号量对象句柄
	right = OpenSemaphore(SEMAPHORE_ALL_ACCESS, FALSE, name[(id + 4) % 5].c_str());
	while (1) {
		time = random();
		printf("哲学家%d开始思考，将思考%dms\n", id, time);
		Sleep(time);
		time = random();
		printf("哲学家%d开始休息，将休息%dms\n", id, time);
		Sleep(time);

		if (id == 0) {//先取左边的筷子
			//p(left)
			WaitForSingleObject(left, INFINITE);
			printf("哲学家%d取了左手边的筷子\t%d\n", id, id);
			//p(right)
			WaitForSingleObject(right, INFINITE);
			printf("哲学家%d取了右手边的筷子\t%d\n", id, (id + 4) % 5);
		}
		else {//先取右边的筷子
			//p(right)
			WaitForSingleObject(right, INFINITE);
			printf("哲学家%d取了右手边的筷子\t%d\n", id, (id + 4) % 5);
			//p(left)
			WaitForSingleObject(left, INFINITE);
			printf("哲学家%d取了左手边的筷子\t%d\n", id, id);
		}
		
		//吃饭
		time = random();
		printf("哲学家%d开始吃饭，将吃饭%dms\n", id, time);
		Sleep(time);
		//v
		ReleaseSemaphore(left, 1, NULL);
		printf("哲学家%d放下左手边的筷子\t%d\n", id, id);
		ReleaseSemaphore(right, 1, NULL);
		printf("哲学家%d放下右手边的筷子\t%d\n", id, (id + 4) % 5);
	}
}
int main(void) {
	HANDLE S[5]; //五个信号量
	HANDLE hThread[5]; //五个线程
	for (int i = 0; i < 5; i++) {
		S[i] = CreateSemaphore(NULL, 1, 1, name[i].c_str());
	}

	for (int i = 0; i < 5; i++) {
		hThread[i] = CreateThread(NULL, 0, philosopher, NULL, 0, NULL);
	}
	WaitForMultipleObjects(5, hThread, TRUE, INFINITE); 	//等待子线程运行 
	for (int i = 0; i < 5; i++) {
		CloseHandle(S[i]);
	}
}


