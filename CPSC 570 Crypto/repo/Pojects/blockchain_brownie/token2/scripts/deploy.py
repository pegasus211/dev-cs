from brownie import EtherWallet, accounts , config , network

def deploy_wallet():
    account = accounts.add(config["wallets"]["from_key"])
    wallet = EtherWallet.deploy({"from":account}, publish_source=True)
    print(f"Contract deployed to {wallet.address}")
def main():
    deploy_wallet()
