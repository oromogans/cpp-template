@echo off
REM
REM Usage:
REM   bootstrap.bat <ProjectName> <NamespaceName>
REM
REM Example:
REM   bootstrap.bat MyNewApp my_namespace
REM

if "%~2"=="" (
    echo Usage: %~0 ^<ProjectName^> ^<NamespaceName^>
    exit /b 1
)

set APP_NAME=%~1
set APP_NAMESPACE=%~2

echo >>> Generating project "%APP_NAME%" with namespace "%APP_NAMESPACE%"...

REM 1. Удалим (если есть) и создадим папку build_bootstrap
if exist build_bootstrap rmdir /s /q build_bootstrap
mkdir build_bootstrap

REM 2. Запустим CMake для генерации
cmake -DAPP_NAME="%APP_NAME%" -DAPP_NAMESPACE="%APP_NAMESPACE%" -S . -B build_bootstrap

if not exist build_bootstrap\generated (
    echo >>> Error: not found build_bootstrap\generated
    exit /b 1
)

REM 3. Перемещаем сгенерированную структуру в папку с именем проекта
move build_bootstrap\generated %APP_NAME%

REM 4. Копируем vcpkg, если папка есть
if exist vcpkg (
    echo >>> Copying vcpkg into %APP_NAME%...
    xcopy vcpkg %APP_NAME%\vcpkg /E /I
) else (
    echo >>> vcpkg folder not found in current directory, skipping copy.
)

REM 5. Инициализируем Git в итоговом проекте
cd %APP_NAME%
git init
git add .
git commit -m "Initial commit of %APP_NAME% project"
cd ..

REM 6. Удаляем файлы шаблона, оставляя только итоговый проект
echo >>> Removing template files and build_bootstrap...
rmdir /s /q build_bootstrap
rmdir /s /q template
rmdir /s /q vcpkg
del bootstrap.CMakeLists.txt
del bootstrap.sh
del bootstrap.bat
del CMakeLists.txt
del LICENSE

echo >>> Done!
echo >>> Folder "%APP_NAME%" is now a standalone C++/CMake/vcpkg project with Git initialized.
