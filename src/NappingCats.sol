// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NappingCats is ERC721, Ownable {
    uint256 public tokenPrice = 10 wei;  // Token fiyatı
    mapping(uint256 => string) public tokenURIs;
    mapping(uint256 => string) public names;

    constructor() ERC721("Napping Cats", "NAPCAT") Ownable(msg.sender) {
        // Token başlangıç verileri
        _mint(msg.sender, 0); // İlk token'ı oluştur
        tokenURIs[0] = "0.json";
        names[0] = "Fluffy";

        _mint(msg.sender, 1); // Diğer token'lar
        tokenURIs[1] = "1.json";
        names[1] = "Whiskers";

        _mint(msg.sender, 2);
        tokenURIs[2] = "2.json";
        names[2] = "Mittens";
    }

    // Token satın alma fonksiyonu
    function buyToken(uint256 tokenId) external payable {
        require(msg.value >= tokenPrice, "Not enough ether to buy the token");
        address owner = ownerOf(tokenId);
        require(owner != msg.sender, "You already own this token"); // Zaten sahip olunamaz
        _safeTransfer(owner, msg.sender, tokenId, "");
    }

    // Token listeleme fonksiyonu
    function listToken(uint256 tokenId, uint256 price) external onlyOwner {
        require(ownerOf(tokenId) == msg.sender, "Not the owner");
        tokenPrice = price;  // Listeleme fiyatı belirle
    }

    // Token transfer fonksiyonu
    function transfer(uint256 tokenId, address to) external onlyOwner {
        require(ownerOf(tokenId) == msg.sender, "Not the owner");
        _transfer(msg.sender, to, tokenId);
    }

    // Token ismi alma fonksiyonu
    function getName(uint256 tokenId) public view returns (string memory) {
        return names[tokenId];
    }

    // Token URI alma fonksiyonu
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return tokenURIs[tokenId];
    }

    // Token resim URL'si
    function getImage(uint256 tokenId) public pure returns (string memory) {
        if (tokenId == 0) {
            return "https://example.com/fluffy.jpg";
        } else if (tokenId == 1) {
            return "https://example.com/whiskers.jpg";
        } else {
            return "https://example.com/mittens.jpg";
        }
    }
}