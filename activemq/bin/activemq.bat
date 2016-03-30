@echo off
set ACTIVEMQ_HOME="/Users/dejanb/workspace/oss/mq/activemq/assembly/target/apache-activemq-5.14.0-SNAPSHOT"
set ACTIVEMQ_BASE="/Users/dejanb/workspace/oss/sslib/activemq"

set PARAM=%1
:getParam
shift
if "%1"=="" goto end
set PARAM=%PARAM% %1
goto getParam
:end

%ACTIVEMQ_HOME%/bin/activemq %PARAM%