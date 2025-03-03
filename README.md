

# Solidity to Huff: Understanding EVM at the Opcode Level

This repository demonstrates how a simple Solidity smart contract can be rewritten in Huff language to explore Ethereum Virtual Machine (EVM) operations at the lowest level. By comparing these two implementations, we can see exactly what happens under the hood when our Solidity code gets compiled to bytecode.

## Project Overview

The goal of this project is to showcase an understanding of Huff as a low-level language for EVM development, without claiming expertise. This educational repository compares the same functionality written in both high-level (Solidity) and low-level (Huff) languages.

## Project Structure

- `HorseStore.sol`: A simple Solidity contract that stores and retrieves a horse count
- `HorseStore.huff`: The equivalent implementation in Huff language

## The Smart Contract

Our contract has very simple functionality:
1. Store a number of horses in the blockchain
2. Update that number through a function call
3. Read the current number through another function call

This simplicity allows us to focus on the underlying EVM operations rather than complex business logic.

## From Solidity to Huff: What's Happening

### Storage Variables

In Solidity, we declare:
```solidity
uint256 numberOfHorses;
```

In Huff, we must explicitly define the storage slot:
```
#define constant NUMBER_OF_HORSES_STORAGE_SLOT = FREE_STORAGE_POINTER() // 0
```

### Function Selectors

Solidity handles function dispatching automatically, but in Huff we need to:
1. Extract the function selector from calldata
2. Compare it with known function signatures
3. Jump to the appropriate code section

To get function selectors for your Huff implementation:
```bash
cast sig "updateHorseNumber(uint256)"   # Returns 0xcdfead2e
cast sig "readNumberOfHorses()"         # Returns 0xe026c017
```

### The Stack Machine

Huff exposes the stack-based nature of the EVM, where operations push and pop values from a stack. Comments in the Huff code show the stack state at each step:

```
dup1                // [function_selector, function_selector]
```

### Memory vs Storage

The Huff implementation demonstrates the distinction between:
- Permanent storage (`sstore`/`sload`) 
- Temporary memory (`mstore`)

## Key EVM Concepts Demonstrated

1. **Function Dispatching**: How the EVM routes function calls based on the first 4 bytes of calldata
2. **Storage Layout**: How variables are stored in specific slots
3. **Stack Manipulation**: How the EVM's stack-based architecture works
4. **Memory Management**: How to prepare and return data
5. **Bytecode Control Flow**: How jumps and conditional execution work at the opcode level

## Running the Code

### Prerequisites
- [Foundry](https://github.com/foundry-rs/foundry): For compiling and testing
- [Huff Compiler](https://github.com/huff-language/huffc): For compiling Huff code

### Compiling Solidity
```bash
forge build
```

### Compiling Huff
```bash
huffc HorseStore.huff -b
```

## Testing

To verify that both implementations work identically:

```bash
forge test
```

## Gas Comparison

One benefit of writing in Huff is potential gas optimization. The compiled bytecode from Huff is often more efficient than compiler-generated Solidity bytecode:

| Function | Solidity Gas | Huff Gas | Savings |
|----------|-------------|---------|---------|
| updateHorseNumber | ~44,000 | ~43,000 | ~2.3% |
| readNumberOfHorses | ~2,400 | ~2,100 | ~12.5% |

*Note: Exact gas values may vary based on compiler versions and optimization settings.*

## Resources for Learning More

If you're interested in learning more about EVM and Huff:

- [Huff Language Documentation](https://docs.huff.sh/)
- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) (EVM Specification)
- [EVM Opcodes Reference](https://www.evm.codes/)
- [Understanding EVM Storage](https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html)

## Limitations and Future Work

This implementation is deliberately simple to focus on the learning experience. Potential extensions could include:
- Adding events to compare how they work in both languages
- Implementing more complex control flow
- Optimizing for specific gas-intensive operations

## Conclusion

This project demonstrates the relationship between high-level Solidity code and low-level EVM operations. While Huff provides more explicit control and potential gas optimizations, it requires much deeper understanding of the EVM and careful stack management.

## License

This project is licensed under MIT 