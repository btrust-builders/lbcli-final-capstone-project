wget https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-x86_64-linux-gnu.tar.gz
tar -xzvf bitcoin-28.0-x86_64-linux-gnu.tar.gz
ln -s $PWD/bitcoin-28.0/bin/* /usr/local/bin/
mkdir -p ~/.bitcoin
echo "rpcconnect=167.172.185.136" >> ~/.bitcoin/bitcoin.conf
echo "rpcuser=btrustbuildersrpc" >> ~/.bitcoin/bitcoin.conf
echo "rpcpassword=btrustbuilderspass" >> ~/.bitcoin/bitcoin.conf
