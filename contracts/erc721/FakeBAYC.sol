// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract FakeBAYC is ERC721, Pausable, Ownable, ERC721Burnable {
    using Strings for uint256;

    uint256 private _totalSupply;
    uint256 private _maxData;

    constructor() ERC721("FakeBAYC", "FAKEBAYC") {
        _totalSupply = 0;
        _maxData = 10000;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public {
        uint256 tokenId = _totalSupply;
        _totalSupply++;
        _safeMint(to, tokenId);
    }

    function safeBatchMint(address _to, uint256 _amount) public {
        require(_amount <= 1000, "Max mint: 1000!");
        for (uint256 i = 0; i < _amount; i++) {
            uint256 tokenId = _totalSupply;
            _totalSupply++;
            _safeMint(_to, tokenId);
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(
                    abi.encodePacked(
                        baseURI,
                        "/",
                        (tokenId % _maxData).toString()
                    )
                )
                : "";
    }
}
