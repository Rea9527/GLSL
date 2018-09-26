ifeq ($(OS),Windows_NT)
PLATFORM="Windows"
else
ifeq ($(shell uname),Darwin)
PLATFORM="MacOS"
else
PLATFORM="Unix-Like"
endif
endif

# set current path
# PWD = $(shell pwd)
# SRCDIR = $(PWD)/src
# COREDIR = $(PWD)/GL_CORE

# source code path
# src_dirpaths += $(PWD)
# src_dirpaths += $(SRCDIR)
# vpath %.cpp $(src_dirpaths)


CC = gcc
CXX = g++


# includes and libraries
INCLUDES = -I$(glfw_inc) -I$(glm_inc)
LIBRARIES = -L$(glfw_lib)
#  glfw
glfw = ./depdcs/glfw
glfw_inc = $(glfw)/includes
glfw_lib = $(glfw)/libs
# gl core
glcore_inc = ./GL_CORE
# gl math
glm = ./depdcs/glm
glm_inc = $(glm)/includes


# c flags
ifeq ($(PLATFORM), "MacOS")
CFLAGS = -I$(glcore_inc) -DGL_DO_NOT_WARN_IF_MULTI_GL_VERSION_HEADERS_INCLUDED
else
CFLAGS = -I$(glcore_inc) 
endif

# c++ flags
ifeq ($(PLATFORM), "MacOS")
CXXFLAGS = $(INCLUDES) -DGL_DO_NOT_WARN_IF_MULTI_GL_VERSION_HEADERS_INCLUDED
else
CXXFLAGS = $(INCLUDES) 
endif

# link flags
ifeq ($(PLATFORM), "MacOS")
LDFLAGS = $(LIBRARIES) -lglfw3 -framework Cocoa -framework IOKit -framework CoreVideo -framework OpenGL
else
LDFLAGS = $(LIBRARIES) -lglfw3 -lopengl32 -lglu32
endif

# # 
# src_names = $(foreach dir, $(src_dirpaths), $(filter %.cpp, $(shell ls $(dir))))

# # 
# obj_names = $(patsubst %.cpp, %.o, $(src_names))

# # add .o filepath corresponding to .cpp files
# obj_dirpath = $(PWD)/objs
# $(shell mkdir -p $(obj_dirpath))
# obj_filepaths = $(foreach objname, $(obj_names), $(obj_dirpath)/$(objname));

TARGET = main.out
cpp_files = main.cpp
objects = $(cpp_files: .cpp=.o)
headers = main.h

all: clean $(TARGET)

$(TARGET): $(objects) gl_core_4_3.o
				$(CXX) -o $@ $^ $(LDFLAGS)

$(objects): %.o: %.cpp $(headers)
				$(CXX) $(CXXFLAGS) -c -o $@ $<

gl_core_4_3.o: GL_CORE/gl_core_4_3.c
				$(CC) $(CFLAGS) -c -o $@ $<

.PHONY: clean cleanall cleanobj
clean: cleanall cleanobj
		@-$(RM) $(TARGET)
