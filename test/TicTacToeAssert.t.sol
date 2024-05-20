// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Base.t.sol";

contract TicTacToeAssert is Base {

    function test_checkWinner() public {
        vm.startPrank(player1);
        tictac.play(0, 0);
        vm.stopPrank();

        vm.startPrank(player2);
        tictac.play(0, 2);
        vm.stopPrank();

        vm.startPrank(player1);
        tictac.play(1, 1);  
        vm.stopPrank();

        vm.startPrank(player2);
        tictac.play(1, 2);
        vm.stopPrank();

        vm.startPrank(player1);
        tictac.play(2, 2); 
        vm.stopPrank();

        assertEq(tictac.winner(), player1);

        uint8[3][3] memory board = tictac.getBoard();

        assertEq(board[0][0], 1);
        assertEq(board[1][1], 1);
        assertEq(board[2][2], 1);

        assertEq(board[0][2], 2);
        assertEq(board[1][2], 2);
    }

}