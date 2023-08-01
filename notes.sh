python3 -m pip install --upgrade pip
python3 -m pip install --user --upgrade virtualenv

python3 -m virtualenv /Users/dubaria/Desktop/Exercises/ParallelCluster/apc-ve

source /Users/dubaria/Desktop/Exercises/ParallelCluster/apc-ve/bin/activate



# Inside Virtual Env
python3 -m pip install --upgrade "aws-parallelcluster"


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
chmod ug+x ~/.nvm/nvm.sh
source ~/.nvm/nvm.sh
nvm install --lts
node --version

nvm install --lts=Gallium

pcluster version

python3 -m pip install --upgrade "aws-parallelcluster"


