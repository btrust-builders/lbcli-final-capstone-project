## USE SIGNET NETWORK FOR THIS FINAL TASK 
See `README.md` file on how to send bitcoin cli commands to the Signet network

For the final task you will first create a bitcoin wallet using your github username as wallet name
After successful creation, add your wallet name to the `wallet.txt` file

Hence, you should add your wallet name to subsequent commands, for example 
`bitcoin-cli -signet -rpcwallet=github-username getblockcount`

You dont need to add any bitcoin-cli commands in this exercise.
The goal is to update the `xxx.txt` files with the address, transaction and block hashes. e.t.c..

### Complete the tasks below

1. Create a descriptor-based bitcoin wallet using your github username as wallet name
    - Add your wallet name to the `wallet.txt` file
    - Export the receiving descriptor (external chain, index 0) with checksum
    - Save the receiving descriptor to `descriptor.txt`

**PS: Add `-rpcwallet=github-username` flag for subsequent commands below**

2. Create a native SegWit address
    - Add your address to the `address.txt` file

3. Fund the address using this faucet (`alt.signetfaucet.com`) and save to files:
   - `transaction-1.txt` (txid)
   - `block-1.txt` (blockhash where the transaction was mined)
   - `coinbase-1.txt` (coinbase transaction in the block)

4. Spend from funded address by creating a transaction with details below:
   - Send exactly 10,000 sats to `tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7`
   - Use transaction Fee: 700 sats
   - Make sure transaction fee can be later updated to a higher fee
   - Sign and broadcast the transaction
   - Save txid to `transaction-2.txt`
   - Save transaction block hash to `block-2.txt` and coinbase transaction to `coinbase-2.txt`

5. Create 2-of-3 multisig address:
   - Save to `multisig-address.txt`
   - Save redeemScript to `multisig-redeem.txt`
   - Fund using this faucet(`alt.signetfaucet.com`), and save txid to `multisig-transaction.txt`
   - Save transaction block hash to `multisig-block.txt` and coinbase transaction to `multisig-coinbase.txt`

6. Create and finalize a PSBT (Partially Signed Bitcoin Transaction):
   - Using your wallet, create a PSBT that sends exactly 5,000 sats to `tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7`
   - Sign and finalize the PSBT
   - Save the finalized PSBT (base64) to `psbt.txt`
   - Broadcast the transaction and save the txid to `psbt-tx.txt`

7. Create a native SegWit (P2WSH) 2-of-3 multisig address:
   - Save the address to `p2wsh-address.txt`
   - Save the witnessScript to `p2wsh-witness-script.txt`
   - Fund using the faucet (`alt.signetfaucet.com`), and save txid to `p2wsh-funding-tx.txt`

8. Embed your GitHub username in an OP_RETURN transaction output:
   - Create a raw transaction with an OP_RETURN output containing your GitHub username
   - Fund, sign, and broadcast the transaction
   - Save the txid to `opreturn-tx.txt`
