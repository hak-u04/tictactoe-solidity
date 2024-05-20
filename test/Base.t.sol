// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TicTacToe} from "../src/TicTacToe.sol";

contract Base is Test {
    TicTacToe public tictac;
    address public player1 = address(1);
    address public player2 = address(2);

    function setUp() public {
        tictac = new TicTacToe(player1, player2);
    }

}