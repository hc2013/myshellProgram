#!/bin/bash

username='root'
password='13579Tp,'
#password='123'
tablet_server_ps_name='tabletserver_main'
master_ps_name='master_main'
restful_ps_name='ShivaWebServer'
root_dir=/mnt/disk2/shiva-test
master_dir=${root_dir}/master
tabletserver_dir=${root_dir}/tabletserver/
shiva_tool_dir=${root_dir}/bin
restful_dir=${root_dir}/restful
shivatool_init_cmd="init_master_group"

nodes=(
"172.16.3.121"
"172.16.3.122"
"172.16.3.124"
#"172.16.206.96"
)
master_group="172.16.3.121:9630,172.16.3.122:9630,172.16.3.124:9630"

#first parameter is node ip
#second parameter is cmd to run
function executeSSHCmd() {
  echo "command is "sshpass -p ${password} ssh ${username}@$1 $2
  sshpass -p ${password} ssh ${username}@$1 $2
}


function startAll() {

  echo ${node} "is starting"
  #start all master
  for node in ${nodes[@]}
  do
    executeSSHCmd ${node} "cd ${master_dir} && bash run.sh start"
  done
  sleep 15
  echo "has started all master"
   
  #mastergroup="";
  #for node in ${nodes[@]} 
  #do 
  #  mastergroup=$mastergroup${node},
  #done
  #length=${#mastergroup}
  #mastergroup_length=`expr ${length} - 1`
  #mastergroup=$(echo $mastergroup | cut -c1-${mastergroup_length})
  #echo "mastergroup="${mastergroup} 

  executeSSHCmd ${nodes[0]} "cd ${shiva_tool_dir} && shiva_tool --master_group=${master_group} --cmd=${shivatool_init_cmd}"

  for node in ${nodes[@]}
  do
    executeSSHCmd ${node} "cd ${tabletserver_dir} && bash run.sh start"
  done  
  echo "has started all tabletserver"

  executeSSHCmd ${nodes[0]} "cd ${restful_dir} && bash bin/shiva-restful.sh"
  echo "has started restful service"
}

function stopAll() {
for node in ${nodes[@]}
do
  echo ${node} "is stoping"
  #stop tablet_server
  executeSSHCmd ${node} "ps -ef | grep "${tablet_server_ps_name}" | grep -v grep | awk '{print \$2}' | xargs kill -9"
  #stop master
  executeSSHCmd ${node} "ps -ef | grep "${master_ps_name}" | grep -v grep | awk '{print \$2}' | xargs kill -9"
  #stop restful
  executeSSHCmd ${node} "ps -ef | grep "${restful_ps_name}" | grep -v grep |awk '{print \$2}' | xargs kill -9"
done
}


if [ $1 == "start" ]
then
  startAll
elif [ $1 == "stop" ]
then
  stopAll
fi
