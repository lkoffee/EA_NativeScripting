
#422118454b98e0f04fec34302f441d55eedfc64f155897dfec89e0d1fed57ea6

export TXHASH=8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0

cardano-cli query tx-mempool \
    --testnet-magic 2   \
      tx-exists $TXHASH \
    --out-file poolTX.exists

cardano-cli query tx-mempool \
    --testnet-magic 2   \
      info              \
    --out-file poolInfo.info

cardano-cli query tx-mempool \
    --testnet-magic 2   \
      next-tx           \
    --out-file poolNextTX.info

cat poolInfo.info
cat poolNextTX.info
cat poolTX.exists

# info                     Ask the node about the current mempool's capacity and
#                         sizes
# next-tx                  Requests the next transaction from the mempool's
#                         current list
# tx-exists                Query if a particular transaction exists in the
#                         mempool