package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

import org.example.vo.Board;

@Mapper
public interface BoardRepository {

    public Board getBoardById(int id);

}