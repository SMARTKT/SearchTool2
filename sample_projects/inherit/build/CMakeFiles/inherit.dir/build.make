# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dewang/smartKT/Running_complex_cmake/projects/inherit

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dewang/smartKT/Running_complex_cmake/projects/inherit/build

# Include any dependencies generated for this target.
include CMakeFiles/inherit.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/inherit.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/inherit.dir/flags.make

CMakeFiles/inherit.dir/src/inherit.cpp.o: CMakeFiles/inherit.dir/flags.make
CMakeFiles/inherit.dir/src/inherit.cpp.o: ../src/inherit.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dewang/smartKT/Running_complex_cmake/projects/inherit/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/inherit.dir/src/inherit.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/inherit.dir/src/inherit.cpp.o -c /home/dewang/smartKT/Running_complex_cmake/projects/inherit/src/inherit.cpp

CMakeFiles/inherit.dir/src/inherit.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/inherit.dir/src/inherit.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dewang/smartKT/Running_complex_cmake/projects/inherit/src/inherit.cpp > CMakeFiles/inherit.dir/src/inherit.cpp.i

CMakeFiles/inherit.dir/src/inherit.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/inherit.dir/src/inherit.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dewang/smartKT/Running_complex_cmake/projects/inherit/src/inherit.cpp -o CMakeFiles/inherit.dir/src/inherit.cpp.s

CMakeFiles/inherit.dir/src/inherit.cpp.o.requires:

.PHONY : CMakeFiles/inherit.dir/src/inherit.cpp.o.requires

CMakeFiles/inherit.dir/src/inherit.cpp.o.provides: CMakeFiles/inherit.dir/src/inherit.cpp.o.requires
	$(MAKE) -f CMakeFiles/inherit.dir/build.make CMakeFiles/inherit.dir/src/inherit.cpp.o.provides.build
.PHONY : CMakeFiles/inherit.dir/src/inherit.cpp.o.provides

CMakeFiles/inherit.dir/src/inherit.cpp.o.provides.build: CMakeFiles/inherit.dir/src/inherit.cpp.o


# Object files for target inherit
inherit_OBJECTS = \
"CMakeFiles/inherit.dir/src/inherit.cpp.o"

# External object files for target inherit
inherit_EXTERNAL_OBJECTS =

inherit: CMakeFiles/inherit.dir/src/inherit.cpp.o
inherit: CMakeFiles/inherit.dir/build.make
inherit: lib/libfoo.so
inherit: CMakeFiles/inherit.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dewang/smartKT/Running_complex_cmake/projects/inherit/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable inherit"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/inherit.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/inherit.dir/build: inherit

.PHONY : CMakeFiles/inherit.dir/build

CMakeFiles/inherit.dir/requires: CMakeFiles/inherit.dir/src/inherit.cpp.o.requires

.PHONY : CMakeFiles/inherit.dir/requires

CMakeFiles/inherit.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/inherit.dir/cmake_clean.cmake
.PHONY : CMakeFiles/inherit.dir/clean

CMakeFiles/inherit.dir/depend:
	cd /home/dewang/smartKT/Running_complex_cmake/projects/inherit/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dewang/smartKT/Running_complex_cmake/projects/inherit /home/dewang/smartKT/Running_complex_cmake/projects/inherit /home/dewang/smartKT/Running_complex_cmake/projects/inherit/build /home/dewang/smartKT/Running_complex_cmake/projects/inherit/build /home/dewang/smartKT/Running_complex_cmake/projects/inherit/build/CMakeFiles/inherit.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/inherit.dir/depend

