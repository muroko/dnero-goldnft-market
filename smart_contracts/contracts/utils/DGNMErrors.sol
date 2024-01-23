// SPDX-License-Identifier: MIT

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
