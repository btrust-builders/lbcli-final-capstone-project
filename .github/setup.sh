ln -s $PWD/bitcoin-28.0/bin/* /usr/local/bin/
mkdir -p ~/.bitcoin

cat <<EOF > ~/.bitcoin/bitcoin.conf
signet=1
[signet]
rpcuser=btrustbuildersrpc
rpcpassword=btrustbuilderspass
rpcconnect=165.22.121.70
EOF

echo $(bitcoin-cli --version)
echo $(bitcoin-cli getblockchaininfo)
