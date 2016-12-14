#FROM andrewosh/binder-base:latest

USER root
RUN apt-get update -qq && \
     apt-get install -y --no-install-recommends \
#    libblas-dev \
#    liblapack-dev \
#    libatlas-base-dev \
#    libsuitesparse-dev \
     gfortran

RUN conda remove libgfortran
RUN conda install libgcc --force

#install cvxopt with conda
#RUN conda install -c anaconda cvxopt=1.1.9

#install cvxopt with pip
#RUN pip install --upgrade pip
#RUN pip install CVXOPT

#manual install of cvxopt
# install CVXOPT, according to this: http://cvxopt.org/install/index.html
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libblas-dev \
    liblapack-dev 

RUN wget https://github.com/cvxopt/cvxopt/archive/1.1.8.tar.gz && \
    tar xzvf 1.1.8.tar.gz && \
    cd cvxopt-1.1.8 && \
    python setup.py install 

# verify everything worked
# RUN cd cvxopt-1.1.8/examples/book/chap4 && python rls.py

RUN wget http://download.mosek.com/stable/7.0.0.141/mosektoolslinux64x86.tar.bz2 && \
    tar xvf mosektoolslinux64x86.tar.bz2 
    
ENV PATH $HOME/mosek/7/tools/platform/linux64x86/bin:$PATH 
RUN cd mosek/7/tools/platform/linux64x86/python/2/ && python setup.py install


USER main
