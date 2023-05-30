#Container will copy:
#   override: files of packages to remove
#   install:  files of packages to install
#   repo:     scripts to add repo's and install related packages
#   build.sh: this file


# taking in a list of various overides, checking to see if they are installed
# if they are not ignore them
# echo out the list of items to remove
# remove them
# OVERIDE_CANIODATES=($(cat /tmp/override/**))
# OVERRIDE=($(rpm -qa --queryformat='%{NAME} ' ${OVERIDE_CANIODATES[@]}))

OVERRIDE=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))

echo ${OVERRIDE[@]}

rpm-ostree override remove ${OVERRIDE[@]}
rm -r /tmp/override/


cat /tmp/install/** | xargs rpm-ostree install
rm -r /tmp/install

REPOS=($(ls /tmp/repos/))
echo ${REPOS[@]}

for s in "${REPOS[@]}" ; do
  /tmp/repos/$s
done 

