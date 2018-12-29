#
# This Dockerfile allows for "limited" testing of provision scripts
#

FROM ubuntu:16.04

RUN rm -rf scripts
RUN rm -rf /srv

ADD ./packer/scripts scripts
ADD ./salt /srv/salt

# execute initial bootstrap script
RUN scripts/setup.sh

# copy in a minion configuration
RUN cp /srv/salt/_minions/packer_web /etc/salt/minion

# use random env to avoid Docker cache
RUN random=`date` salt-call --local --refresh-grains-cache state.apply -l debug

# cleanup any salt left overs
RUN scripts/cleanup.sh
