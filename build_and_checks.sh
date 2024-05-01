#!/usr/bin/env bash
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

source ./wget_sha512.sh

personal_github="https://raw.githubusercontent.com/LLyaudet/"

echo "Building README.md"
script="$personal_github""DevOrSysAdminScripts/main/build_readme.sh"
correct_sha512="a7705592c14c7709f8762967f5c5d1c98d27b8ab97fe2aaa73302"
correct_sha512+="5bf641eb48c6a0e6a38c44bcbe155777290f9b837f0d059dcedb"
correct_sha512+="68b64d27677b3cdb663624c"
wget_sha512 ./build_readme.sh "$script" "$correct_sha512"
chmod +x ./build_readme.sh
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

echo "Running ESLint"
cd JS/
npm run lint
cd ..

shopt -s globstar

echo "Analyzing too long lines"
script="$personal_github"
script+="DevOrSysAdminScripts/main/too_long_code_lines.sh"
correct_sha512="eab26337506d6fabdea227c4b584391cc4a728e6b852be2232a7e"
correct_sha512+="4d21261eb356df77257b0ea7152c9587ce89a963732fc644caf1"
correct_sha512+="38c21ee51932e6fa6168bf9"
wget_sha512 ./too_long_code_lines.sh "$script" "$correct_sha512"
source ./too_long_code_lines.sh
too_long_code_lines | grep -v "JS/node_modules/"\
  | grep -v "JS/package-lock.json"

echo "Analyzing shell scripts beginning"
script="$personal_github"
script+="DevOrSysAdminScripts/main/check_shell_scripts_beginning.sh"
correct_sha512="ea0876c47a328eca96fae36f9b25a5cab01987178f23c3f71f4e8"
correct_sha512+="b6dcf8dd24e47727265b102c3138a38d1f3bb9c116675a437190"
correct_sha512+="8b1bc7ae24b79e9bd5a8715"
wget_sha512 ./check_shell_scripts_beginning.sh "$script"\
  "$correct_sha512"
source ./check_shell_scripts_beginning.sh
check_shell_scripts_beginning
