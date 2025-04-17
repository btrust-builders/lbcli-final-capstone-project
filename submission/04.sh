# CANT WORK 
# Only one single output remains unspent from block 123,321. What address was it sent to?

# Get the block hash
block_hash=$(bitcoin-cli getblockhash 123321)

txs_in_block=$(bitcoin-cli getblock $block_hash | jq -r '.tx[]')

# Loop through each transaction
for txid in $txs_in_block; do
    # Get the unspent transaction
    bitcoin-cli gettxout $txid 0 | jq -r '.scriptPubKey.address'
done

