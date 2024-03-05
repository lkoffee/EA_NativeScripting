#EADR1 UTXO:
utxoin=56c35504f77d77e6f092d2bb303503db84c8211bfa4f04986f04b08f28420b9c#1
policyid=$(cat mymonetary2.pid)
address=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
output=20000000
tokenname=$(echo -n "Diego Coffee Coin" | xxd -ps | tr -d '\n')
#Suply
tokenammount=1000000
#
mintammount=1000000000
#EADR2 UTXO addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0:
collateral=3196a2de0a4420004aa88fbb9788d41ecec12f0a3b68372023a21de056055f44#1
# Hash of EADR1 vkey:
signerPKH1=8db8c4244accf4e5233a3d98c0a35b6b5c38590666d69398a6651781
#          8db8c4244accf4e5233a3d98c0a35b6b5c38590666d69398a6651781 (Payment Credential)
# Hash of EADR2 vkey:
signerPKH2=c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5
#          c75484a0ab2d4da6114a8ca42500ca7d1000e06b027665fc70de82d5 (Payment Credential)

# nami=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt
# cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

cardano-cli transaction build \
  --babbage-era \
  --testnet-magic 2 \
  --tx-in $utxoin \
  --required-signer-hash $signerPKH1 \
  --required-signer-hash $signerPKH2 \
  --tx-in-collateral $collateral \
  --tx-out $address+$output+"$tokenammount $policyid.$tokenname" \
  --change-address $address \
  --mint "$mintammount $policyid.$tokenname" \
  --mint-script-file mypolicy.script \
  --invalid-hereafter 42956000 \
  --out-file sminting.unsigned

# "slot": 42948317,
# Estimated transaction fee: Lovelace 191681
# Transaction successfully submitted.

# --tx-out "$address $output + $tokenammount $policyid.$tokenname" \
# --tx-out "$address + $output + $tokenammount $policyid.$tokenname" \

cardano-cli transaction sign \
  --tx-body-file sminting.unsigned \
  --signing-key-file ../wallets/enterprise1.skey \
  --signing-key-file ../wallets/enterprise2.skey \
  --testnet-magic 2 \
  --out-file sminting.signed

 cardano-cli transaction submit \
  --testnet-magic 2 \
  --tx-file sminting.signed