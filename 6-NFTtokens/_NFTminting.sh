utxoin1="f2657b63e5790433c248649e88e2a7714c1253ae1f5a9cba1a184b0abfe9d754#1"
utxoin2="486971183d33f6aa88a0833ce41ca85a36aa82ccd2f92b56cd32e60ee6699f18#1"
utxoin3="a07f0f448d9dc2ac03d39b60271a8088d39df7a66269d1e8c5ba20366c387e68#1"
address="addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh"
output="2200000"
policyid=$(cat _NFTpolicy.pid)
tokenname=$(echo -n "JavaSillyBoy" | xxd -ps | tr -d '\n')
tokenammount="1"
collateral="3196a2de0a4420004aa88fbb9788d41ecec12f0a3b68372023a21de056055f44#1"
signerPKH="c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5"
nami="addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt"

#cardano-cli transaction policyid --script-file NFTpolicy.script > NFTpolicy.id

cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

cardano-cli transaction build \
  --babbage-era \
  --testnet-magic 2 \
  --tx-in $utxoin1 \
  --tx-in $utxoin2 \
  --tx-in $utxoin3 \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output+"$tokenammount $policyid.$tokenname" \
  --change-address $address \
  --mint "$tokenammount $policyid.$tokenname" \
  --mint-script-file _NFTpolicy.script \
  --invalid-hereafter 45000000 \
  --metadata-json-file _NFTmetadata.json \
  --protocol-params-file protocol.params \
  --out-file NFTminting.unsigned

#--invalid-before    SLOT Time that transaction is valid from  (in slots)
#--invalid-hereafter SLOT Time that transaction is valid until (in slots)

cardano-cli transaction sign \
  --tx-body-file NFTminting.unsigned \
  --signing-key-file ../wallets/enterprise1.skey \
  --signing-key-file ../wallets/enterprise2.skey \
  --testnet-magic 2 \
  --out-file NFTminting.signed

 cardano-cli transaction submit \
  --testnet-magic 2 \
  --tx-file NFTminting.signed