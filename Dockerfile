# FROM mcr.microsoft.com/devcontainers/python:dev-3.11-bullseye
FROM kalilinux/kali-rolling:latest

LABEL maintainer="Esonhugh"
LABEL description="A development container for pentesting with Python 3.11, ZSH, and various tools."

# update kali source
RUN apt update 

RUN apt install -y \
    vim \
    metasploit-framework nmap \
    python3 python3-pip python3-venv 

# install uv 
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /tmp

RUN wget https://github.com/bee-san/RustScan/releases/download/2.4.1/rustscan.deb.zip 
RUN    unzip rustscan.deb.zip && \
    apt install -y ./rustscan_2.4.1-1_amd64.deb && \
    rm -rf rustscan.deb.zip rustscan_2.4.1-1_amd64.deb rustscan.tmp0-stripped

COPY --from=golang:1.24 /usr/local/go/ /usr/local/go/

ENV PATH="/root/go/bin:/usr/local/go/bin:${PATH}"
ENV PATH="/root/.pdtm/go/bin:${PATH}"

RUN go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
RUN pdtm -i simplehttpserver

# install zsh and oh-my-zsh
RUN apt install -y zsh && chsh -s /bin/zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# install 
RUN apt install -y \
    zsh-syntax-highlighting \
    zsh-autosuggestions 

RUN echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /root/.zshrc && \
    echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /root/.zshrc 

RUN apt install -y net-tools

WORKDIR /workspace

COPY .foam /workspace/.foam
COPY .vscode /workspace/.vscode
COPY launch_helper.zsh /root/

RUN echo "" >> /root/.zshrc && \
    echo "source /root/launch_helper.zsh" >> /root/.zshrc
RUN echo "" >> /root/.bashrc && \
    echo "source /root/launch_helper.zsh" >> /root/.bashrc


ENV PROJECT_FOLDER=/workspace

ENTRYPOINT [ "/bin/zsh" ]