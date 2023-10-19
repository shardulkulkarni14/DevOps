#!/bin/bash
tar -xvf myTestRepo.tar
chmod +x myTestRepo
git config --global --add safe.directory /drone/src/feature111/myTestRepo
