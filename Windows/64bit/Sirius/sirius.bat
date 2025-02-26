@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  sirius startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
@rem remove one \ from path
set APP_HOME=%DIRNAME:~0,-1%

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

set JAR_HOME=%APP_HOME%\app

@rem Add default JVM options here. You can also use JAVA_OPTS and SIRIUS_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Xms1G" "-XX:MaxRAMPercentage=85" "-XX:+UseG1GC" "-XX:+UseStringDeduplication"
set JAVA_EXE=%APP_HOME%\runtime\bin\java.exe
set MAIN_CLASS="de.unijena.bioinf.ms.frontend.SiriusCLIApplication"

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: Inlcuded java.exe could not be found. Please report this bug!

goto fail

:execute
@rem Setup the command line and add APP_HOME to user Path
set Path=%APP_HOME%;%Path%
set CLASSPATH=%JAR_HOME%\*

set GUROBI_JAR=%GUROBI_HOME%\lib\gurobi.jar
if exist "%GUROBI_JAR%" set CLASSPATH=%CLASSPATH%;%GUROBI_JAR%

set CPLEX_JAR=%CPLEX_HOME%\lib\cplex.jar
if exist "%CPLEX_JAR%" set CLASSPATH=%CLASSPATH%;%CPLEX_JAR%


@rem Execute sirius
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %SIRIUS_OPTS%  -classpath "%CLASSPATH%" "%MAIN_CLASS%" %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable SIRIUS_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%SIRIUS_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
