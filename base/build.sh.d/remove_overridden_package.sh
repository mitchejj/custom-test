check_override_dir() {
    local override_dir="$1"
    shopt -s nullglob
    if [ -d "$override_dir" ] && [ "$(ls -A "$override_dir")" ]; then
        return 0
    else
        echo "The $override_dir directory does not exist or is empty."
        return 1
    fi
    shopt -u nullglob
}

get_package_names() {
    local override_dir="$1"
    local -a package_names=()

    shopt -s nullglob
    for file in "$override_dir"/*; do
        if [ -f "$file" ]; then
          package_names+=($(rpm -qa --queryformat='%{NAME} ' $(cat "$file")))
# package_names+=("$(cat "$file")")
        fi
    done
# package_names+=($(rpm -qa --queryformat='%{NAME} ' $(cat /tmp/override/**)))
    shopt -u nullglob

    echo "${package_names[@]}"
}

remove_packages() {
    local -a packages=("$@")
    if [ "${#packages[@]}" -gt 0 ]; then
        rpm-ostree override remove "${packages[@]}"
    else
        echo "No packages to remove."
    fi
}

remove_overridden_packages() {
    local override_dir="$1"
    local -a override_packages=()

    if check_override_dir "$override_dir"; then
        override_packages=($(get_package_names "$override_dir"))
        remove_packages "${override_packages[@]}"
    fi

    unset override_packages
}
