# spectreScope
The demo of the speculative execution attack Spectre (CVE-2017-5753, CVE-2017-5715).

## Supported Platforms

* macOS
* Linux
* Oracle Solaris
* Windows (not tested)

## Preconditions

The following applications must be installed:
* [Git](https://git-scm.com);
* [CMake](https://cmake.org/);
* C++ compiler: GCC, Clang, Xcode, Oracle Solaris Studio, Microsoft Visual Studio.

## Build & Run

```
git clone git@github.com:ixtal23/spectreScope.git
cd spectreScope
./build.sh
./run.sh
```

## Results

### Apple MacBook Pro Retina, 15-inch, Late 2013, macOS High Sierra 10.13.2, Intel(R) Core(TM) i7-4750HQ CPU @ 2.00GHz

```
dev$ git --version
git version 2.14.3 (Apple Git-98)
dev$ cmake --version
cmake version 3.10.1
CMake suite maintained and supported by Kitware (kitware.com/cmake).
dev$ xcodebuild -version
Xcode 9.2
Build version 9C40b
dev$ git clone git@github.com:ixtal23/spectreScope.git
Cloning into 'spectreScope'...
remote: Counting objects: 39, done.
remote: Compressing objects: 100% (24/24), done.
remote: Total 39 (delta 16), reused 32 (delta 12), pack-reused 0
Receiving objects: 100% (39/39), 13.66 KiB | 1.71 MiB/s, done.
Resolving deltas: 100% (16/16), done.
dev$ cd spectreScope
spectreScope$ ./build.sh
-- The CXX compiler identification is AppleClang 9.0.0.9000039
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Generating done
-- Configuring done
-- Build files have been written to: /Users/user/Documents/dev/spectreScope/cmake.build
/opt/local/bin/cmake -H/Users/user/Documents/dev/spectreScope -B/Users/user/Documents/dev/spectreScope/cmake.build --check-build-system CMakeFiles/Makefile.cmake 0
/opt/local/bin/cmake -E cmake_progress_start /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles/progress.marks
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/Makefile2 all
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/spectreScope.dir/build.make CMakeFiles/spectreScope.dir/depend
cd /Users/user/Documents/dev/spectreScope/cmake.build && /opt/local/bin/cmake -E cmake_depends "Unix Makefiles" /Users/user/Documents/dev/spectreScope /Users/user/Documents/dev/spectreScope /Users/user/Documents/dev/spectreScope/cmake.build /Users/user/Documents/dev/spectreScope/cmake.build /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles/spectreScope.dir/DependInfo.cmake --color=
Scanning dependencies of target spectreScope
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/spectreScope.dir/build.make CMakeFiles/spectreScope.dir/build
[ 50%] Building CXX object CMakeFiles/spectreScope.dir/src/main.cpp.o
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++    -O3 -DNDEBUG   -o CMakeFiles/spectreScope.dir/src/main.cpp.o -c /Users/user/Documents/dev/spectreScope/src/main.cpp
[100%] Linking CXX executable spectreScope
/opt/local/bin/cmake -E cmake_link_script CMakeFiles/spectreScope.dir/link.txt --verbose=1
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  -O3 -DNDEBUG -Wl,-search_paths_first -Wl,-headerpad_max_install_names  CMakeFiles/spectreScope.dir/src/main.cpp.o  -o spectreScope
[100%] Built target spectreScope
/opt/local/bin/cmake -E cmake_progress_start /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles 0
/opt/local/bin/cmake -H/Users/user/Documents/dev/spectreScope -B/Users/user/Documents/dev/spectreScope/cmake.build --check-build-system CMakeFiles/Makefile.cmake 0
/opt/local/bin/cmake -E cmake_progress_start /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles/progress.marks
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/Makefile2 all
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/spectreScope.dir/build.make CMakeFiles/spectreScope.dir/depend
cd /Users/user/Documents/dev/spectreScope/cmake.build && /opt/local/bin/cmake -E cmake_depends "Unix Makefiles" /Users/user/Documents/dev/spectreScope /Users/user/Documents/dev/spectreScope /Users/user/Documents/dev/spectreScope/cmake.build /Users/user/Documents/dev/spectreScope/cmake.build /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles/spectreScope.dir/DependInfo.cmake --color=
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/spectreScope.dir/build.make CMakeFiles/spectreScope.dir/build
make[2]: Nothing to be done for `CMakeFiles/spectreScope.dir/build'.
[100%] Built target spectreScope
/opt/local/bin/cmake -E cmake_progress_start /Users/user/Documents/dev/spectreScope/cmake.build/CMakeFiles 0
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f CMakeFiles/Makefile2 preinstall
make[1]: Nothing to be done for `preinstall'.
Install the project...
/opt/local/bin/cmake -P cmake_install.cmake
-- Install configuration: "Release"
-- Installing: /Users/user/Documents/dev/spectreScope/bin/spectreScope
spectreScope$ ./run.sh
Spectre Attack
Reading 44 bytes
 1 reading at malicious_x=0xfffffffffffffe6a: success value=0x59 [ Y ] score=  2
 2 reading at malicious_x=0xfffffffffffffe6b: success value=0x6f [ o ] score=  9, second best value=0x01 [ ? ] score=  2
 3 reading at malicious_x=0xfffffffffffffe6c: success value=0x75 [ u ] score=  9, second best value=0x01 [ ? ] score=  2
 4 reading at malicious_x=0xfffffffffffffe6d: success value=0x72 [ r ] score=  2
 5 reading at malicious_x=0xfffffffffffffe6e: success value=0x20 [   ] score=  2
 6 reading at malicious_x=0xfffffffffffffe6f: success value=0x43 [ C ] score=  2
 7 reading at malicious_x=0xfffffffffffffe70: success value=0x50 [ P ] score=  2
 8 reading at malicious_x=0xfffffffffffffe71: success value=0x55 [ U ] score=  2
 9 reading at malicious_x=0xfffffffffffffe72: success value=0x20 [   ] score=  2
10 reading at malicious_x=0xfffffffffffffe73: success value=0x69 [ i ] score=  2
11 reading at malicious_x=0xfffffffffffffe74: success value=0x73 [ s ] score=  2
12 reading at malicious_x=0xfffffffffffffe75: success value=0x20 [   ] score=  2
13 reading at malicious_x=0xfffffffffffffe76: success value=0x63 [ c ] score=  2
14 reading at malicious_x=0xfffffffffffffe77: success value=0x72 [ r ] score=  2
15 reading at malicious_x=0xfffffffffffffe78: success value=0x61 [ a ] score=  2
16 reading at malicious_x=0xfffffffffffffe79: success value=0x70 [ p ] score=  2
17 reading at malicious_x=0xfffffffffffffe7a: success value=0x2e [ . ] score=  2
18 reading at malicious_x=0xfffffffffffffe7b: success value=0x20 [   ] score=  2
19 reading at malicious_x=0xfffffffffffffe7c: success value=0x54 [ T ] score=  2
20 reading at malicious_x=0xfffffffffffffe7d: success value=0x68 [ h ] score=  2
21 reading at malicious_x=0xfffffffffffffe7e: success value=0x61 [ a ] score=  2
22 reading at malicious_x=0xfffffffffffffe7f: success value=0x6e [ n ] score=  2
23 reading at malicious_x=0xfffffffffffffe80: success value=0x6b [ k ] score=  2
24 reading at malicious_x=0xfffffffffffffe81: success value=0x20 [   ] score=  2
25 reading at malicious_x=0xfffffffffffffe82: success value=0x79 [ y ] score=  2
26 reading at malicious_x=0xfffffffffffffe83: success value=0x6f [ o ] score=  2
27 reading at malicious_x=0xfffffffffffffe84: success value=0x75 [ u ] score=  2
28 reading at malicious_x=0xfffffffffffffe85: success value=0x20 [   ] score=  2
29 reading at malicious_x=0xfffffffffffffe86: success value=0x76 [ v ] score=  2
30 reading at malicious_x=0xfffffffffffffe87: success value=0x65 [ e ] score=  2
31 reading at malicious_x=0xfffffffffffffe88: success value=0x72 [ r ] score=  2
32 reading at malicious_x=0xfffffffffffffe89: success value=0x79 [ y ] score=  2
33 reading at malicious_x=0xfffffffffffffe8a: success value=0x20 [   ] score=  2
34 reading at malicious_x=0xfffffffffffffe8b: success value=0x6d [ m ] score=  2
35 reading at malicious_x=0xfffffffffffffe8c: success value=0x75 [ u ] score=  2
36 reading at malicious_x=0xfffffffffffffe8d: success value=0x63 [ c ] score=  2
37 reading at malicious_x=0xfffffffffffffe8e: success value=0x68 [ h ] score=  2
38 reading at malicious_x=0xfffffffffffffe8f: success value=0x20 [   ] score=  2
39 reading at malicious_x=0xfffffffffffffe90: success value=0x49 [ I ] score=  2
40 reading at malicious_x=0xfffffffffffffe91: success value=0x6e [ n ] score=  2
41 reading at malicious_x=0xfffffffffffffe92: success value=0x74 [ t ] score=  2
42 reading at malicious_x=0xfffffffffffffe93: success value=0x65 [ e ] score=  2
43 reading at malicious_x=0xfffffffffffffe94: success value=0x6c [ l ] score=  2
44 reading at malicious_x=0xfffffffffffffe95: success value=0x21 [ ! ] score=  2
spectreScope$
```
