// SPDX-License-Identifier: MIT

// File @openzeppelin/contracts/utils/Context.sol@v4.9.5


pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}


pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}


pragma solidity ^0.8.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}


pragma solidity ^0.8.18;

interface IDGNMCollection {
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address to, uint256 tokenId) external;

    function setApprovalForAll(address operator, bool _approved) external;

    function getApproved(
        uint256 tokenId
    ) external view returns (address operator);

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function royaltyInfo(
        uint256 _tokenId,
        uint256 _salePrice
    ) external view returns (address, uint256);

    function mintNFT(address to, string memory uri) external returns (uint256);

    function mintWithRoyalty(
        address recipient,
        string memory uri,
        address royaltyReceiver,
        uint96 feeNumerator
    ) external payable returns (uint256);

    function pause(uint256 _state) external payable;

    function setMintFee(uint256 _newFee) external payable;

    function withdraw() external payable;
}


pragma solidity ^0.8.18;

interface IDGNMMarket {
    // ********************** //
    //      Market enums      //
    // ********************** //

    enum ListingStatus {
        Active,
        Sold,
        Canceled
    }

    enum OfferStatus {
        Active,
        Ended
    }

    enum AuctionStatus {
        Open,
        Closed,
        Ended,
        DirectBuy,
        Canceled
    }

    // ********************** //
    //     Market structs     //
    // ********************** //

    struct Listing {
        uint256 tokenId;
        address seller;
        address paymentToken; // set to address(0) for DTOKEN
        uint256 buyPrice;
        ListingStatus status;
    }

    struct Offer {
        address offerer;
        uint256 price;
        address paymentToken; // set to address(0) for DTOKEN
        uint48 expireTime;
        OfferStatus status;
    }

    struct Auction {
        uint256 tokenId;
        address seller;
        address paymentToken; // set to address(0) for DTOKEN
        address highestBidder;
        uint48 startTime;
        uint48 endTime;
        uint256 highestBid;
        uint256 directBuyPrice;
        uint256 startPrice;
        AuctionStatus status;
    }

    function listItem(
        uint256 _tokenId,
        address _paymentToken,
        uint256 _buyPrice
    ) external returns (uint256 listingId);

    function buyItem(uint256 _listingId) external payable;

    function cancelListing(uint256 _listingId) external;

    function makeOffer(
        uint256 tokenId,
        address paymentToken,
        uint256 offerPrice,
        uint256 expirationTime
    ) external payable returns (uint256 offerId);

    function acceptOffer(uint256 tokenId, uint256 offerId) external;

    function cancelOffer(uint256 tokenId, uint256 offerId) external;

    function startAuction(
        uint256 _tokenId,
        address _paymentToken,
        uint256 _directBuyPrice,
        uint256 _startPrice,
        uint256 _startTime,
        uint256 _endTime
    ) external returns (uint256 auctionId);

    function bid(uint256 _auctionId, uint256 _amount) external payable;

    function directBuyAuction(uint256 _auctionId) external payable;

    function withdrawBid(uint256 _auctionId) external;

    function endAuction(uint256 _auctionId) external;

    function cancelAuction(uint256 _auctionId) external;

    function setFee(uint256 _fee) external;

    function addSupportedToken(address _token) external;
}


pragma solidity ^0.8.18;

library PaymentLib {
    function transferToken(
        address _token,
        address _from,
        address _to,
        uint256 _amount
    ) internal {
        if (_amount == 0) {
            return;
        }
        if (_token == address(0)) {
            transferNativeToken(_to, _amount);
        } else {
            transferERC20(_token, _from, _to, _amount);
        }
    }

    function transferERC20(
        address _token,
        address _from,
        address _to,
        uint256 _amount
    ) internal {
        if (_from == address(this)) {
            IERC20(_token).transfer(_to, _amount);
        } else {
            IERC20(_token).transferFrom(_from, _to, _amount);
        }
    }

    function transferNativeToken(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}("");
        require(success);
    }
}


pragma solidity ^0.8.18;

contract DGNMErrors {
    error DGNMMarket_OnlyTokenOwner(uint256 tokenId);
    error DGNMMarket_ItemNotApproved(uint256 tokenId);
    error DGNMMarket_AddressZero();
    error DGNMMarket_OnlySeller(uint256 id);
    error DGNMMarket_ListingNotActive(uint256 listingId);
    error DGNMMarket_OfferAmountNotApproved();
    error DGNMMarket_InvalidExpirationTime();
    error DGNMMarket_OfferNotActive(uint256 offerId, uint256 tokenId);
    error DGNMMarket_OnlyOfferer(uint256 offerId, uint256 tokenId);
    error DGNMMarket_InvalidAuctionPeriod(uint256 endTime, uint256 startTime);
    error DGNMMarket_InvalidStartPrice();
    error DGNMMarket_InvalidDirectBuyPrice(uint256 directBuyPrice);
    error DGNMMarket_AuctionNotOpen(uint256 auctionId);
    error DGNMMarket_AlreadyHighestBid(uint256 auctionId);
    error DGNMMarket_InsufficientBid(uint256 auctionId);
    error DGNMMarket_InsufficientAmount();
    error DGNMMarket_IsHighestBidder(uint256 auctionId);
    error DGNMMarket_HasNoBid(uint256 auctionId);
    error DGNMMarket_AuctionPeriodNotEnded(uint256 auctionId, uint256 endTime);
    error DGNMMarket_CancelImpossible(uint256 auctionId);
    error DGNMMarket_UnsupportedToken(address token);
    error DGNMMarket_AlreadySupported(address token);
    error DGNMMarket_InvalidFee(uint256 fee);
    error DGNMMarket_TransferFailed();
}


pragma solidity ^0.8.18;

contract DGNMEvents {
    event ItemListed(uint256 listingId, address seller, uint256 tokenId);
    event ItemSold(uint256 listingId, address buyer);
    event ItemCanceled(uint256 listingId);
    event NewOffer(uint256 offerId, uint256 tokenId, address offerer);
    event OfferAccepted(uint256 offerId, uint256 tokenId, address owner);
    event OfferCanceled(uint256 offerId, uint256 tokenId);
    event AuctionStarted(
        uint256 auctionId,
        address seller,
        uint256 tokenId,
        uint256 startTime
    );
    event NewBid(uint256 auctionId, address bidder, uint256 bidAmount);
    event AuctionDirectBuy(uint256 auctionId, address buyer);
    event AuctionCanceled(uint256 auctionId);
    event AuctionEnded(uint256 auctionId, address buyer);
    event RoyaltyPaid(uint256 tokenId, address receiver, uint256 amount);
    event NewSupportedToken(address token);
    event NewFee(uint256 fee);
}


pragma solidity ^0.8.18;








/// @title DGNM NFT marketplace
/// @author kaymen99
/// @notice marketplace that supports direct sales, offers, and auctions for all the DGNM NFT collection tokens.
contract DGNMMarket is
    IDGNMMarket,
    DGNMErrors,
    DGNMEvents,
    Ownable,
    IERC721Receiver
{
    uint256 private constant PRECISION = 1e3;
    uint256 private constant MAX_FEE = 10; // 1% is maximum trade fee

    Listing[] private _listings;
    Auction[] private _auctions;

    // supported ERC20 tokens
    address[] public supportedERC20tokens;
    mapping(address => bool) private _erc20Tokensmapping;

    // tokenId => offer
    mapping(uint256 => Offer[]) private _offers;

    // auctionId => user => bid amount
    mapping(uint256 => mapping(address => uint256))
        private auctionBidderAmounts;

    IDGNMCollection private immutable nftContract;

    uint256 public fee = 10; // 1%
    address private feeRecipient;

    constructor(address _nftAddress) {
        if (_nftAddress == address(0)) revert DGNMMarket_AddressZero();
        nftContract = IDGNMCollection(_nftAddress);
        feeRecipient = msg.sender;
    }

    // ************************** //
    //      Direct Sale Logic     //
    // ************************** //

    /**
     * @dev Lists an NFT for sale in the marketplace.
     * @dev caller must be NFT owner and payment token must be allowed.
     * @param _tokenId The ID of the NFT to be listed.
     * @param _paymentToken address of token used for payment, address(0) for ETH.
     * @param _buyPrice The sale price of the NFT.
     * @return listingId The ID of the created listing.
     */
    function listItem(
        uint256 _tokenId,
        address _paymentToken,
        uint256 _buyPrice
    ) external returns (uint256 listingId) {
        // check that token is allowed
        _allowedToken(_paymentToken);
        _isDGNMTokenOwner(_tokenId, msg.sender);

        // check that the user approved this contract to transfer token
        if (nftContract.getApproved(_tokenId) != address(this))
            revert DGNMMarket_ItemNotApproved(_tokenId);

        listingId = _listings.length;
        _listings.push();

        Listing storage listingItem = _listings[listingId];
        listingItem.tokenId = _tokenId;
        listingItem.seller = msg.sender;
        listingItem.paymentToken = _paymentToken;
        listingItem.buyPrice = _buyPrice;
        listingItem.status = ListingStatus.Active;

        emit ItemListed(listingId, msg.sender, _tokenId);
    }

    /**
     * @dev Purchases an NFT listed for sale in the marketplace.
     * @param _listingId The ID of the listing to be purchased.
     */
    function buyItem(uint256 _listingId) external payable {
        Listing memory item = _listings[_listingId];

        if (item.status != ListingStatus.Active)
            revert DGNMMarket_ListingNotActive(_listingId);

        if (item.paymentToken == address(0) && msg.value != item.buyPrice)
            revert DGNMMarket_InsufficientAmount();

        // handle payment
        _handlePayment(
            item.tokenId,
            item.seller,
            msg.sender,
            item.paymentToken,
            item.buyPrice
        );

        // transfer nft to buyer
        nftContract.safeTransferFrom(item.seller, msg.sender, item.tokenId);

        // update listing status
        _listings[_listingId].status = ListingStatus.Sold;

        emit ItemSold(_listingId, msg.sender);
    }

    /**
     * @dev Cancels an NFT listing, called by the seller.
     * @param _listingId The ID of the listing to be canceled.
     */
    function cancelListing(uint256 _listingId) external {
        if (msg.sender != _listings[_listingId].seller)
            revert DGNMMarket_OnlySeller(_listingId);
        if (_listings[_listingId].status != ListingStatus.Active)
            revert DGNMMarket_ListingNotActive(_listingId);

        _listings[_listingId].status = ListingStatus.Canceled;

        emit ItemCanceled(_listingId);
    }

    // ********************** //
    //      Offers Logic      //
    // ********************** //

    /**
     * @dev Creates an offer for an NFT.
     * @dev must use allowed token for payment.
     * @param _tokenId The ID of the NFT to make an offer on.
     * @param _paymentToken The token used to buy NFT, set address(0) for ETH.
     * @param _offerPrice The price offered for the NFT.
     * @param _expirationTime The expiration time of the offer.
     * @return offerId The ID of the created offer.
     */
    function makeOffer(
        uint256 _tokenId,
        address _paymentToken,
        uint256 _offerPrice,
        uint256 _expirationTime
    ) external payable returns (uint256 offerId) {
        // check that token is allowed
        _allowedToken(_paymentToken);

        if (nftContract.ownerOf(_tokenId) == address(0)) revert();
        if (_expirationTime <= block.timestamp)
            revert DGNMMarket_InvalidExpirationTime();
        if (_paymentToken == address(0)) {
            // can not approve DTOKEN so offerer is obliged to escrow offerPrice to this contract
            // the fund can be withdrawn by canceling the offer
            if (msg.value != _offerPrice)
                revert DGNMMarket_InsufficientAmount();
        } else {
            // check that the offerer has approved offerPrice amount of paymetToken to this contract
            if (
                IERC20(_paymentToken).allowance(msg.sender, address(this)) <
                _offerPrice
            ) revert DGNMMarket_OfferAmountNotApproved();
        }

        offerId = _offers[_tokenId].length;
        _offers[_tokenId].push();

        Offer storage offer = _offers[_tokenId][offerId];
        offer.offerer = msg.sender;
        offer.paymentToken = _paymentToken;
        offer.price = _offerPrice;
        offer.expireTime = uint48(_expirationTime);
        offer.status = OfferStatus.Active;

        emit NewOffer(offerId, _tokenId, msg.sender);
    }

    /**
     * @dev Accepts an offer for an NFT.
     * @dev callable by the NFT owner.
     * @param _tokenId The ID of the NFT for which the offer is accepted.
     * @param _offerId The ID of the offer to be accepted.
     */
    function acceptOffer(uint256 _tokenId, uint256 _offerId) external {
        Offer storage offer = _offers[_tokenId][_offerId];

        _isDGNMTokenOwner(_tokenId, msg.sender);
        if (_offerStatus(_tokenId, _offerId) != OfferStatus.Active)
            revert DGNMMarket_OfferNotActive(_offerId, _tokenId);

        // handle payment like a normal sale
        _handlePayment(
            _tokenId,
            msg.sender,
            offer.offerer,
            offer.paymentToken,
            offer.price
        );

        offer.status = OfferStatus.Ended;

        // transfer nft to this contract
        nftContract.safeTransferFrom(msg.sender, offer.offerer, _tokenId);

        emit OfferAccepted(_offerId, _tokenId, msg.sender);
    }

    /**
     * @dev Cancels an offer on NFT, callable by the offerer.
     * @param _tokenId The ID of the NFT for which the offer is canceled.
     * @param _offerId The ID of the offer to be canceled.
     */
    function cancelOffer(uint256 _tokenId, uint256 _offerId) external {
        Offer storage offer = _offers[_tokenId][_offerId];

        if (msg.sender != offer.offerer)
            revert DGNMMarket_OnlyOfferer(_offerId, _tokenId);
        if (_offerStatus(_tokenId, _offerId) != OfferStatus.Active)
            revert DGNMMarket_OfferNotActive(_offerId, _tokenId);

        offer.status = OfferStatus.Ended;

        if (offer.paymentToken == address(0)) {
            // return DTOKEN amount escowed when creating offer to offerer
            PaymentLib.transferNativeToken(offer.offerer, offer.price);
        }

        emit OfferCanceled(_offerId, _tokenId);
    }

    // ********************** //
    //      Auction Logic     //
    // ********************** //

    /**
     * @dev Starts an auction for an NFT.
     * @dev caller must be NFT owner and payment token must be allowed.
     * @param _tokenId The ID of the NFT to be auctioned.
     * @param _paymentToken The token used for the auction payment, set address(0) for ETH.
     * @param _directBuyPrice The direct buy price for the NFT.
     * @param _startPrice The starting bid price for the auction.
     * @param _startTime The start time of the auction.
     * @param _endTime The end time of the auction.
     * @return auctionId The ID of the created auction.
     */
    function startAuction(
        uint256 _tokenId,
        address _paymentToken,
        uint256 _directBuyPrice,
        uint256 _startPrice,
        uint256 _startTime,
        uint256 _endTime
    ) external returns (uint256 auctionId) {
        // check that token is allowed
        _allowedToken(_paymentToken);
        _isDGNMTokenOwner(_tokenId, msg.sender);
        _startTime = _startTime < block.timestamp
            ? uint48(block.timestamp)
            : uint48(_startTime);

        if (_endTime <= _startTime)
            revert DGNMMarket_InvalidAuctionPeriod(_endTime, _startTime);
        if (_startPrice == 0) revert DGNMMarket_InvalidStartPrice();
        if (_directBuyPrice <= _startPrice)
            revert DGNMMarket_InvalidDirectBuyPrice(_directBuyPrice);

        auctionId = _auctions.length;
        _auctions.push();

        Auction storage _auction = _auctions[auctionId];
        _auction.tokenId = _tokenId;
        _auction.seller = msg.sender;
        _auction.paymentToken = _paymentToken;
        _auction.directBuyPrice = _directBuyPrice;
        _auction.startPrice = _startPrice;
        _auction.startTime = uint48(_startTime);
        _auction.endTime = uint48(_endTime);
        _auction.status = AuctionStatus.Open;

        // transfer nft to this contract
        nftContract.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit AuctionStarted(auctionId, msg.sender, _tokenId, _startTime);
    }

    /**
     * @dev Places a bid in an ongoing auction.
     * @param _auctionId The ID of the auction in which to place a bid.
     * @param _amount The bid amount.
     */
    function bid(uint256 _auctionId, uint256 _amount) external payable {
        Auction storage _auction = _auctions[_auctionId];

        if (_auctionStatus(_auctionId) != AuctionStatus.Open)
            revert DGNMMarket_AuctionNotOpen(_auctionId);
        if (msg.sender == _auction.highestBidder)
            revert DGNMMarket_AlreadyHighestBid(_auctionId);

        address token = _auction.paymentToken;
        if (token == address(0)) {
            _amount = msg.value;
        }

        uint256 oldBidAmount = auctionBidderAmounts[_auctionId][msg.sender];
        if (_auction.highestBidder != address(0)) {
            if (oldBidAmount + _amount <= _auction.highestBid)
                revert DGNMMarket_InsufficientBid(_auctionId);
        } else {
            // case of the first bid
            if (_amount < _auction.startPrice)
                revert DGNMMarket_InsufficientBid(_auctionId);
        }
        if (token != address(0)) {
            IERC20(token).transferFrom(msg.sender, address(this), _amount);
        }

        auctionBidderAmounts[_auctionId][msg.sender] = oldBidAmount + _amount;
        _auction.highestBidder = msg.sender;
        _auction.highestBid = oldBidAmount + _amount;

        emit NewBid(_auctionId, msg.sender, oldBidAmount + _amount);
    }

    /**
     * @dev Directly buys an NFT in an ongoing auction.
     * @dev must provide exact direct buy price
     * @param _auctionId The ID of the auction for the direct buy.
     */
    function directBuyAuction(uint256 _auctionId) external payable {
        Auction storage _auction = _auctions[_auctionId];

        if (_auctionStatus(_auctionId) != AuctionStatus.Open)
            revert DGNMMarket_AuctionNotOpen(_auctionId);

        uint256 tokenId = _auction.tokenId;
        address token = _auction.paymentToken;
        uint256 price = _auction.directBuyPrice;
        if (token == address(0) && msg.value != price)
            revert DGNMMarket_InsufficientAmount();

        // handle payment
        _handlePayment(tokenId, _auction.seller, msg.sender, token, price);

        _auction.status = AuctionStatus.DirectBuy;

        // transfer nft to the buyer
        nftContract.safeTransferFrom(address(this), msg.sender, tokenId);

        emit AuctionDirectBuy(_auctionId, msg.sender);
    }

    /**
     * @dev Withdraws a bid placed in an auction.
     * @dev highest bidder is not allowed to withdraw bid.
     * @param _auctionId The ID of the auction from which to withdraw the bid.
     */
    function withdrawBid(uint256 _auctionId) external {
        if (_auctions[_auctionId].status == AuctionStatus.Open) {
            // if auction is open don't allow highest bidder withdrawal
            if (msg.sender == _auctions[_auctionId].highestBidder)
                revert DGNMMarket_IsHighestBidder(_auctionId);
        }
        uint256 bidAmount = auctionBidderAmounts[_auctionId][msg.sender];
        if (bidAmount == 0) revert DGNMMarket_HasNoBid(_auctionId);
        auctionBidderAmounts[_auctionId][msg.sender] = 0;
        // return bid amount to the bidder
        PaymentLib.transferToken(
            _auctions[_auctionId].paymentToken,
            address(this),
            msg.sender,
            bidAmount
        );
    }

    /**
     * @dev Ends an auction and transfers the NFT to the highest bidder.
     * @dev will return NFT to seller if no bid is made.
     * @param _auctionId The ID of the auction to be ended.
     */
    function endAuction(uint256 _auctionId) external {
        Auction storage _auction = _auctions[_auctionId];
        if (
            _auctionStatus(_auctionId) != AuctionStatus.Ended ||
            _auction.status != AuctionStatus.Open
        ) revert DGNMMarket_AuctionPeriodNotEnded(_auctionId, _auction.endTime);
        uint256 tokenId = _auction.tokenId;
        // update auction status
        _auction.status = AuctionStatus.Ended;

        address buyer;
        if (_auction.highestBidder != address(0)) {
            buyer = _auction.highestBidder;

            // handle payment
            _handlePayment(
                tokenId,
                _auction.seller,
                address(this),
                _auction.paymentToken,
                _auction.highestBid
            );

            // transfer nft to the highest bidder
            nftContract.safeTransferFrom(address(this), buyer, tokenId);
        } else {
            // transfer nft back to the seller
            nftContract.safeTransferFrom(
                address(this),
                _auction.seller,
                tokenId
            );
        }

        emit AuctionEnded(_auctionId, buyer);
    }

    /**
     * @dev Cancels an ongoing auction, called by the seller.
     * @dev auction must in open state.
     * @param _auctionId The ID of the auction to be canceled.
     */
    function cancelAuction(uint256 _auctionId) external {
        if (msg.sender != _auctions[_auctionId].seller)
            revert DGNMMarket_OnlySeller(_auctionId);
        AuctionStatus state = _auctionStatus(_auctionId);
        if (state != AuctionStatus.Open && state != AuctionStatus.Closed)
            revert DGNMMarket_CancelImpossible(_auctionId);

        _auctions[_auctionId].status = AuctionStatus.Canceled;

        // transfer nft back to seller
        nftContract.safeTransferFrom(
            address(this),
            msg.sender,
            _auctions[_auctionId].tokenId
        );

        emit AuctionCanceled(_auctionId);
    }

    // ************************ //
    //      Internal utils      //
    // ************************ //

    /**
     * @dev Checks if the provided user is the owner of the DGNM NFT.
     * @param _tokenId The ID of the NFT.
     * @param user The address to be checked.
     */
    function _isDGNMTokenOwner(uint256 _tokenId, address user) internal view {
        // check that the user is the owner of the token
        // also reverts if the token does not exists in the DGNM collection
        if (nftContract.ownerOf(_tokenId) != user)
            revert DGNMMarket_OnlyTokenOwner(_tokenId);
    }

    /**
     * @dev Checks if the provided ERC20 token is allowed in the marketplace.
     * @dev native ETH is supported by default.
     * @param token The ERC20 token address to be checked.
     */
    function _allowedToken(address token) internal view {
        if (token != address(0)) {
            if (!_erc20Tokensmapping[token])
                revert DGNMMarket_UnsupportedToken(token);
        }
    }

    /**
     * @dev Handles the payment for an NFT purchase, offer acceptance, or auction.
     * @param tokenId The ID of the NFT.
     * @param seller The address of the seller.
     * @param buyer The address of the buyer.
     * @param paymentToken The token used for payment, address(0) for ETH.
     * @param price The total payment amount.
     */
    function _handlePayment(
        uint256 tokenId,
        address seller,
        address buyer,
        address paymentToken,
        uint256 price
    ) internal {
        (address royaltyReceiver, uint256 royaltyAmount) = nftContract
            .royaltyInfo(tokenId, price);

        uint256 feeAmount = (price * fee) / PRECISION;

        // pay platform fee
        PaymentLib.transferToken(paymentToken, buyer, feeRecipient, feeAmount);

        uint256 finalAmount;
        unchecked {
            finalAmount = price - feeAmount;
        }

        if (seller != royaltyReceiver && royaltyAmount != 0) {
            // pay NFT creator royalty fee
            PaymentLib.transferToken(
                paymentToken,
                buyer,
                royaltyReceiver,
                royaltyAmount
            );

            unchecked {
                finalAmount -= royaltyAmount;
            }

            emit RoyaltyPaid(tokenId, royaltyReceiver, royaltyAmount);
        }

        // pay seller remaining amount
        PaymentLib.transferToken(paymentToken, buyer, seller, finalAmount);
    }

    /**
     * @dev Checks the status of an offer.
     * @param tokenId The ID of the NFT for which the offer status is checked.
     * @param offerId The ID of the offer.
     * @return status The status of the offer.
     */
    function _offerStatus(
        uint256 tokenId,
        uint256 offerId
    ) internal view returns (OfferStatus) {
        Offer storage offer = _offers[tokenId][offerId];
        if (offer.expireTime < uint48(block.timestamp)) {
            return OfferStatus.Ended;
        } else {
            return offer.status;
        }
    }

    /**
     * @dev Checks the status of an auction.
     * @param auctionId The ID of the auction.
     * @return status The status of the auction.
     */
    function _auctionStatus(
        uint256 auctionId
    ) internal view returns (AuctionStatus) {
        Auction storage auction = _auctions[auctionId];
        AuctionStatus status = auction.status;
        uint48 timestamp = uint48(block.timestamp);
        if (
            status == AuctionStatus.Canceled ||
            status == AuctionStatus.DirectBuy
        ) {
            return status;
        } else if (auction.startTime > timestamp) {
            return AuctionStatus.Closed;
        } else if (timestamp <= auction.endTime) {
            return AuctionStatus.Open;
        } else {
            return AuctionStatus.Ended;
        }
    }

    // ***************** //
    //      Getters      //
    // ***************** //

    /**
     * @dev Retrieves all current listings in the marketplace.
     */
    function getListings() external view returns (Listing[] memory) {
        return _listings;
    }

    /**
     * @dev Retrieves all current auctions in the marketplace.
     */
    function getAuctions() external view returns (Auction[] memory) {
        return _auctions;
    }

    /**
     * @dev Retrieves the status of an auction.
     * @param _auctionId The ID of the auction.
     * @return status The status of the auction.
     */
    function getAuctionStatus(
        uint256 _auctionId
    ) external view returns (AuctionStatus) {
        return _auctionStatus(_auctionId);
    }

    /**
     * @dev Retrieves all offers made for a specific NFT.
     * @param tokenId The ID of the NFT.
     * @return offers An array of all Offers structures.
     */
    function getTokenBuyOffers(
        uint256 tokenId
    ) external view returns (Offer[] memory) {
        return _offers[tokenId];
    }

    /**
     * @dev Retrieves the bid amount placed by a specific user in an auction.
     * @param auctionId The ID of the auction.
     * @param account The address of the user.
     * @return bidAmount The bid amount placed by the user.
     */
    function getUserBidAmount(
        uint256 auctionId,
        address account
    ) external view returns (uint256) {
        return auctionBidderAmounts[auctionId][account];
    }

    /**
     * @dev ERC721 receiver callback to accept incoming NFT transfers.
     */
    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    // ********************** //
    //     Owner functions    //
    // ********************** //

    /**
     * @dev Sets the trade fee percentage.
     * @dev callable by the owner
     * @param _fee The new trade fee percentage.
     */
    function setFee(uint256 _fee) external onlyOwner {
        if (_fee > MAX_FEE) revert DGNMMarket_InvalidFee(_fee);
        fee = _fee;

        emit NewFee(_fee);
    }

    /**
     * @dev Sets the recipient of market fees.
     * @dev callable by the owner
     * @param _newRecipient The new address to receive trade fees.
     */
    function setFeeRecipient(address _newRecipient) external onlyOwner {
        feeRecipient = _newRecipient;
    }

    /**
     * @dev Adds support for a new ERC20 token in the marketplace.
     * @dev callable by the owner.
     * @param _token The address of the ERC20 token to be supported.
     */
    function addSupportedToken(address _token) external onlyOwner {
        if (_erc20Tokensmapping[_token])
            revert DGNMMarket_AlreadySupported(_token);
        _erc20Tokensmapping[_token] = true;
        supportedERC20tokens.push(_token);

        emit NewSupportedToken(_token);
    }
}
