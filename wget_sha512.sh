#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# You should have received a copy of
# the GNU Lesser General Public License
# along with DevOrSysAdminScripts.
# If not, see <http://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Lyaudet

wget_sha512(){
  # $1 filename
  # $2 download_URL
  # $3 correct_sha512
  if [[ ! -f "$1" ]];
  then
    wget "$2"
  fi
  present_sha512=$(sha512sum "$1" | cut -f1 -d' ')
  if [[ "$present_sha512" != "$3" ]];
  then
    echo "$1 does not have correct sha512"
    echo "wanted $3"
    echo "found $present_sha512"
    exit
  fi
}
