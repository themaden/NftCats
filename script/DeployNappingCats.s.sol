// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/NappingCats.sol";

contract DeployNappingCats is Script {
    function run() public {
        // .env dosyasındaki ortam değişkenini oku
        uint256 deployerPrivateKey = uint256(vm.envUint("0xd939F43693E002Bc293B1aB2f77A1E3665f3f5CF"));

        vm.startBroadcast(deployerPrivateKey);

        new NappingCats();

        vm.stopBroadcast();
    }
}
