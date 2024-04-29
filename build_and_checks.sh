#!/bin/bash
# This file is part of RatioDelta library.
#
# RatioDelta is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# RatioDelta is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# You should have received a copy of
# the GNU Lesser General Public License
# along with RatioDelta.
# If not, see <http://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Lyaudet

echo "Building README.md"
personal="https://raw.githubusercontent.com/LLyaudet/"
scripts="DevOrSysAdminScripts/main/build_readme.sh"
correct_sha512="22a1b5118dbc79193b632f554772d75a506cf958a671d48b8a185"
correct_sha512+="138ea43e6e733c7a07ed322ae17f45d52323e7c948eae016e2a7"
correct_sha512+="4882d798ec8f7af1b27e6bf"
if [[ ! -f "./build_readme.sh" ]];
then
  wget "$personal""$scripts"
fi
chmod +x ./build_readme.sh
present_sha512=`sha512sum ./build_readme.sh`
if [[ "$present_sha512" != "$correct_sha512" ]];
then
  echo "build_readme.sh does not have correct sha512"
  echo "wanted $correct_sha512"
  echo "found $present_sha512"
  exit
fi
./build_readme.sh
./build_readme.sh JS/
./build_readme.sh Python/

echo "Running isort"
isort .

echo "Running black"
black .

echo "Running pylint"
pylint Python/src/ratio_delta/

echo "Running mypy"
mypy .

shopt -s globstar

too_long_code_lines() {
  grep -r '.\{71\}' -- **/*.c
  grep -r '.\{71\}' -- **/*.css
  grep -r '.\{71\}' -- **/*.h
  grep -r '.\{71\}' -- **/*.htm
  grep -r '.\{71\}' -- **/*.html
  grep -r '.\{71\}' -- **/*.js
  grep -r '.\{71\}' -- **/*.json
  grep -r '.\{71\}' -- **/*.md
  grep -r '.\{71\}' -- **/*.php
  grep -r '.\{71\}' -- **/*.py
  grep -r '.\{71\}' -- **/*.sql
  grep -r '.\{71\}' -- **/*.tex
  grep -r '.\{71\}' -- **/*.toml
  grep -r '.\{71\}' -- **/*.ts
  grep -r '.\{71\}' -- **/*.txt
  grep -r '.\{71\}' -- **/*.yml
  grep -r '.\{71\}' -- **/COPYING
  grep -r '.\{71\}' -- **/COPYING.LESSER
}

echo "Analyzing too long lines"
too_long_code_lines | grep -v "JS/node_modules/"\
  | grep -v "JS/package-lock.json"

