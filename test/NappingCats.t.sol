// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import { NappingCats } from "../src/NappingCats.sol";

contract NappingCatsTest is Test {
    NappingCats napCat;
    address owner;
    address buyer;

    function setUp() public {
        owner = address(this);
        buyer = address(0x1);

        // Yeni NappingCats sözleşmesi deploy ediliyor
        napCat = new NappingCats();
    }

    function testInitialState() public view {
        assertEq(napCat.getName(0), "Fluffy");
        assertEq(napCat.getName(1), "Whiskers");
        assertEq(napCat.getName(2), "Mittens");
        assertEq(napCat.tokenPrice(), 10 wei);
    }

    function testBuyToken() public {
        uint256 tokenId = 1;
        uint256 price = napCat.tokenPrice();

        // Buyer hesabından satın alma işlemi
        vm.deal(buyer, price);
        vm.startPrank(buyer); // Buyer olarak işlem yapacak
        napCat.buyToken{value: price}(tokenId);

        // Token'ı alıp almadığını kontrol et
        assertEq(napCat.ownerOf(tokenId), buyer);
    }

    function testGetImage() public view {
        assertEq(napCat.getImage(0), "https://example.com/fluffy.jpg");
        assertEq(napCat.getImage(1), "https://example.com/whiskers.jpg");
        assertEq(napCat.getImage(2), "https://example.com/mittens.jpg");
    }

    function testGetName() public  view {
        assertEq(napCat.getName(0), "Fluffy");
        assertEq(napCat.getName(1), "Whiskers");
        assertEq(napCat.getName(2), "Mittens");
    }

    function testListAndBuyToken() public {
        uint256 tokenId = 0;
        uint256 newPrice = 20 wei;

        // Sadece owner listeleme yapabilir
        vm.startPrank(owner); // Owner olarak işlem yapacak
        napCat.listToken(tokenId, newPrice);

        // Fiyatı kontrol et
        assertEq(napCat.tokenPrice(), newPrice);

        // Buyer token'ı alabilir
        vm.deal(buyer, newPrice);
        vm.startPrank(buyer); // Buyer olarak işlem yapacak
        napCat.buyToken{value: newPrice}(tokenId);

        // Token'ı satın aldıktan sonra sahip kontrolü
        assertEq(napCat.ownerOf(tokenId), buyer);
    }

    function testTransfer() public {
        uint256 tokenId = 0;
        address newOwner = address(0x2);

        // Transfer işlemini owner yapabilir
        vm.startPrank(owner); // Owner olarak işlem yapacak
        napCat.transfer(tokenId, newOwner);

        // Yeni sahibini kontrol et
        assertEq(napCat.ownerOf(tokenId), newOwner);
    }
}
