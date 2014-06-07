/*
 * Copyright (C) 2014  Xiao-Long Chen <chenxiaolong@cxl.epac.to>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <shlwapi.h>
#include <windows.h>
#include <cstdio>
#include <iostream>
#include <string>

#ifndef APPLICATION
#define APPLICATION "bin\\gnometris.exe"
#endif

#ifndef DATADIR
#define DATADIR "share"
#endif

#ifndef SCORESDIR
#define SCORESDIR "var\\games"
#endif

int mainProg(std::string progArgs) {
    putenv(("DATADIR=" + std::string(DATADIR)).c_str());
    putenv(("SCORESDIR=" + std::string(SCORESDIR)).c_str());
#ifdef LANG
    putenv(("LANG=" + std::string(LANG)).c_str());
#endif
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    BOOL ret = CreateProcess(
        (LPSTR) APPLICATION,
        NULL,
        NULL,
        NULL,
        FALSE,
        0,
        NULL,
        NULL,
        &si,
        &pi
    );

    if (!ret) {
        printf("CreateProcess failed (%d).\n", GetLastError());
        return 1;
    }

    WaitForSingleObject(pi.hProcess, INFINITE);

    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    return 0;
}

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR lpCmdLine,
                     int nCmdShow) {
    return mainProg(lpCmdLine);
}
