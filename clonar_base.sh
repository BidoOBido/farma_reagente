#!/bin/bash

package=br.edu.unoesc.farma_reagente
database_name=farma_reagente.db
android_db_path=./databases/$database_name
out_path=`pwd`/$database_name

adb kill-server
sudo adb exec-out run-as $package cat $android_db_path > $out_path
adb start-server
