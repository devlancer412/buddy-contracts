import { DeployFunction } from "hardhat-deploy/types";
import { ERC721ATest__factory } from "../types";
import { Ship } from "../utils";

const func: DeployFunction = async (hre) => {
  const { deploy } = await Ship.init(hre);
  await deploy(ERC721ATest__factory, {
    args: [
      "ERC721A",
      "ERC721A",
      "https://ipfs.io/ipfs/Qmbr491nZuoEsLHQ1PXihiSfoy9oSJrjUBCYWnfRoyijoJ",
      10,
      "10000000000000000",
      1000,
    ],
  });
};

export default func;
func.tags = ["erc721a"];
