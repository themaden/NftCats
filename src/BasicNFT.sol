// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BasicNFT {
    string public name;
    mapping(uint256 => address) private _owners;
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name) {
        name = _name;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return _owners[tokenId];
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function transfer(uint256 tokenId, address to) public {
        require(msg.sender == _owners[tokenId], "Not the owner");
        _owners[tokenId] = to;
    }

    function _mint(address to, uint256 tokenId, string memory _tokenURI) internal {
        require(_owners[tokenId] == address(0), "Token already minted");
        _owners[tokenId] = to;
        _tokenURIs[tokenId] = _tokenURI;
    }
}