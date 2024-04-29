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
script="DevOrSysAdminScripts/main/build_readme.sh"
correct_sha512="1081750df32198ae3835fbbe3d2d55c9b7096c2d571fadbff433e"
correct_sha512+="51dad58d1b66b66c1378543e1ef20b78597b4b11a4b97b723911"
correct_sha512+="ef7045870d53a68ceedd4e1"
if [[ ! -f "./build_readme.sh" ]];
then
  wget "$personal""$script"
fi
chmod +x ./build_readme.sh
present_sha512=`sha512sum ./build_readme.sh | cut -f1 -d' '`
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

echo "Analyzing too long lines"
personal="https://raw.githubusercontent.com/LLyaudet/"
script="DevOrSysAdminScripts/main/too_long_code_lines.sh"
correct_sha512="4f3cd19bd91bb2b258a7d705c468b69a3db7d75187c29756f7968"
correct_sha512+="1cc7fb69e0a55439d8cd4a5c05b769960a66f03f150044b2dc4a"
correct_sha512+="8d21b65f4f4ed84b5276c58"
if [[ ! -f "./too_long_code_lines.sh" ]];
then
  wget "$personal""$script"
fi
chmod +x ./too_long_code_lines.sh
present_sha512=`sha512sum ./too_long_code_lines.sh | cut -f1 -d' '`
if [[ "$present_sha512" != "$correct_sha512" ]];
then
  echo "too_long_code_lines.sh does not have correct sha512"
  echo "wanted $correct_sha512"
  echo "found $present_sha512"
  exit
fi
source ./too_long_code_lines.sh
too_long_code_lines | grep -v "JS/node_modules/"\
  | grep -v "JS/package-lock.json"

