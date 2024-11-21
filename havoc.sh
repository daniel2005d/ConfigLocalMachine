echo "Cloning Havoc C2"
cd /opt
git clone https://github.com/HavocFramework/Havoc.git
echo "Compiling Havoc C2 Server"
cd Havoc/TeamServer
go mod download golang.org/x/sys
go mod download github.com/ugorji/go
cd ..
make ts-build
echo "Compiling Havoc C2 Client"
make client-build
echo "Done"
