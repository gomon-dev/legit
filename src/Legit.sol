// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC721} from "solady/tokens/ERC721.sol";
import {Ownable} from "solady/auth/Ownable.sol";

contract Legit is ERC721, Ownable {
    mapping(bytes => uint32) private _assetsTotalSupply;
    mapping(bytes32 => bool) private _assetsMinted;

    constructor() {
        _initializeOwner(msg.sender);
    }

    function registerAsset(bytes memory assetKey, uint32 totalSupply) public {
        require(totalSupply > 0, "Total supply must be greater than zero");
        _assetsTotalSupply[assetKey] = totalSupply;
    }

    function mint(bytes memory assetKey, uint32 tokenId) public {
        require(_assetsTotalSupply[assetKey] > 0, "Asset not registered");
        require(_assetsTotalSupply[assetKey] >= tokenId, "Asset do not exist");

        bytes32 assetHash = keccak256(abi.encodePacked(assetKey, tokenId));        
        require(!_assetsMinted[assetHash], "Asset already minted");
        
        _mint(msg.sender, uint256(assetHash));
        _assetsMinted[assetHash] = true;
    }

    function getOwnerOf(bytes memory assetKey, uint32 tokenId) public view returns (address) {
        return _ownerOf(uint256(keccak256(abi.encodePacked(assetKey, tokenId))));
    }

    function getAssetTotalSupply(bytes memory assetKey) public view returns (uint32) {
        return _assetsTotalSupply[assetKey];
    }

    function name() public pure override returns (string memory) {
        return "Legit";
    }

    function symbol() public pure override returns (string memory) {
        return "LGT";
    }

    function tokenURI(uint256 id) public pure override returns (string memory) {
        return string(abi.encodePacked("https://api.example.com/metadata/", id));
    }
}
