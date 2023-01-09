import { DeployFunction } from "hardhat-deploy/types";
import { TESTNFT__factory } from "../types";
import { Ship } from "../utils";

const func: DeployFunction = async (hre) => {
  const { deploy } = await Ship.init(hre);
  await deploy(TESTNFT__factory);
};

export default func;
func.tags = ["nft"];
