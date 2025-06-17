package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper

public interface ReactionPointRepository {
    int getReactionCount(int fromMemberId, int toMemberId);

    void insertReactionPoint(int fromMemberId, int toMemberId, int point); // point는 1

    void deleteReactionPoint(int fromMemberId, int toMemberId);
}
