// SPDX-License-Identifier: MIT
// contracts/SevenChain

pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// @author singgih brilian tara
contract SevenChain is ERC20, Ownable, ERC20Burnable {
    using SafeMath for uint256;
    using Address for address;

    event TokenBurned(address indexed burner, uint256 amount);
    event TokenMinted(address indexed minter, uint256 amount);

    constructor() ERC20("Seven Chain", "Sc") {
        _mint(msg.sender, 400000000 * 10 ** uint256(decimals()));
    }

    function mint(address to, uint256 amount) public {
        require(
            totalSupply() + amount <= 400000000 * 10 ** uint256(decimals())
        );
        _mint(to, amount);
        emit TokenMinted(to, amount);
    }

    function burnTokens(uint256 amount) public onlyOwner {
        require(
            balanceOf(msg.sender) >= amount,
            "Insufficient balances to burn"
        );
        _burn(msg.sender, amount);
        emit TokenBurned(msg.sender, amount);
    }

    function withdraw(uint256 amount) public {
        require(
            address(this).balance >= amount,
            "Insufficient balance in the contract"
        );
        payable(owner()).transfer(amount);
    }
}
