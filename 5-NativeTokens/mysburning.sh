#addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
utxoin="c37c541628cb0f9d6be3223bcaad61f430e4634ea681ba885f89febfcc85c1f2#0"
policyid=$(cat monetary.pid)
address=$nami
output="1000000000"
tokenname=$(echo -n "GojiraCoin" | xxd -ps | tr -d '\n')
tokenammount="1000000"
collateral="3196a2de0a4420004aa88fbb9788d41ecec12f0a3b68372023a21de056055f44#1"
signerPKH="697a501b7d05766b3d08e39dab43e0f170973d3398b28745b3b8ce55"


cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

cardano-cli transaction build \
  --babbage-era \
  --testnet-magic 2 \
  --tx-in $utxoin \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $Adr01+$output \
  --change-address $nami \
  --mint "$tokenammount $policyid.$tokenname" \
  --mint-script-file policy.script \
  --invalid-before 26057313 \
  --protocol-params-file protocol.params \
  --out-file sburning.unsigned

cardano-cli transaction sign \
  --tx-body-file sburning.unsigned \
  --signing-key-file ../../Wallets/Adr01.skey \
  --signing-key-file ../../Wallets/Adr07.skey \
  --testnet-magic 2 \
  --out-file sburning.signed

 cardano-cli transaction submit \
  --testnet-magic 2 \
  --tx-file sburning.signed