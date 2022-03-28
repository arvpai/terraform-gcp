#!/bin/bash -e
# Usage: tf.sh [workspace] [init | plan | apply | destroy] [(layer depth)] [optional terraform arguments]
# Set depth to -1 to perform action against all directories.

if [ "$#" -lt 3 ]; then
  printf "\nAutomatically performs Terraform init, plan, apply or destroy on all directories under ./layers.\n"
  printf "\n\tUsage: ./tf.sh [workspace] [init | plan | apply | destroy] [depth(integer)]\n"
  printf "\n\t* Note: workspace argument must be specified, default is \"default\"."
  printf "\n\t* Note: set depth to -1 to perform action against all directories."
  printf "\n\t* Note: destory action will terminate all resources, use with great caution!\n\n"
  exit -1
else
  # Setting variables using arguments passed from command line.
  workspace=$1
  action=$2
  depth=$3
  args="${@:4}"
fi

if ! [ -d $(pwd)/layers/ ] ; then
  # if ./layers do not exist then stop
  echo "$(pwd)/layers/ directory does not exist. Exiting."
else
  # only do things if ./layers exist
  printf "\n<= ./layers/* found, executing terraform actions...\n\n"

  case $action in
    init)
      # looping through directories within ./layers
      for d in $(pwd)/layers/*/ ; do

        # checking depth isn't 0
        if [ $depth -ne 0 ] ; then
          printf "=> Performing terraform $action against layer $d...\n"

          # take the terraform action against the current directory
          terraform -chdir=$d $action $args
          printf "\n\n"

          # decrement depth counter by 1
          depth=$((depth-1))
        else
          # if depth reaches 0, don't take any more terraform actions
          printf "=> Depth($depth) reached 0, not performing terraform actions for $d\n\n"
        fi
      done
      ;;


    plan | apply)
      # looping through directories within ./layers
      for d in $(pwd)/layers/*/ ; do

        # checking depth isn't 0
        if [ $depth -ne 0 ] ; then
          printf "=> Performing terraform $action against layer $d...\n"
          printf "=> Using workspace $workspace...\n\n"

          # take the terraform action against the current directory
          terraform -chdir=$d workspace select $workspace || terraform -chdir=$d workspace new $workspace 2>/dev/null
          terraform -chdir=$d $action $args
          printf "\n\n"

          # decrement depth counter by 1
          depth=$((depth-1))
        else
          # if depth reaches 0, don't take any more terraform actions
          printf "=> Depth($depth) reached 0, not performing terraform actions for $d\n\n"
        fi
      done
      ;;

    destroy)
      # Printing big red text for destroy action
      printf '\e[1;31m%-6s\e[m\n' "Destroy action selected. This will destroy all existing resources."
      sleep 2s
      read -n 1 -s -r -p "Press any key to destroy all resources..."
      printf "\n\n"

      # creating an array of directories under ./layers
      dirs=($(ls -d $(pwd)/layers/*/))

      # performing terraform action in reverse order for destroy action
      for ((i=${#dirs[@]}-1; i>=0; i--)); do

        # checking depth isn't 0
        d="${dirs[$i]}"
        if [ $depth -ne 0 ] ; then
          printf "=> Performing terraform $action against layer $d...\n"
          printf "=> Using workspace $workspace...\n\n"

          # take the terraform action against the current directory
          terraform -chdir=$d workspace select $workspace || terraform -chdir=$d workspace new $workspace 2>/dev/null
          terraform -chdir=$d $action -auto-approve $args
          printf "\n\n"

          # decrement depth counter by 1
          depth=$((depth-1))
        else
          # if depth reaches 0, don't take any more terraform actions
          printf "=> Depth($depth) reached 0, not performing terraform actions for $d\n\n"
        fi
      done
      ;;
  esac
fi
