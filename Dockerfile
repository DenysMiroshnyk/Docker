# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update the package list and install essential tools and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    clang \
    git \
    python3-pip

# Install Conan 1.58
RUN pip3 install conan==1.58.0

# Download and extract CMake 3.27.5
RUN wget https://github.com/Kitware/CMake/releases/download/v3.27.5/cmake-3.27.5-linux-x86_64.tar.gz && \
    tar -xzvf cmake-3.27.5-linux-x86_64.tar.gz -C /usr/local --strip-components=1

# Set environment variables
ENV CC=clang
ENV CXX=clang++

# Download and install the Vulkan SDK
RUN wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | tee /etc/apt/trusted.gpg.d/lunarg.asc && \
    wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.3.261-jammy.list https://packages.lunarg.com/vulkan/1.3.261/lunarg-vulkan-1.3.261-jammy.list && \
    apt-get update && \
    apt-get install -y vulkan-sdk

# Clean up temporary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf vulkan-sdk.tar.gz VulkanSDK \
    rm cmake-3.27.5-linux-x86_64.tar.gz
