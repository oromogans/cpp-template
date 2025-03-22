# C++/CMake/VCPKG Template

This repository provides a ready-to-use template for C++ projects based on CMake and VCPKG. It includes:

- A sample setup for **GoogleTest**, **fmt**, and **Microsoft.GSL**.
- Configuration for `clang-format` and `clang-tidy`.
- A collection of `.in` template files that allow you to automatically substitute the project name, namespace, and other parameters.
- An optional **vcpkg** submodule to make dependency management simpler.

## Quick Start

1. **Clone the repository (with submodules, if needed):**
   ```bash
   git clone --recurse-submodules https://github.com/<username>/<repo-name>.git
   ```
If you forgot to include --recurse-submodules, run:

git submodule update --init --recursive
(Optional) Build vcpkg if it is included as a submodule and not already built:
```
cd vcpkg
./bootstrap-vcpkg.sh
cd ..
```
On Windows:
```
cd vcpkg
.\bootstrap-vcpkg.bat
cd ..
```
2. **Generate the project using the bootstrap file:**
```
mkdir build_bootstrap
cd build_bootstrap
cmake -DPROJECT_NAME=MyNewApp -DNAMESPACE_NAME=my_namespace \
      -S .. -B .
```
This step generates a complete C++ project in the build_bootstrap/generated/ directory, with your chosen project and namespace names.
Build the generated project:
```
cd generated
mkdir build
cd build
cmake -S .. -B . -DCMAKE_TOOLCHAIN_FILE=../../vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build .
```
Adjust the path to vcpkg/scripts/buildsystems/vcpkg.cmake if needed, or omit it if you are using a global vcpkg installation. The application (e.g., MyNewApp) will build along with any dependencies from vcpkg.
Run the newly built application:
```
./MyNewApp
```
You should see output indicating the project and namespace you specified.
## Repository Structure**

vcpkg/ – (Optional) Submodule for vcpkg if you prefer to bundle it with the template.
template/ – Contains the .in files (e.g., CMakeLists.txt.in, main.cpp.in, weather.hpp.in) that define the template structure.
bootstrap.CMakeLists.txt – A CMake file used to generate a project from the .in templates. It substitutes variables like @PROJECT_NAME@ and @NAMESPACE_NAME@ into the final files.
README.md – This documentation.
CMakeUserPresets.json / CMakePresets.json – Optional CMake presets to simplify builds on different platforms (Debug, Release, Sanitizers, etc.).
vcpkg.json (or vcpkg.json.in) – Specifies dependencies needed by the project. vcpkg will automatically install them when the project is built.

## How It Works

The .in files in template/ contain placeholder variables like @PROJECT_NAME@ and @NAMESPACE_NAME@.
When you run the bootstrap process via CMake, these placeholders are replaced with the values you provide (e.g., MyNewApp and my_namespace).
A new directory called generated/ (inside your build folder) is created with a complete C++/CMake project. You can independently build and run it.
If you include vcpkg (via submodule or a global installation), the project will link against libraries (e.g., GTest, fmt, GSL) automatically.
Using CMakeUserPresets or CMakePresets

The file CMakeUserPresets.json (or CMakePresets.json) can store common build configurations, including paths to vcpkg via the environment key ("VCPKG_ROOT").
You can define multiple presets like debug, release, release-sanitized, etc.
Run cmake --list-presets in the generated project directory to see all available presets.

## Contributing

Contributions are welcome! Feel free to create pull requests or open issues for improvements and suggestions.
