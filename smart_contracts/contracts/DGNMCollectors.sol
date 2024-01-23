// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DGNMCollectors is ERC721URIStorage, Ownable {
    //--------------------------------------------------------------------
    // VARIABLES

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => string) private _tokenURIs;

    struct Profile {
        uint256 id;
        string uri;
    }

    //--------------------------------------------------------------------
    // EVENTS

    event DGNM__ProfileCreated(uint256 tokenId, address owner, string uri);
    event DGNM__ProfileUpdated(uint256 tokenId, string newUri);
    event DGNM__ProfileDeleted(uint256 tokenId);

    //--------------------------------------------------------------------
    // ERRORS

    error DGNM__AlreadyRegistered();
    error DGNM__OnlyEOA();
    error DGNM__OnlyTokenOwner(uint tokenId);
    error DGNM__NotTransferable();

    constructor() ERC721("DGNM Collectors Profiles", "DGCP") {}

    // ************************ //
    //      Main Functions      //
    // ************************ //

    function create(string memory uri) external returns (uint256) {
        // Each address can only have one profile nft associated with it
        if (hasProfile(msg.sender)) revert DGNM__AlreadyRegistered();

        uint256 tokenId = _tokenIds.current();
        _tokenIds.increment();

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);

        emit DGNM__ProfileCreated(tokenId, msg.sender, uri);

        return tokenId;
    }

    function update(uint256 tokenId, string memory newUri) external {
        if (msg.sender != ownerOf(tokenId))
            revert DGNM__OnlyTokenOwner(tokenId);
        _setTokenURI(tokenId, newUri);

        emit DGNM__ProfileUpdated(tokenId, newUri);
    }

    function burn(uint256 tokenId) external {
        if (msg.sender != ownerOf(tokenId))
            revert DGNM__OnlyTokenOwner(tokenId);
        _burn(tokenId);

        emit DGNM__ProfileDeleted(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
    }

    // Disable all ERC721 transfers : the collectors NFT profile are not transferable
    function _transfer(address, address, uint256) internal virtual override {
        revert DGNM__NotTransferable();
    }

    function _setTokenURI(
        uint256 tokenId,
        string memory _tokenURI
    ) internal override {
        _tokenURIs[tokenId] = _tokenURI;
    }

    // ***************** //
    //      Getters      //
    // ***************** //

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function hasProfile(address user) public view returns (bool) {
        return balanceOf(user) != 0;
    }

    function getUserProfile(
        address user
    ) external view returns (Profile memory profile) {
        if (hasProfile(user)) {
            uint256 lastestId = _tokenIds.current();
            for (uint256 i; i < lastestId; ) {
                if (ownerOf(i) == user) {
                    string memory uri = _tokenURIs[i];
                    profile = Profile(i, uri);
                    break;
                }

                unchecked {
                    ++i;
                }
            }
        }
    }

    function getAllProfiles() external view returns (Profile[] memory) {
        uint256 lastestId = _tokenIds.current();
        Profile[] memory items = new Profile[](lastestId);
        for (uint256 i; i < lastestId; ) {
            string memory uri = _tokenURIs[i];
            items[i] = Profile(i, uri);

            unchecked {
                ++i;
            }
        }
        return items;
    }
}
