import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const NftMarketplaceModule = buildModule("NftMarketplaceModule", (m) => {

  const nftMarketplace = m.contract("NFTMarketplace", []);

  return { nftMarketplace };
});

export default NftMarketplaceModule;
