#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:16.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git htop man unzip vim wget && \
  apt-get install -y silversearcher-ag && \
  apt-get install -y zsh && \
  apt-get install -y net-tools && \
  apt-get install -y npm && \
  apt-get install -y autojump && \
  apt-get install -y iputils-ping

# Install oh-my-zsh and vim
RUN \
  chsh -s /bin/zsh && \
  mkdir -p ~/.tmp && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.zshrc /root/.zshrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.vim /root/.vim
ADD root/.oh-my-zsh /root/.oh-my-zsh

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
