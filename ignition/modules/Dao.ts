import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";

const DaoModule = buildModule("DAOModule", (m) => {

    const deployDao = m.contract("DAO", []);

    return { deployDao};
});

export default DaoModule;
