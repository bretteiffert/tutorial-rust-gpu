#!/bin/bash

set -exu

bindgen va.h -- -xc++ -std=c++14 -I/opt/nvidia/hpc_sdk/Linux_x86_64/24.5/cuda/include > bfs_bindings.rs
