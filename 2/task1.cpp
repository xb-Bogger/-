#include <iostream>
#include <thread>
#include <windows.h>

DWORD WINAPI add(LPVOID)
{
	for (int i = 1; i<=1000; i++) {
		std::cout << "A:" << i << std::endl;
		Sleep(200);
	}
	return 1;
}


DWORD WINAPI dec(PVOID pParam) {
	for (int i = 1000; i > 0; i--) {
		std::cout << "B:" << i << std::endl;
		Sleep(200);
	}

	return 0;
}

int main() {

	HANDLE hthread[2];
	DWORD threadID;
	DWORD threadID1;
	hthread[0] = CreateThread(NULL, 0, add, (LPVOID)1, 0, &threadID);
	hthread[1] = CreateThread(NULL, 0, dec, (LPVOID)2, 0, &threadID1);
	WaitForMultipleObjects(2, hthread, TRUE, INFINITE);
	return 0;
}
