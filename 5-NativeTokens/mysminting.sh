#EADR1 UTXO:
utxoin=ba030dbd39cfdcfc281a1fe504d5603be35eb170b42a78ece46e90c659e55569#1
eadr1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
output=20000000
policyid=$(cat mymonetary3.pid)
tokenname=$(echo -n "Diego+Coffee+Coin" | xxd -ps | tr -d '\n')
#
tokenammount=1000
#
mintammount=10000
# For Collateral (UTXO and the EADR2 Pub-Key-Hash)
#EADR2 UTXO addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0:
collateral=3196a2de0a4420004aa88fbb9788d41ecec12f0a3b68372023a21de056055f44#1
signerPKH=c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5
#          c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5 (Payment Credential)
# Hash of EADR1 vkey:
# signerPKH1=8db8c4244accf4e5233a3d98c0a35b6b5c38590666d69398a6651781
# #          8db8c4244accf4e5233a3d98c0a35b6b5c38590666d69398a6651781 (Payment Credential)
nami=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt
# cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

cardano-cli transaction build \
  --babbage-era \
  --testnet-magic 2 \
  --tx-in $utxoin \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output+"$tokenammount $policyid.$tokenname" \
  --change-address $eadr1 \
  --mint "$mintammount $policyid.$tokenname" \
  --mint-script-file mypolicy.script \
  --invalid-hereafter 43039000 \
  --out-file sminting.unsigned

cardano-cli transaction sign \
  --tx-body-file sminting.unsigned \
  --signing-key-file ../wallets/enterprise1.skey \
  --signing-key-file ../wallets/enterprise2.skey \
  --testnet-magic 2 \
  --out-file sminting.signed

 cardano-cli transaction submit \
  --testnet-magic 2 \
  --tx-file sminting.signed