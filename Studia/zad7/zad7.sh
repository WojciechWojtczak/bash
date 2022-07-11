#!/bin/bash
#Napisz program ktory znajdzie wszystkie skrypty shellowe w biezacym katalogu
sudo grep -rIzl '^#![[:blank:]]*/bin/sh' ./
