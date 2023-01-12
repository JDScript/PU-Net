#!/usr/bin/env bash
nvcc=/usr/local/cuda/bin/nvcc
cudainc=/usr/local/cuda/include/
cudalib=/usr/local/cuda/lib64/
TF_INC=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

$nvcc tf_sampling_g.cu -c -o tf_sampling_g.cu.o  -D_GLIBCXX_USE_CXX11_ABI=0 -std=c++17  -I $TF_INC -DGOOGLE_CUDA=1\
 -x cu -Xcompiler -fPIC -O2

g++ tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -std=c++17 -shared -fPIC -I $TF_INC \
-I$TF_INC/external/nsync/public -I $cudainc -L$TF_LIB -fPIC -lcudart -L $cudalib -O2 -D_GLIBCXX_USE_CXX11_ABI=0
