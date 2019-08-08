@echo off
set workDir = %CD%
call mvn clean dependency:tree -Dincludes=ar.com.nec.* -DoutputType=dot -DappendOutput=true -DoutputFile=./target/dependencies.dot

:treeProcess
if exist pom.xml (
    echo Generating %CD%\target\dependencies.svg
    dot -Tsvg ./target/dependencies.dot -o ./target/dependencies.svg

    for /D %%d in (*) do (
        @echo off
        cd /D %%d
        call :treeProcess
        @echo off
        cd ..
    )

)

cd %workDir%