// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract FakeBruceTheGoose is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
    string[] private _tokenURIs;

    string public symbol;

    constructor() ERC1155("") {
        symbol = "FBTG";

        _tokenURIs[
            1
        ] = "ipfs://ipfs/QmV7gdtEvxmB7FaBmy855B1JjcD72nqABw5ZFXtZ1hFzTu";
        _tokenURIs[
            2
        ] = "ipfs://ipfs/QmX4Gh38jbuHgh7GaeANvgGsWKqBX8ymaMsxErEnE7yRSv";
        _tokenURIs[
            3
        ] = "ipfs://ipfs/QmaLaWKDZMVN6mioR9bZDYtLeiAhivVuER9paMUX3tgN9w";
        _tokenURIs[
            4
        ] = "ipfs://ipfs/QmaoE1cYinkk5N47LeTZpmnWYVnjA7jQ8BafdRFqbVsKPw";
    }

    function setURI(uint256 tokenId, string memory newuri) public onlyOwner {
        _tokenURIs[tokenId] = newuri;
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        returns (string memory)
    {
        return _tokenURIs[tokenId];
    }
}
