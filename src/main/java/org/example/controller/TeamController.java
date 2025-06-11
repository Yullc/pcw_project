package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.MatchParticipantService;
import org.example.service.TeamService;
import org.example.vo.FtArticle;
import org.example.vo.Rq;
import org.example.vo.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TeamController {
    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    Rq rq;

    @Autowired
    private TeamService teamService;
    public TeamController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }
//
//    @RequestMapping("/usr/article/findTeam")
//    public String showFindTeamPage(HttpServletRequest req, Model model,
//                                   @RequestParam(defaultValue = "1") int page,
//                                   @RequestParam(defaultValue = "") String teamName,
//                                   @RequestParam(defaultValue = "") String teamRank,
//
//                                   @RequestParam(defaultValue = "") String teamLeader) {
//
//
//        List<Team> teams = teamService.getForPrintTeam(teamName, teamRank, teamLeader);
//
//        model.addAttribute("teams", teams);
//        model.addAttribute("teamName", teamName);
//        model.addAttribute("teamRank", teamRank);
//        model.addAttribute("teamLeader", teamLeader);
//
//        return "usr/article/findTeam";
//    }


}
