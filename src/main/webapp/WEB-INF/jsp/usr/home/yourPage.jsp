<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${nickName}님의 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white min-h-screen p-10">
<div class="px-[150px]">

    <!-- 헤더 -->
    <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap mb-6 block">로고</a>

    <!-- 메인 컨테이너 -->
    <div class="flex gap-8">

        <!-- 좌측: 프로필 -->
        <div class="w-1/3 border rounded-xl p-6 flex flex-col items-center gap-3">
            <img src="${profileImg}" class="w-32 h-32 rounded-full object-cover border-4 " alt="프로필 이미지" />
            <div class="text-xl font-semibold">${nickName}</div>
            <div class="text-red-500 text-lg">❤️</div>
            <div class="text-3xl">${mannerEmoji}</div>
        </div>

        <!-- 우측: 최근 경기 및 정보 -->
        <div class="w-2/3 space-y-6">

            <!-- 최근 풋살 경기 -->
            <div>
                <h2 class="text-md font-bold text-green-600">최근 풋살 경기</h2>
                <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
                    <c:forEach var="game" items="${recentGames}">
                        <div class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md">
                            <img src="${game.img}" alt="경기장 이미지" class="w-full h-28 object-cover rounded-t-lg" />
                            <div class="p-2 text-sm">
                                <div class="font-semibold">${game.stadium}</div>
                                <div class="text-gray-500">${game.playDate}</div>
                                <div class="text-gray-700">${game.title}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty recentGames}">
                        <div class="text-sm text-gray-400">참가한 경기가 없습니다.</div>
                    </c:if>
                </div>
            </div>

            <!-- 최근 축구 경기 -->
            <div>
                <h2 class="text-md font-bold text-green-600">최근 축구 경기</h2>
                <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
                    <c:forEach var="game" items="${recentSoccerGames}">
                        <div class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md">
                            <img src="${game.img}" alt="경기장 이미지" class="w-full h-28 object-cover rounded-t-lg" />
                            <div class="p-2 text-sm">
                                <div class="font-semibold">${game.stadium}</div>
                                <div class="text-gray-500">${game.playDate}</div>
                                <div class="text-gray-700">${game.title}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty recentSoccerGames}">
                        <div class="text-sm text-gray-400">참가한 축구 경기가 없습니다.</div>
                    </c:if>
                </div>
            </div>

            <!-- 팀/레벨 -->
            <div class="flex gap-4">
                <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">팀: ${teamNm}</div>
                <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">레벨: ${rank}</div>
            </div>

            <!-- 자기소개 -->
            <div>
                <div class="font-bold mb-1">자기소개</div>
                <textarea class="w-full h-24 border rounded p-2" readonly>${intro}</textarea>
            </div>
        </div>
    </div>
</div>
</body>
</html>