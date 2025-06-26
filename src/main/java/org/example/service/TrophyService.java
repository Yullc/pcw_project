package org.example.service;

import org.example.repository.TrophyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TrophyService {
    @Autowired
    private TrophyRepository trophyRepository;

    public String getSvgByRank(int rank) {
        return trophyRepository.findSvgByRank(rank);
    }
}
