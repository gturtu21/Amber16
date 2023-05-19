FROM ubuntu18_foramber16 AS base
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/Amber16_docker
COPY  Amber16_docker /usr/local/Amber16_docker
RUN cd /usr/local/Amber16_docker \ 
    && tar -xjvf AmberTools17.tar.bz2 \ 
    && tar -xjvf Amber16.tar.bz2 



FROM ubuntu18_foramber16 as intermediate
WORKDIR /usr/local
COPY --from=base /usr/local/Amber16_docker/amber16 /usr/local/amber16
#
#
#FROM ubuntu18_foramber16 as build
#WORKDIR /usr/local 
RUN apt-get update -y && apt-get upgrade \ 
    && export AMBERHOME="/usr/local/amber16" \ 
    && cd $AMBERHOME  \
    &&  sed -i "s/read answer/answer='Y'/" configure	 \
    && ./configure --with-python /usr/bin/python2.7 gnu \
# instead of source use '.' :
    && . /usr/local/amber16/amber.sh \ 
    && make install \
    && make test \
    && ./configure --with-python /usr/bin/python2.7 -mpi gnu \
    && make install \
    && . /usr/local/amber16/amber.sh \
    && export DO_PARALLEL="mpirun -np 2" \
    && make test \
    && export DO_PARALLEL="mpirun -np 4" \
    && make test 
    #&& echo "source $AMBERHOME/amber.sh' " >> .bashrc \
    #&& echo "export $AMBERHOME='/usr/local/amber16' " >> .bashrc 

ENV AMBERHOME=/usr/local/amber16
ENV PATH=$PATH:$AMBERHOME

ENV AMBER_PREFIX="/usr/local/amber16"
ENV AMBERHOME=/usr/local/amber16
ENV PATH="${AMBER_PREFIX}/bin:${PATH}"

#CMD ["

## TO MAKE THE FINAL IMAGE EVEN SMALLER (1GB LESS), FOLDER /test COULD BE REMOVED
