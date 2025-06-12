<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>팀 구하기</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="h-screen flex flex-col">
<div class="px-[150px]">

    <!-- 상단 헤더 -->
    <header class="flex items-center justify-between p-5 border-b border-gray-300">
        <!-- 왼쪽 로고 -->
        <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">
            로고
        </a>

        <form action="/usr/article/findTeam" method="post" class="flex justify-center w-full">
            <div class="relative w-64">
                <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색..."
                       class="w-full pl-4 pr-10 py-2 rounded-full border border-green-500 focus:outline-none focus:ring-2 focus:ring-green-300" />

                <!-- 제출 버튼 -->
                <button type="submit" class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500">
                    🔍
                </button>
            </div>

            <!-- 선택 필터들도 같이 넘기기 -->
            <input type="hidden" name="area" value="${area}" />
            <input type="hidden" name="avgLevel" value="${avgLevel}" />

        </form>

        <div class="flex items-center gap-6 whitespace-nowrap">
            <a href="/usr/home/foot_menu" class="text-sm text-black hover:text-red-500">풋살하기</a>
            <a href="/usr/home/soccer_menu" class="text-sm text-black hover:text-red-500">축구하기</a>
            <a href="/usr/article/findMercenary" class="text-sm text-black hover:text-red-600">용병 구하기</a>
            <a href="/usr/article/findTeam" class="text-sm font-bold text-black border-b-2 border-green-600">팀 구하기</a>
            <a href="/usr/member/doLogout" class="text-sm text-black hover:text-red-500">로그아웃</a>

            <a href="/usr/member/myPage">
                <img src="${profileImg}" alt="profile" class="w-10 h-10 rounded-full object-cover" />
            </a>
        </div>
    </header>

    <!-- 본문 -->
    <div class="flex flex-1 overflow-hidden">

        <aside class="w-56 p-5 border-r border-gray-300 space-y-6 overflow-y-auto">
            <!-- 지역 필터 -->
            <div>
                <h2 class="font-bold mb-2">지역</h2>
                <div class="flex flex-wrap gap-2">
                    <c:forEach var="region" items="${['서울','경기','강원','인천','대전','세종','충북','충남','대구','경북','경남','부산','광주','전북','울산','전남','제주']}">
                        <a href="/usr/article/findTeam?area=${region}&avgLevel=${avgLevel}&playDate=${playDate}"
                           class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${region == area ? 'bg-green-500 text-white' : ''}">
                                ${region}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- 레벨 필터 -->
            <div>
                <h2 class="font-bold mb-2">레벨</h2>
                <div class="flex flex-wrap gap-2">
                    <c:forEach var="levelOption" items="${['루키','아마추어','세미프로','프로']}">
                        <a href="/usr/article/findTeam?area=${area}&avgLevel=${levelOption}"
                           class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${levelOption == teamRank ? 'bg-green-500 text-white' : ''}">
                                ${levelOption}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </aside>
        <!-- 팀 리스트 -->


        </main>
        <section class="flex-1 p-28">
            <c:forEach var="team" items="${teamArticles}">
                <div class="border border-green-700 rounded-lg p-4 mb-4 flex items-center justify-between hover:shadow-md">
                    <div class="flex items-center gap-4">
                        <div class="w-2 h-6 bg-green-500 rounded-r"></div>
                        <div>
                            <div class="font-bold text-lg">${team.teamName}</div>

                        </div>
                    </div>
                    <div class="text-sm text-right text-gray-500 whitespace-nowrap flex gap-4">
                        <div>${team.teamName}</div>
                        <div>${team.teamLeader}</div>
                        <div>${team.teamRank}</div>
                    </div>
                </div>
            </c:forEach>

            <!-- ✅ 페이지네이션 -->
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- 페이지네이션 그룹 계산 -->
            <c:set var="groupSize" value="5" />
            <!-- 현재 그룹 계산 -->
            <fmt:parseNumber value="${(page - 1) div groupSize}" integerOnly="true" var="currentGroup" />
            <fmt:parseNumber value="${currentGroup * groupSize + 1}" integerOnly="true" var="groupStart" />
            <fmt:parseNumber value="${groupStart + groupSize - 1}" integerOnly="true" var="groupEnd" />

            <!-- 페이지 수 초과 방지 -->
            <c:if test="${groupEnd > pagesCount}">
                <c:set var="groupEnd" value="${pagesCount}" />
            </c:if>

            <!-- ✅ 페이지네이션 출력 -->
            <div class="mt-6 flex justify-center space-x-2">

                <!-- 이전 그룹 버튼 -->
                <c:if test="${groupStart > 1}">
                <a href="/usr/article/findTeam?page=${groupStart - 1}&area=${area}"
                   class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
                    &lt;
                </a>
                </c:if>

                <!-- 현재 그룹의 페이지 번호 출력 -->
                <c:forEach begin="${groupStart}" end="${groupEnd}" var="i">
                <a href="/usr/article/findTeam?page=${i}&area=${area}"
                   class="px-3 py-1 border rounded-full
              ${i == page ? 'bg-green-600 text-white' : 'bg-white text-gray-800 hover:bg-gray-200'}">
                        ${i}
                </a>
                </c:forEach>

                <!-- 다음 그룹 버튼 -->
                <c:if test="${groupEnd < pagesCount}">
                <a href="/usr/article/findTeam?page=${groupEnd + 1}&area=${area}"
                   class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
                    &gt;
                </a>
                </c:if>
        </section>
</body>
</div>
</html>