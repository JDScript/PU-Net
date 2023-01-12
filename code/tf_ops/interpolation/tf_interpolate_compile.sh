#!/usr/bin/env bash
nvcc=/usr/local/cuda/bin/nvcc
cudalib=/usr/local/cuda/lib64/
TF_INC=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

g++ tf_interpolate.cpp -o tf_interpolate_so.so -std=c++17  -shared -ltensorflow_framework -fPIC -I $TF_INC  \
-I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -fPIC -lcudart -L $cudalib -O2
