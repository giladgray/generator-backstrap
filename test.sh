echo "recreating temp folder..."
rm -rf temp
mkdir temp
cd temp
echo "running backstrap..."
yo backstrap
echo "launching server..."
grunt
