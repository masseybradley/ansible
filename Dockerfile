# syntax=docker/dockerfile:experimental
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV PATH /ansible/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && \
    apt-get -y install \
        git \
        openssh-client \
        python3.7 \
        python3.7-dev \
        python3-pip \
        python3-setuptools \
        python3-pygit2 \
        build-essential \
        libssl-dev \
        libffi-dev \
        man

RUN groupadd -g 1000 ansible && \
    useradd -u 1000 -g ansible -d /home/ansible -m -k /etc/skel -s /bin/bash ansible

RUN mkdir -p -m 0600 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh git clone -b devel https://github.com/ansible/ansible.git /ansible && \
    chown -R 1000:1000 /ansible

RUN python3 -m pip install -r /ansible/requirements.txt

RUN ln -s /usr/bin/python3 /usr/bin/python

USER ansible
RUN echo '. /ansible/hacking/env-setup' >> /home/ansible/.bashrc
ENTRYPOINT ["/ansible/bin/ansible"]
