//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "./SystemTypes.sol";
import './BishopMove.sol';
contract QueenMove{

    function validQueenMoves(SystemTypes.Position memory _position) public returns (SystemTypes.Position[] memory){
        BishopMove bishopMove = new BishopMove();
        SystemTypes.Position[] memory diagonalMoves = bishopMove.validMovesFor(_position);
        uint length = diagonalMoves.length;
        SystemTypes.Position[] memory allValidMoves = new SystemTypes.Position[](length + 14);

        // diagonal moves
        for(uint i = 0; i < length; i++){ 
            allValidMoves[i] = diagonalMoves[i];
        }

        // horizontal moves
        for(uint i = 1; i <= 8; i++){  
            if(i == _position.Y)
                continue;
            allValidMoves[length] = SystemTypes.Position(_position.X, i);
            length++;
        }

        // vertical moves
        for(uint i = 1; i <= 8; i++){
            if(i == _position.X)
                continue;
            allValidMoves[length] = SystemTypes.Position(i, _position.Y);
            length++;
        }

        return allValidMoves;
    }
}