
# curl -H 'project_id: previewTQgzYm9vxX3Ot5sLA7m1YIpa5ckZNERq' https://cardano-preview.blockfrost.io/api/v0/addresses/addr_test1qp65draw5za4msm4sqp9wtv4yejvehecceml20cc6waewrjfqx4dgsjqxh2gql7zjr2776l3thnxgtcvjg3cm8dad3lqn484e6/utxos/asset1rp8agwcyr3mngkrk9kxnh82ekawvecvakq6nxt | jq



policyID="fb7550dff33e7130ddfdbb24748de0e776a9297fa84d9fcbc3c83f1b"
curl -H 'project_id: preview9zSocpP7zckIZeyNjvkcywvgVFUs183Y' https://cardano-preview.blockfrost.io/api/v0/assets/$policyID$assetName | jq

assetName="4a61766153696c6c79426f79"
policyID="36268c731d6d2a37d11d0d1a1de5720778a7d67c1d491eaa1cfb913d"
curl -H 'project_id: preview9zSocpP7zckIZeyNjvkcywvgVFUs183Y' https://cardano-preview.blockfrost.io/api/v0/assets/$policyID$assetName | jq

# 'fb7550dff33e7130ddfdbb24748de0e776a9297fa84d9fcbc3c83f1b4a61766153696c6c79426f79'