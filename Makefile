# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -std=c++11 -I./third_party/eigen -O3 -g -Wall

# Directories
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

# Subdirectories under BUILD_DIR for layers, losses, optimizers, etc.
BUILD_SUBDIRS = $(BUILD_DIR)/layer $(BUILD_DIR)/loss $(BUILD_DIR)/optimizer

# Source files (including demo.cc, mnist.cc, and network.cc)
SRCS = $(wildcard $(SRC_DIR)/**/*.cc) demo.cc src/mnist.cc src/network.cc

# Object files
OBJS = $(patsubst %.cc,$(BUILD_DIR)/%.o,$(subst $(SRC_DIR)/,,$(SRCS)))

# Target executable
TARGET = $(BIN_DIR)/demo

# Create build and bin directories if they don't exist
$(shell mkdir -p $(BUILD_DIR) $(BIN_DIR) $(BUILD_SUBDIRS))

# Default target to build everything
all: clean dirs $(TARGET)

# Target to build the demo program
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Compile .cc files into .o files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/demo.o: demo.cc
	$(CXX) $(CXXFLAGS) -c demo.cc -o $(BUILD_DIR)/demo.o

$(BUILD_DIR)/mnist.o: src/mnist.cc
	$(CXX) $(CXXFLAGS) -c src/mnist.cc -o $(BUILD_DIR)/mnist.o

$(BUILD_DIR)/network.o: src/network.cc
	$(CXX) $(CXXFLAGS) -c src/network.cc -o $(BUILD_DIR)/network.o

# Ensure that necessary directories exist
dirs:
	mkdir -p $(BUILD_DIR) $(BIN_DIR) $(BUILD_SUBDIRS)

# Clean build files
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)/demo

# Phony targets
.PHONY: all clean dirs
