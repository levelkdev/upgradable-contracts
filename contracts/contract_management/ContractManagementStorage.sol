pragma solidity 0.4.18;

contract ContractManagementStorage {
  address contractManager;
  // Accessors for mapping with dynamically-sized keys not yet implemented.
  mapping(string => address) internal registeredContracts;
  mapping(address => string) public registeredContractKeys;
  mapping(string => address) internal registeredProxies;
}
