// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Legit} from "../src/Legit.sol";

contract LegitTest is Test {
    Legit public legit;
    string assetKey = "10f26e28-bfd7-4928-af1e-8948e0b6a51d";
    uint32 totalSupply = 100;
    address fakeSender = address(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);

    function setUp() public {
        legit = new Legit();
    }

    function test_RegisterAsset() public {
        legit.registerAsset(bytes(assetKey), totalSupply);

        assertEq(legit.getAssetTotalSupply(bytes(assetKey)), totalSupply);
    }
    
    function test_RegisterAssetWithZeroSupply() public {
        vm.expectRevert("Total supply must be greater than zero");
        legit.registerAsset(bytes(assetKey), 0);
    }

    function test_MintAsset() public {
        legit.registerAsset(bytes(assetKey), totalSupply);

        for (uint32 i = 1; i <= totalSupply; i++) {
            bytes memory assetKeyHash = bytes(assetKey);

            legit.mint(assetKeyHash, i);
            assertEq(legit.getOwnerOf(assetKeyHash, i), address(this));
        }
    }

    function test_MintAssetAlreadyMinted() public {
        legit.registerAsset(bytes(assetKey), totalSupply);

        bytes memory assetKeyHash = bytes(assetKey);
        legit.mint(assetKeyHash, 1);

        vm.expectRevert("Asset already minted");
        legit.mint(assetKeyHash, 1);
    }

    function test_MintAssetNotRegistered() public {
        bytes memory assetKeyHash = bytes(assetKey);

        vm.expectRevert("Asset not registered");
        legit.mint(assetKeyHash, 1);
    }

    function test_MintAssetDoesNotExist() public {
        legit.registerAsset(bytes(assetKey), totalSupply);

        bytes memory assetKeyHash = bytes(assetKey);

        vm.expectRevert("Asset do not exist");
        legit.mint(assetKeyHash, totalSupply + 1);
    }

    function test_GetTotalSupply() public {
        legit.registerAsset(bytes(assetKey), totalSupply);

        assertEq(legit.getAssetTotalSupply(bytes(assetKey)), totalSupply);
    }
}
