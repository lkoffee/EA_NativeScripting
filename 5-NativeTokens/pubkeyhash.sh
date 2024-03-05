echo "Generating Public Hashes from addresses:"
cardano-cli address key-hash \
    --payment-verification-key-file ../wallets/enterprise1.vkey \
    --out-file eadr1.pkh

cardano-cli address key-hash \
    --payment-verification-key-file ../wallets/enterprise2.vkey \
    --out-file eadr2.pkh


