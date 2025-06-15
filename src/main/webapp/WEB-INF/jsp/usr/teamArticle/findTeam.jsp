<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">로고</a>

        <form action="/usr/article/findTeam" method="get" class="flex justify-center w-full">
            <div class="relative w-64">
                <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="검색..."
                       class="w-full pl-4 pr-10 py-2 rounded-full border border-green-500 focus:outline-none focus:ring-2 focus:ring-green-300" />
                <button type="submit" class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500">🔍</button>
            </div>
            <input type="hidden" name="area" value="${area}" />
            <input type="hidden" name="avgLevel" value="${avgLevel}" />
        </form>

        <div class="flex items-center gap-6 whitespace-nowrap">
            <a href="/usr/ftArticle/foot_menu" class="text-sm text-black hover:text-red-500">풋살하기</a>
            <a href="/usr/scArticle/soccer_menu" class="text-sm text-black hover:text-red-500">축구하기</a>
            <a href="/usr/mercenaryArticle/findMercenary" class="text-sm text-black hover:text-red-600">용병 구하기</a>
            <a href="/usr/teamArticle/findTeam" class="text-sm font-bold text-black border-b-2 border-green-600">팀 구하기</a>
            <a href="/usr/member/doLogout" class="text-sm text-black hover:text-red-500">로그아웃</a>
            <a href="/usr/home/myPage" class="block w-10 h-10">
                <img src="${profileImg}" alt="profile"
                     class="w-full h-full rounded-full object-cover" />
            </a>
        </div>
    </header>

    <!-- 본문 -->
    <div class="flex flex-1 overflow-hidden">
        <aside class="w-56 p-5 border-r border-gray-300 space-y-6 overflow-y-auto">

            <!-- ✅ 지역 필터링 -->
            <div>
                <h2 class="font-bold mb-2">지역</h2>
                <div class="flex flex-wrap gap-2">
                    <!-- 전체 지역 -->
                    <a href="/usr/teamArticle/findTeam?area=&avgLevel=${avgLevel}&searchKeyword=${searchKeyword}"
                       class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${empty area ? 'bg-green-500 text-white' : ''}">
                        전체
                    </a>

                    <!-- 지역 리스트 -->
                    <c:forEach var="region" items="${['서울','경기','강원','인천','대전','세종','충북','충남','대구','경북','경남','부산','광주','전북','울산','전남','제주']}">
                        <a href="/usr/teamArticle/findTeam?area=${region}&avgLevel=${avgLevel}&searchKeyword=${searchKeyword}"
                           class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${region == area ? 'bg-green-500 text-white' : ''}">
                                ${region}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- ✅ 레벨 필터링 -->
            <div>
                <h2 class="font-bold mb-2">레벨</h2>
                <div class="flex flex-wrap gap-2">
                    <!-- 전체 레벨 -->
                    <a href="/usr/teamArticle/findTeam?area=${area}&avgLevel=&searchKeyword=${searchKeyword}"
                       class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${empty avgLevel ? 'bg-green-500 text-white' : ''}">
                        전체
                    </a>

                    <!-- 레벨 리스트 -->
                    <c:forEach var="levelOption" items="${['아마추어','루키','세미프로','프로']}">
                        <a href="/usr/teamArticle/findTeam?area=${area}&avgLevel=${levelOption}&searchKeyword=${searchKeyword}"
                           class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${levelOption == avgLevel ? 'bg-green-500 text-white' : ''}">
                                ${levelOption}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </aside>


        <!-- 팀 리스트 -->
        <section class="flex-1 p-28">
            <c:forEach var="team" items="${teamArticles}">
                <div class="border border-green-700 rounded-lg p-4 mb-4 flex items-center justify-between hover:shadow-md">
                    <div class="flex items-center gap-4">
                        <div class="w-2 h-6 bg-green-500 rounded-r"></div>
                        <div>
                            <div class="font-bold text-lg">
                                <a href="/usr/teamArticle/findTeam_detail?id=${team.id}" class="hover:underline hover:text-green-600">
                                        ${team.title}
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="text-sm text-right text-gray-500 whitespace-nowrap flex gap-4">
                        <div>${team.teamName}</div>
                        <div>${team.extra__writer}</div>
                        <div>${team.avgLevelName}</div>
                    </div>
                </div>
            </c:forEach>
            <div class="text-right mb-4">
                <a href="/usr/teamArticle/findTeam_write"
                   class="inline-block bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-full shadow-md">
                    ✏ 글쓰기
                </a>
            </div>
            <!-- ✅ 페이지네이션 -->
            <c:set var="groupSize" value="5" />
            <fmt:parseNumber value="${(page - 1) div groupSize}" integerOnly="true" var="currentGroup" />
            <fmt:parseNumber value="${currentGroup * groupSize + 1}" integerOnly="true" var="groupStart" />
            <fmt:parseNumber value="${groupStart + groupSize - 1}" integerOnly="true" var="groupEnd" />

            <c:if test="${groupEnd > pagesCount}">
                <c:set var="groupEnd" value="${pagesCount}" />
            </c:if>

            <div class="mt-6 flex justify-center space-x-2">
                <c:if test="${groupStart > 1}">
                    <a href="/usr/teamArticle/findTeam?page=${groupStart - 1}&area=${area}&avgLevel=${avgLevel}&searchKeyword=${searchKeyword}"
                       class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">&lt;</a>
                </c:if>

                <c:forEach begin="${groupStart}" end="${groupEnd}" var="i">
                    <a href="/usr/teamArticle/findTeam?page=${i}&area=${area}&avgLevel=${avgLevel}&searchKeyword=${searchKeyword}"
                       class="px-3 py-1 border rounded-full ${i == page ? 'bg-green-600 text-white' : 'bg-white text-gray-800 hover:bg-gray-200'}">
                            ${i}
                    </a>
                </c:forEach>

                <c:if test="${groupEnd < pagesCount}">
                    <a href="/usr/teamArticle/findTeam?page=${groupEnd + 1}&area=${area}&avgLevel=${avgLevel}&searchKeyword=${searchKeyword}"
                       class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">&gt;</a>
                </c:if>
            </div>
        </section>
    </div>
</div>
</body>
</html>
