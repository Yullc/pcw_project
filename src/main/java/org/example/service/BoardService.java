package org.example.service;
import org.example.repository.BoardRepository;
import org.example.vo.Board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.example.repository.MemberRepository;
import org.example.util.Ut;
import org.example.vo.Member;
import org.example.vo.ResultData;

import java.time.LocalDateTime;
@Service
public class BoardService {

    @Autowired
    private BoardRepository boardRepository;

    public BoardService(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }

    public Board getBoardById(int boardId) {

        return boardRepository.getBoardById(boardId);
    }

}