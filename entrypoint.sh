#!/bin/sh -l

# check options
if [ "$2" = "exp" ] || [ "$2" = "export" ]; then
    echo "Set mmCEsim Command as: $2."
else
    echo "Only 'exp' is supported in the current version!"
    exit 1 # raise an error
fi

# Function to get the newest file (i.e. just generated one)
# Reference: https://stackoverflow.com/q/61027606/15080514
newest_file() {
    local file_ext="cpp" # so far only cpp is supported
    [[ -z "${file_ext}" ]] && local files=("$1"/*) || local files=("."/*.${file_ext}) # search current directory
    local newest="${files[@]:0:1}"
    for f in "${files[@]}"; do
        if [[ $f -nt $newest ]]; then
            newest="$f"
        fi
    done
    echo "$newest"
}

# clone mmCEsim source with dependency (submodules)
git clone https://github.com/mmcesim/mmcesim.git --recurse-submodules

# checkout to a specific version
cd mmcesim
git checkout $1

# build mmCEsim
cmake .
make
cd ..

# Run mmCEsim
./mmcesim/bin/mmcesim exp $3 $4

generated_src=$(newest_file)
echo "Generated source file: $generated_src"
echo "src=$generated_src" >> $GITHUB_OUTPUT
