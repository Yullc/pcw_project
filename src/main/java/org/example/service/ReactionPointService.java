package org.example.service;

import org.example.repository.ReactionPointRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReactionPointService {

    @Autowired
    private ReactionPointRepository reactionPointRepository;

    public boolean hasLiked(int fromMemberId, int toMemberId) {
        return reactionPointRepository.getReactionCount(fromMemberId, toMemberId) > 0;
    }

    public void addLike(int fromMemberId, int toMemberId) {
        reactionPointRepository.insertReactionPoint(fromMemberId, toMemberId, 1);
    }

    public void deleteLike(int fromMemberId, int toMemberId) {
        reactionPointRepository.deleteReactionPoint(fromMemberId, toMemberId);
    }
}
