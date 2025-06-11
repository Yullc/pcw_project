package org.example.interceptor;

import org.example.service.MemberService;
import org.example.vo.Member;
import org.example.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {

    @Autowired
    private Rq rq;

    @Autowired
    private MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

        // 로그 남기기
        rq.initBeforeActionInterceptor();

        // 로그인 상태면, 매 요청마다 Member 객체를 세팅
        if (rq.isLogined()) {
            Member member = memberService.getMemberById(rq.getLoginedMemberId());
            rq.setLoginedMember(member);
        }

        return true;
    }
}
