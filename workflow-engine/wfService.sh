#! /usr/bin/env bash

WFP='Workflow-Engine-Provider'
WFS='Workflow-Engine-Service'

cd $WF_ENGINE_HOME

COMMAND=$1
if [ x$COMMAND = x'--run' ] || [ x$COMMAND = x'-r' ] || [ x$COMMAND = $'-run' ];then
	COMMAND=$2

	if [ x$COMMAND = x'provider' ]; then
		P=$WFP
	fi

	if [ x$COMMAND = x'service' ]; then
		P=$WFS
	fi

	if [ P = P$2 ]; then
                echo "NEED PARAM [provider | service]"
                exit
        fi
	
        rm $P'.jar' -f
        cd $P
	
        jar cvfm0 ../$P.jar META-INF/MANIFEST.MF .
        cd ..
        java -jar $P'.jar'

fi

