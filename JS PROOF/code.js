const NFTs = []

function mintNFT (_name,_style,_colour) {
  const NFT={
    "name": _name,
    "style": _style,
    "colour": _colour   
  }
  NFTs.push(NFT);
  console.log("NFT "+ _name +" created\n")
}

function listNFTs () {
  for(i=0;i<NFTs.length;i++){
    console.log(NFTs[i].name)
    console.log(NFTs[i].style)
    console.log(NFTs[i].colour)
    console.log(" ")
  }

}

function getTotalSupply() {
  console.log("The total supply of NFT's are: " + NFTs.length);

}

mintNFT("A","B","C")
mintNFT("Black","Purple","Green")
listNFTs()
getTotalSupply()
