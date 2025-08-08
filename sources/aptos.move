module MyModule::SportsTeamFanToken {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct to represent fan token details
    struct FanToken has store, key {
        total_issued: u64,   // Total tokens issued
        perk: vector<u8>,    // Perk description (as bytes)
    }

    /// Create a new fan token with perk description
    public fun create_fan_token(owner: &signer, perk_desc: vector<u8>) {
        let token = FanToken {
            total_issued: 0,
            perk: perk_desc,
        };
        move_to(owner, token);
    }

    /// Issue fan tokens to a supporter
    public fun issue_fan_tokens(owner: &signer, supporter: address, amount: u64) acquires FanToken {
        let token = borrow_global_mut<FanToken>(signer::address_of(owner));

        // Transfer AptosCoins from owner to supporter as fan tokens
        let transfer_amount = coin::withdraw<AptosCoin>(owner, amount);
        coin::deposit<AptosCoin>(supporter, transfer_amount);

        // Update issued token count
        token.total_issued = token.total_issued + amount;
    }
}
