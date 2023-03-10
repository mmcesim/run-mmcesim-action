#!/bin/sh -l

# check options
if [ "$2" = "exp" ] || [ "$2" = "export" ]; then
    echo "Set mmCEsim Command as: $2."
else
    echo "Only 'exp' is supported in the current version!"
    exit 1 # raise an error
fi

# clone mmCEsim source with dependency (submodules)
git clone https://github.com/mmcesim/mmcesim.git --recurse-submodules

# checkout to a specific version
cd mmcesim
git checkout $1
git submodule update --init
git submodule update --recursive --remote

# build mmCEsim
cmake .
make
cd ..

# Run mmCEsim
./mmcesim/bin/mmcesim exp "$3" -o"$4" $5 || exit 1

generated_src=$4
echo "Generated source file: $generated_src"
echo "src=$generated_src" >> $GITHUB_OUTPUT
