// SPDX-License-Identifier: MIT
// contracts/SevenChain

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SevenChain is ERC20, Ownable, ERC20Burnable, AccessControl {
    using SafeMath for uint256;
    using Address for address;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event TokenBurned(address indexed burner, uint256 amount);
    event TokenMinted(address indexed minter, uint256 amount);

    uint256 public totalBurnedTokens;
    uint256 public mintingThreshold = 1000 *10 *uint256(decimals());

    constructor() ERC20("Seven Chain", "Sc") {
        _mint(msg.sender, 4000000000 * 10 ** uint256(decimals()));
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender); 
    }

    modifier onlyMinter() {
        require(hasRole(MINTER_ROLE, msg.sender), "Must have MINTER_ROLE to mint");
        _;
    }

    /**
     * @dev Mints `amount` tokens to `to`.
     *
     * Requirements:
     *
     * - `totalSupply() + amount <= _cap`.
     */

    function mint(address to, uint256 amount) public onlyMinter{
        require(
            totalSupply() + amount <= 4000000000 * 10 ** uint256(decimals())
        );
        _mint(to, amount);
        emit TokenMinted(to, amount);
    }

    /**
     * @dev Burns `amount` tokens from `msg.sender`.
     *
     * Requirements:
     *
     * - `balanceOf(msg.sender) >= amount`.
     */

    function burnTokens(uint256 amount) public onlyOwner {
        require(
            balanceOf(msg.sender) >= amount,
            "Insufficient balances to burn"
        );
        _burn(msg.sender, amount);
        emit TokenBurned(msg.sender, amount);
    }

    /**
     * @dev Burns `burnAmount` tokens and mints `mintAmount` tokens to the sender.
     *
     * Requirements:
     *
     * - `balanceOf(msg.sender) >= burnAmount`.
     * - `burnAmount % 1000 == 0`.
     * 
     */

    function burnAndMint(uint256 burnAmount) public {
        require(balanceOf(msg.sender) >= burnAmount, "Insufficient balances to burn");

        require(burnAmount % 1000 == 0, "Burn amount must be multiple of 1000");

        _burn(msg.sender, burnAmount);

        totalBurnedTokens = totalBurnedTokens.add(burnAmount);

        if (totalBurnedTokens >= mintingThreshold) {
            uint256 mintAmount = totalBurnedTokens.div(mintingThreshold)* 100;

            _mint(msg.sender, mintAmount);

            totalBurnedTokens = totalBurnedTokens % mintingThreshold;
        }
    }
}
