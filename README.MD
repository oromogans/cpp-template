
# C++/CMake/VCPKG Template

This repository provides a ready-to-use template for C++ projects based on CMake and VCPKG, with a **bootstrap script** to generate a fresh project quickly. It includes:

- A sample setup for **GoogleTest**, **fmt**, and **Microsoft.GSL**.
- Configuration files for `clang-format` and `clang-tidy`.
- A collection of `.in` files that allow you to automatically substitute the project name and namespace.
- Optional usage of **vcpkg** (either as a submodule or a globally installed instance).
- CMake Presets for easy builds (e.g., `debug`, `release`, `release-sanitized`, etc.).

> **Note**: This template has been primarily tested on **macOS**. If you encounter issues on other platforms or have improvements, feel free to open a pull request!

---

## Quick Start (Using the Bootstrap Script)

1. **Clone this repository** (optionally with submodules if you want a local `vcpkg` directory):
   ```bash
   git clone --recurse-submodules https://github.com/<username>/<repo-name>.git
   ```
    If you forgot --recurse-submodules, you can do:
   ```
   git submodule update --init --recursive
   ```

2. **Run the bootstrap script** to generate a new project with your custom name and namespace:
    ```bash
    # On macOS/Linux:
    ./bootstrap.sh <ProjectName> <NamespaceName>
    # On Windows (Command Prompt or PowerShell):
    bootstrap.bat <ProjectName> <NamespaceName>
    ```

    For example:
    ```bash
    ./bootstrap.sh MyNewApp my_namespace
    ```
    
This will create a standalone folder called MyNewApp, initialize a Git repository there, optionally copy vcpkg, and remove the original template files.

3. **Go into your newly created project** (e.g., MyNewApp/) and review the structure:
* CMakeLists.txt
* include/, src/, tests/
* CMakePresets.json, CMakeUserPresets.json (contains ready-to-use build configurations)
* (Optional) vcpkg/ if submodules or local copy was included

## Building the Generated Project (Using CMake Presets)
Inside your newly created project folder (e.g. MyNewApp), you can use the existing CMake Presets instead of manually typing out all CMake options. Some examples:

1. Configure with the debug preset:
   ```bash
    cmake --preset=debug
    ```

2. Build using the same preset
    ```bash
    cmake --build --preset=debug
    ```

3. You can inspect available presets by running:
    ```bash
    cmake --list-presets
    ```

## Repository Structure (Template)

Before running the bootstrap script, you might see:
```
.
├─ vcpkg/                        # (Optional) vcpkg submodule
├─ template/                     # .in files: CMakeLists.txt.in, main.cpp.in, etc.
├─ bootstrap.sh                  # Script for generating a new project (macOS/Linux)
├─ bootstrap.bat                 # Script for generating a new project (Windows)
├─ bootstrap.CMakeLists.txt      # CMake logic to transform .in files into actual project files
├─ README.md                     # This documentation
└─ ... (other configs like .clang-format.in, .clang-tidy.in)

```
After the script finishes, you’ll have:
```
MyNewApp/
├─ include/
│  └─ MyNewApp.hpp              # Example generated header
├─ src/
│  └─ main.cpp                  # Example generated main
├─ tests/
│  ├─ CMakeLists.txt
│  └─ test_sample.cpp
├─ vcpkg/                        # Copied submodule (if present)
├─ CMakeLists.txt
├─ CMakePresets.json
├─ CMakeUserPresets.json
├─ vcpkg.json
├─ .clang-format
├─ .clang-tidy
└─ (other generated/adjusted files)

```

## How It Works

1. We keep .in files in the template/ folder, each containing placeholders like @APP_NAME@ or @APP_NAMESPACE@.
2. bootstrap.CMakeLists.txt (invoked by bootstrap.sh or bootstrap.bat) uses configure_file() to replace these placeholders with real values.
3. A final project is output to build_bootstrap/generated, then moved to a folder named after your new project.
4. Git is initialized in that new folder, and the original template files are removed.

## Contributing

If you want to add new features, fix issues, or test on other platforms (Windows, Linux, etc.), we welcome pull requests and any feedback.
Feel free to open issues for discussion about best practices or new ideas.

## Disclaimer
This template has been primarily tested on macOS.
Windows and Linux users are encouraged to try it out, adapt it, and submit changes if needed.
We make no guarantee it works out of the box for all environments but will happily accept patches to improve cross-platform support!

