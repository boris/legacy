#!/bin/bash
export TODO="path/to/to-do"
sed -i -e "/^$*/d" $TODO;
