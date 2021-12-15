pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FunNFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Collection{
        uint tokenId;
        uint price;
        bool forSale;   
    }

    mapping(uint => Collection) collections;


    constructor() ERC721("FunNFT Collection","FUN"){}


    modifier existAndOwned(uint tokenId) {
        require(_exists(tokenId),"Nft with this id does'nt exists");
        require(msg.sender != ownerOf(tokenId),"you already own this nft");
        _;
    }

    function mint(string memory tokenURI , uint price) public returns (uint tokenId){
        _tokenIds.increment();
        tokenId = _tokenIds.current();

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId,tokenURI);

        Collection memory collection = Collection(tokenId,price,false);

        collections[tokenId] = collection;
    }

    function buy(uint tokenId) public payable existAndOwned(tokenId) {
        Collection memory collection = collections[tokenId];

        require(msg.value >= collection.price);

        require(collection.forSale);

        address owner = ownerOf(tokenId);

        payable(owner).transfer(msg.value);
        _transfer(owner,msg.sender,tokenId);

        collection.forSale = false;
        collections[tokenId] = collection;
    }

    function toggleForSale(uint tokenId) public existAndOwned(tokenId) {
        Collection memory collection = collections[tokenId];

        collection.forSale = !collection.forSale;

        collections[tokenId] = collection;

    }
}