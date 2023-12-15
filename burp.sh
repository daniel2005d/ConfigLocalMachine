#!/bin/bash

source utils.sh

if [ -f /usr/local/bin/BurpSuitePro ];
then
    /bin/bash -c "/usr/local/bin/BurpSuitePro"
    sleep 10
    curl http://localhost:8080/cert -o /tmp/cacert.der

    if [[ ! -f /usr/local/share/ca-certificates/BurpSuiteCA.der ]];then
        sudo cp /tmp/cacert.der /usr/local/share/ca-certificates/BurpSuiteCA.der
        sudo chmod 0644 /usr/local/share/ca-certificates/BurpSuiteCA.der
    fi
fi