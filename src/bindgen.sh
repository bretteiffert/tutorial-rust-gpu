#!/bin/bash

bindgen ../libva/va.h -- -xc++ -std=c++14 > va_bindings.rs
