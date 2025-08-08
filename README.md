# 🏆 Sports Team Fan Token (Aptos Move)

## 📌 Overview
This Move smart contract enables sports teams to:
1. **Create a fan token** with unique perks (e.g., VIP match access).
2. **Distribute fan tokens** to supporters as rewards.

---

## 📂 Features
- **Fan Token Creation** – Create a token with a description of the perk.
- **Token Distribution** – Transfer tokens to fans/supporters.
- **Issued Token Tracking** – Keep a record of how many tokens have been issued.

---

## 🛠 Requirements
- **Aptos CLI** installed  
- **Move language** toolchain set up  
- Aptos account & testnet/devnet access

---

## 📂 Installation & Deployment

1️⃣ **Clone the repository**
```bash
git clone https://github.com/yourusername/sports-team-fan-token.git
cd sports-team-fan-token
```

2️⃣ **Create `sources/SportsTeamFanToken.move`** and paste the following code:
```move
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
```

3️⃣ **Compile the module**
```bash
aptos move compile --package-dir .
```

4️⃣ **Publish the module**
```bash
aptos move publish --package-dir .
```

---

## 🚀 Usage

### Create Fan Token
```bash
aptos move run --function-id 'account_address::SportsTeamFanToken::create_fan_token' \
--args 'string:VIP Match Access'
```

### Issue Fan Tokens
```bash
aptos move run --function-id 'account_address::SportsTeamFanToken::issue_fan_tokens' \
--args 'address:supporter_address' 'u64:50'
```

---
<img width="1919" height="924" alt="image" src="https://github.com/user-attachments/assets/0ce93036-8f3b-4813-8507-e8ed7e600a89" />

## 📜 License
This project is licensed under the **MIT License** – feel free to use, modify, and share.
