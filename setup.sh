#!/bin/bash
THIS_DIR=$(dirname `which $0`)
PROJECT_DIR=$(pwd)
CMAKE="$PROJECT_DIR/ThirdParty/CMake/bin/cmake"

C_COMPILER=`which clang-10`
CXX_COMPILER=`which clang++-10`
THREADS=8
DO_NOT_CMAKE=false

function isValidExit()
{
	retVal=$?
	if [ $retVal -ne 0 ]; then
		echo "Failed 'isValidExit()' Check."
		exit $retVal
	fi
}

# ####################################################################################################

# Grab Arguments.
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --no-cmake)
    DO_NOT_CMAKE="true"
    shift # past argument
    shift # past argument
    ;;

    -j|-t|--threads)
    THREADS="$2"
    shift # past argument
    shift # past argument
    ;;

    -h|--help)
    echo -e "Build Help:"
    echo -e "======================"
    echo -e "-j [num] (Override Compiling Threads)"
    echo -e "   -t [num]"
    echo -e "   --threads [num] - Default is ${THREADS}"
    echo -e "--no-cmake - Default is ${DO_NOT_BUILD} (This will prevent a build after CMake Configuration)"
    echo -e "-h (Help Information & Arguments.)"
    echo -e "   --help"
    exit 0
    ;;

    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ ! -d ".Intermediate" ]; then
    mkdir ".Intermediate"
fi
if [ ! -d ".Intermediate/Linux" ]; then
    mkdir ".Intermediate/Linux"
fi

pushd ".Intermediate/Linux"
if [ $DO_NOT_CMAKE != "true" ]; then
echo "Generating..."
$CMAKE -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="$THIS_DIR/out/install" -DCMAKE_C_COMPILER=${C_COMPILER} -DCMAKE_CXX_COMPILER=${CXX_COMPILER} -DCMAKE_BUILD_TYPE="Release" "$PROJECT_DIR"
isValidExit
fi
echo "Compiling..."
make -j8
isValidExit
popd