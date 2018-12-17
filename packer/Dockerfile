FROM ubuntu:16.04

ADD ./scripts scripts
ADD ./ansible ansible

RUN scripts/bootstrap.sh
RUN ansible-playbook ansible/local.yml
