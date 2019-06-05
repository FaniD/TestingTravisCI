# Batch-build docker container layers for NextCloudPi
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#

set -e

version=$(git describe --tags --always)
version=${version%-*-*}

function build_arch()
{
  local arch="${1}"
  local arch_qemu="${2}"
  local ncp_tag="${3:-$arch}"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ncp_tag}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

[[ "$@" =~ "x86"   ]] && build_arch amd64   x86_64  x86
[[ "$@" =~ "armhf" ]] && build_arch armhf   arm
[[ "$@" =~ "arm64" ]] && build_arch arm64v8 aarch64 arm64
