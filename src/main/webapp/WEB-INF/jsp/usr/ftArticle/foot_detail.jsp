<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="org.example.util.RankUtil" %>
<html>
<head>
    <title>뫣8치 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<header class="flex items-center justify-between px-5 border-b border-gray-300 h-24 overflow-hidden">
    <!-- 왼쪽 로고 -->
    <a href="/usr/home/main" class="inline-block h-full">
        <img src="/img/Logo_V.png" alt="로고" class="h-full object-contain" />
    </a>
</header>

<div class="max-w-3xl mx-auto bg-white shadow-lg rounded-lg p-6 mt-8">
    <!-- 경기장 이미지 -->
    <!-- 경기장 이미지 -->
    <img src="${ftArticle.img}" alt="경기장" class="w-full h-64 object-cover rounded mb-4" />

    <!-- 경기 정보 카드 -->
    <div class="bg-gray-100 rounded-lg p-4 mb-4 text-sm text-gray-700 space-y-1 shadow">
        <div>
            <span class="font-semibold text-green-700">경기장: </span>${ftArticle.title}
        </div>
        <div>
            <span class="font-semibold text-green-700">경기 일시: </span>${ftArticle.playDate}
        </div>
        <div>
            <span class="font-semibold text-green-700">주소: </span>${ftArticle.address}
        </div>
    </div>


    <!-- ❌ 날씨 정보 -->
    <c:choose>
        <c:when test="${not empty weatherList}">
            <div class="flex gap-4 bg-green-600 justify-center text-center text-sm mt-2 rounded text-white py-2">
                <c:forEach var="weather" items="${weatherList}">
                    <div class="w-16">
                        <div>
                            <fmt:parseDate var="weatherTime" value="${weather.time}" pattern="yyyy-MM-dd HH:mm:ss" />
                            <fmt:formatDate value="${weatherTime}" pattern="HH시" />
                        </div>
                        <div><img src="${weather.iconUrl}" style="width: 40px;" /></div>
                        <div>${weather.temp}°C</div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-sm text-gray-500 text-center py-3">
                날씨 정보는 5일부터 확인 가능합니다.
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 평균 레벨 -->
    <div class="text-lg font-semibold text-green-600 mt-4">
        평균레벨 <span class="text-black">${ftArticle.avgLevelName}</span>
    </div>

    <!-- 참가자 목록 -->
    <div class="mt-6">
        <h2 class="text-md font-bold text-green-600 mb-2">참가자 목록</h2>
        <c:forEach var="player" items="${participants}">
            <c:choose>
                <c:when test="${pastMatch}">
                    <form method="post" action="/usr/member/updatePlayerInfo" class="flex flex-wrap items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-2 justify-between">
                        <input type="hidden" name="memberId" value="${player.id}" />
                        <input type="hidden" name="id" value="${ftArticle.id}" />
                        <input type="hidden" name="boardId" value="${boardId}" />
                        <div class="flex items-center gap-2">
                            <c:choose>
                                <c:when test="${rq.loginedMember.nickName == player.nickName}">
                                    <a href="/usr/home/myPage" class="font-semibold text-green-800 hover:underline">${player.nickName}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/usr/home/yourPage?nickName=${player.nickName}" class="font-semibold text-green-800 hover:underline">${player.nickName}</a>
                                </c:otherwise>
                            </c:choose>
                            <span class="text-sm">| ${player.rankName}</span>
                            <span class="text-sm">| 메너온도: ${player.mannerEmoji}</span>
                        </div>
                        <select name="rankName" class="border border-gray-300 rounded px-2 py-1 text-sm">
                            <option value="루키1">루키1</option>
                            <option value="루키2">루키2</option>
                            <option value="루키3">루키3</option>
                            <option value="아마추어1">아마추어1</option>
                            <option value="아마추어2">아마추어2</option>
                            <option value="아마추어3">아마추어3</option>
                            <option value="세미프로1">세미프로1</option>
                            <option value="세미프로2">세미프로2</option>
                            <option value="세미프로3">세미프로3</option>
                            <option value="프로1">프로1</option>
                            <option value="프로2">프로2</option>
                            <option value="프로3">프로3</option>
                        </select>
                        <select name="mannerEmoji" class="border border-gray-300 rounded px-2 py-1 text-sm">
                            <option value="😍">😍</option>
                            <option value="😊">😊</option>
                            <option value="😐">😐</option>
                            <option value="😡">😡</option>
                        </select>
                        <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-sm">평가하기</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="flex items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-2 justify-start">
                        <span class="font-semibold text-green-800">${player.nickName}</span>
                        <span class="text-sm text-gray-500">| 랭크: ${player.rankName}</span>
                        <span class="text-sm text-gray-500">| 메너: ${player.mannerEmoji}</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <!-- 참가하기 버튼 -->
    <div class="mt-4 text-center">
        <c:choose>
            <c:when test="${pastMatch}">
                <div class="text-gray-400 text-sm">종료된 경기입니다. 참가할 수 없습니다.</div>
            </c:when>
            <c:when test="${isAlreadyJoined}">
                <form action="/usr/ftArticle/cancelJoin" method="post" onsubmit="return confirm('정말 참가를 취소하시겠습니까?')">
                    <input type="hidden" name="id" value="${ftArticle.id}" />
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-full">참가 취소하기</button>
                </form>
            </c:when>
            <c:otherwise>
                <form action="/usr/ftArticle/joinMatch" method="post" onsubmit="return validatePositionSelection(this)">
                    <input type="hidden" name="id" value="${ftArticle.id}" />
                    <input type="hidden" name="position" id="selectedPosition" />
                    <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full">⚽ 참가하기</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 주의사항 -->
    <div class="mt-8 text-sm text-gray-700">
        <h3 class="font-bold mb-2">뫣8치 진행 방식</h3>
        <ul class="list-disc ml-6 space-y-1">
            <li>맵은 기본 사이드라인에서 킥인</li>
            <li>고르키퍼에 대한 백패스는 손으로 잡으면 안 되요</li>
            <li>심한 요식 및 헛한 플레이 까지</li>
            <li>음료/간식 개인 음료로 준비하세요</li>
            <li>출석체크 후 복귀 보호드립니다</li>
            <li>지각하면 팀원들에게 비의히 있어요</li>
            <li>인원 미달 시 실력 맞게 다른 팀과 석을 수 있어요</li>
        </ul>
    </div>
</div>


</body>
</html>
