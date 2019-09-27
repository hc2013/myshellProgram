#!/bin/bash
username='root'
password='13579Tp,'
nodes=(
"172.16.3.121"
"172.16.3.122"
"172.16.3.124"
)


function executeScpCmd() {
  echo "command is "sshpass -p ${password} scp -r $1 ${username}@$2:$3
  sshpass -p ${password} scp -r $1 ${username}@$2:$3
}


shiva_dir=$1
shiva_build_dir=${shiva_dir}/build
shiva_build_bin_dir=${shiva_build_dir}/bin
tabletserver_main_path=${shiva_build_bin_dir}/tabletserver_main
master_main_path=${shiva_build_bin_dir}/master_main
shiva_tool_path=${shiva_build_bin_dir}/shiva_tool
shiva_java_dir=${shiva_dir}/java
shiva_restful_jar_path=${shiva_java_dir}/shiva-restful/target/shiva-restful-SHIVA-UNDEFINED-VERSOIN.jar
shiva_search_jar_path=${shiva_java_dir}/shiva-search/server-shade/target/shiva-search-server-shade-SHIVA-UNDEFINED-VERSOIN.jar

root_dir=$2
target_tabletserver_main_path=$2/tabletserver/bin
target_master_main_path=$2/master/bin
target_shiva_tool_path=$2/bin
target_restful_jar_path=$2/restful/lib/
target_search_jar_path=$2/tabletserver/lib/

for node in ${nodes[@]}
do
  executeScpCmd $tabletserver_main_path $node $target_tabletserver_main_path
  executeScpCmd $master_main_path $node $target_master_main_path
  executeScpCmd $shiva_tool_path $node $target_shiva_tool_path 
  executeScpCmd $shiva_search_jar_path $node  $target_search_jar_path
  executeScpCmd $shiva_restful_jar_path $node $target_restful_jar_path
done

