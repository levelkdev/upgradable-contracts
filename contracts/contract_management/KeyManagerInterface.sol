pragma solidity 0.4.18;

contract KeyManagerInterface {
  function keyForContract(address contract_) public view returns (bytes32 key);
}
