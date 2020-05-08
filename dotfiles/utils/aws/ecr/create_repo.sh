#!/bin/bash
repo=$1

aws ecr create-repository --repository-name $1
