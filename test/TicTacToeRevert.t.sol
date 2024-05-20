// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Base.t.sol";

contract TicTacToeRevert is Base {

    function test_play_revert_PositionAlreadyUsed() public {
        vm.startPrank(player1);
        tictac.play(2, 2);
        vm.stopPrank();

        vm.startPrank(player2);
        vm.expectRevert(TicTacToe.PositionAlreadyUsed.selector);
        tictac.play(2, 2);
        vm.stopPrank();
    }

    function test_play_revert_NotYourTurn() public {
        vm.startPrank(player2);
        vm.expectRevert(TicTacToe.NotYourTurn.selector);
        tictac.play(0, 0);
    }

    function test_play_revert_AlreadyFinished() public {
        vm.prank(player1);
        tictac.play(0, 0);

        vm.prank(player2);
        tictac.play(0, 1);

        vm.prank(player1);
        tictac.play(1, 0);

        vm.prank(player2);
        tictac.play(0, 2);

        vm.prank(player1);
        tictac.play(2, 0);

        vm.startPrank(player2);
        vm.expectRevert(TicTacToe.AlreadyFinished.selector);
        tictac.play(2, 2);
        vm.stopPrank();
    }
}
