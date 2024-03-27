#EADR1 UTXO:
utxoin=4080ef18b7b98e651377523181c6442965a167c8c0dcbeea0f64790d68125001#1
eadr1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
policyid=$(cat mymonetary3.pid)
tokenname=$(echo -n "Diego+Coffee+Coin" | xxd -ps | tr -d '\n')
output="50000000"
#OBS: Deve ser menos que a quantidade mintada no momento da criação do Token (10000)
mintammount="-1000"

collateral=3196a2de0a4420004aa88fbb9788d41ecec12f0a3b68372023a21de056055f44#1
signerPKH=c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5

nami=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt

cardano-cli transaction build \
  --babbage-era \
  --testnet-magic 2 \
  --tx-in $utxoin \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output \
  --change-address $eadr1 \
  --mint "$mintammount $policyid.$tokenname" \
  --mint-script-file mypolicy.script \
  --invalid-before 44766692 \
  --out-file sburning.unsigned

  #--invalid-before    SLOT Time that transaction is valid from  (in slots)
  #--invalid-hereafter SLOT Time that transaction is valid until (in slots)

cardano-cli transaction sign \
  --tx-body-file sburning.unsigned \
  --signing-key-file ../wallets/enterprise1.skey \
  --signing-key-file ../wallets/enterprise2.skey \
  --testnet-magic 2 \
  --out-file sburning.signed

 cardano-cli transaction submit \
  --testnet-magic 2 \
  --tx-file sburning.signed