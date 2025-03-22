#!/usr/bin/env bash
#
# Usage:
#   ./bootstrap.sh <ProjectName> <NamespaceName>
#

set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <ProjectName> <NamespaceName>"
  exit 1
fi

APP_NAME=$1
APP_NAMESPACE=$2

echo ">>> Generating project '$APP_NAME' with namespace '$APP_NAMESPACE'..."

rm -rf build_bootstrap
mkdir build_bootstrap

cmake -DAPP_NAME="${APP_NAME}" -DAPP_NAMESPACE="${APP_NAMESPACE}" \
      -S . -B build_bootstrap

if [ ! -d build_bootstrap/generated ]; then
  echo ">>> Error: not found build_bootstrap/generated"
  exit 1
fi

mv build_bootstrap/generated "./${APP_NAME}"

if [ -d vcpkg ]; then
  echo ">>> Copying vcpkg into ${APP_NAME}..."
  cp -R vcpkg "./${APP_NAME}"
else
  echo ">>> vcpkg folder not found in current directory, skipping copy."
fi

cd "${APP_NAME}"
git init
git add .
git commit -m "Initial commit of ${APP_NAME} project"

cd ..

echo ">>> Removing template files and build_bootstrap..."
rm -rf build_bootstrap
rm -rf template
rm -rf vcpkg
rm -f bootstrap.CMakeLists.txt
rm -f bootstrap.sh
rm -f bootstrap.bat
rm -f CMakeLists.txt
rm -f LICENSE

echo ">>> Done!"
echo ">>> Folder '${APP_NAME}' is now a standalone C++/CMake/vcpkg project with Git initialized."

