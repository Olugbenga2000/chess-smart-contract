import { run,ethers } from "hardhat";

async function main() {
   //todo: fill in the deployment code here to deploy ComplexGame, SimpleGame,
   //Please consider upgradability and access control if possible, could change the Corresponding Contract if needed
   const randomizerLibrary = await ethers.getContractFactory("Randomizer")
   const randomizer = await randomizerLibrary.deploy();
   const GameRunnerContract = await ethers.getContractFactory("GameRunner", {
    libraries: {
    Randomizer: randomizer.address,
  },
});
    const GameRunner = await GameRunnerContract.deploy()
    await GameRunner.deployed();
    console.log("Contract deployed to : ", GameRunner.address)
    console.log("running simple game");
    await GameRunner.runSimple();
    console.log("\nrunning complex game");
    await GameRunner.runComplex();
}
 
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
