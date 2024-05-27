#!/bin/env sh
set -ouex pipefail

export FEDORA_STABLE=40
export FEDORA_BETA=41
export RAWHIDE=41

# Containerfile will copy:
#   override: files of packages to remove
#   install:  files of packages to install
#   repo:     scripts to add repo's and install related packages
#   build.sh: this file

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo

########################################
#   Overrides 
########################################
# taking in a list of various overides, checking to see if they are installed
# if they are not ignore them
# echo out the list of items to remove
# remove them
# OVERIDE_CANIODATES=($(cat /tmp/override/**))
# OVERRIDE=($(rpm -qa --queryformat='%{NAME} ' ${OVERIDE_CANIODATES[@]}))
# echo 'Packages that where not removed'
# Should feed only what was sent thru rpm-ostree override remove to make this
# check but using the whole data set seems like a nice double check
# echo $(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**))
 # rm -r /tmp/override/
########################################
# newremove_overridden_packages() {
#     local override_dir="/tmp/override"
#     local -a override_packages=()

#     shopt -s nullglob
#     if [ -d "$override_dir" ] && [ "$(ls -A "$override_dir")" ]; then
#         override_packages+=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))
#         if [ "${#override_packages[@]}" -gt 0 ]; then
#             rpm-ostree override remove "${override_packages[@]}"
#         else
#             echo "No overridden packages found."
#         fi
#     else
#         echo "The /tmp/override directory does not exist or is empty."
#     fi
#     shopt -u nullglob

#     unset override_packages

#     unset override_packages
# }

# oldremove_overridden_packages() {
#       local override_dir="/tmp/override"
#     local -a override_packages=()
# shopt -s nullglob
#  if [ -d "$override_dir" ] && [ "$(ls -A "$override_dir")" ]; then


#       override_packages+=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))




#         if [ "${#override_packages[@]}" -gt 0 ]; then
#             rpm-ostree override remove "${override_packages[@]}"
#         else
#             echo "No overridden packages found."
#         fi
#     else
#         echo "The /tmp/override directory does not exist or is empty."
#     fi

#     unset override_packages
# }
source /tmp/build.sh.d/remove_overridden_package.sh

override_dir="/tmp/override"
remove_overridden_packages "$override_dir"

# remove_overridden_packages() {
#   local override_packages=("$(rpm -qa --queryformat='%{NAME} ' --file /tmp/override/*)")
#     # local override_packages=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))

#     echo "${override_packages[@]}"

#     rpm-ostree override remove "${override_packages[@]}"

#     unset override_packages
# }
# OVERRIDE=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))

# echo ${OVERRIDE[@]}

# rpm-ostree override remove ${OVERRIDE[@]}
# unset OVERRIDE

########################################
#   Adding repo's & install 
########################################

REPOS=($(ls /tmp/repos/))
echo ${REPOS[@]}

for s in "${REPOS[@]}" ; do
  /tmp/repos/$s
done 

unset REPOS

#########################################
##   Install 
#########################################
cat /tmp/install/** | xargs rpm-ostree install
rm -r /tmp/install

#########################################
##   Build Scrips 
#########################################

#/tmp/build.sh.d/nerd-font.sh

