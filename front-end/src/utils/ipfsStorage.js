import { NFTStorage } from 'nft.storage';
//import { filesFromPath } from 'files-from-path'
//import path from 'path'

const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDM5NzgwZmJmM0QwNjAxNjliODhiNEEyMGEwNTBiNTc5M2RFRmZmQWUiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTcwNjc5NDc1Mjg3MiwibmFtZSI6IkRuZXJvR29sZE5mdC1NYXJrZXRUZXN0In0.OWsUaHOOCuau2icUP680FuzSxFa7FLYrgl8tweCmX-Q';

//export const IPFS_GATEWAY = "https://ipfs.io/ipfs/";
export const IPFS_GATEWAY = "https://nftstorage.link/ipfs/"; //Gateway from web3.storage

function MakeStorageClient() {
   return new NFTStorage({ token });
}


  //const storage = new NFTStorage({ token })


export const saveContent = async (file) => {
  console.log(`storing file(s)...with nft.storage`);
  const storage = MakeStorageClient();
  //const cid = await client.put([file]);
  //console.log("Stored files with cid:", cid);
  //
  //const cid = await storage.storeDirectory(files);
  const cid = await storage.storeDirectory([file]);
  console.log("Stored files with cid:", { cid });
  return cid;
  //const status = await storage.status(cid);
  //console.log(status);
};
