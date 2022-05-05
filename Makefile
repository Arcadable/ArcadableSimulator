#
# Cross Platform Makefile
# Compatible with MSYS2/MINGW, Ubuntu 14.04.1 and Mac OS X
#
# You will need SDL2 (http://www.libsdl.org):
# Linux:
#   apt-get install libsdl2-dev
# Mac OS X:
#   brew install sdl2
# MSYS2:
#   pacman -S mingw-w64-i686-SDL2
#

#CXX = g++
#CXX = clang++

EXE = arcadable-simulator
IMGUI_DIR = ./imgui
SRC_DIR = ./src
BUILD_DIR = ./out
SOURCES = $(SRC_DIR)/main.cpp
SOURCES += $(SRC_DIR)/gameDataInputWindow.cpp
SOURCES += $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp
SOURCES += $(IMGUI_DIR)/backends/imgui_impl_sdl.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp
OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))
UNAME_S := $(shell uname -s)
LINUX_GL_LIBS = -lGL

CXXFLAGS = -std=c++11 -I$(IMGUI_DIR) -I$(IMGUI_DIR)/backends
CXXFLAGS += -g -Wall -Wformat
LIBS =

##---------------------------------------------------------------------
## OPENGL ES
##---------------------------------------------------------------------

## This assumes a GL ES library available in the system, e.g. libGLESv2.so
# CXXFLAGS += -DIMGUI_IMPL_OPENGL_ES2
# LINUX_GL_LIBS = -lGLESv2
## If you're on a Raspberry Pi and want to use the legacy drivers,
## use the following instead:
# LINUX_GL_LIBS = -L/opt/vc/lib -lbrcmGLESv2

ECHO_MESSAGE = "Linux"
LIBS += $(LINUX_GL_LIBS)
LIBS += -ldl `sdl2-config --libs`
LIBS += -L./nfd -lnfd `pkg-config --cflags --libs gtk+-3.0`

CXXFLAGS += `sdl2-config --cflags`
CFLAGS = $(CXXFLAGS)


$(info $(shell mkdir -p $(BUILD_DIR)))


##---------------------------------------------------------------------
## BUILD RULES
##---------------------------------------------------------------------

%.o:$(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o ${BUILD_DIR}/$@ $<

%.o:$(IMGUI_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o ${BUILD_DIR}/$@ $<

%.o:$(IMGUI_DIR)/backends/%.cpp
	$(CXX) $(CXXFLAGS) -c -o ${BUILD_DIR}/$@ $<

all: $(EXE)
	@echo Build complete for $(ECHO_MESSAGE)

$(EXE): $(OBJS)
	$(CXX) -o ${BUILD_DIR}/$@ $(addprefix ${BUILD_DIR}/, $^) $(CXXFLAGS) $(LIBS)

clean:
	rm -f $(EXE) $(OBJS)
