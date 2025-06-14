<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="org.example.util.RankUtil" %>
<html>
<head>
  <title>매치 상세</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">
<!-- 헤더 -->
<a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">
  로고
</a>

<div class="max-w-3xl mx-auto bg-white shadow-lg rounded-lg p-6 mt-8">
  <!-- 경기장 이미지 -->
  <img src="${scArticle.img}" alt="경기장" class="w-full h-64 object-cover rounded mb-4" />

  <!-- 날씨 정보 -->
  <div class="flex gap-4 bg-green-600 justify-center text-center text-sm mt-2">
    <c:forEach var="weather" items="${weatherList}">
      <div>
        <div>
          <fmt:parseDate var="weatherTime" value="${weather.time}" pattern="yyyy-MM-dd HH:mm:ss" />
          <fmt:formatDate value="${weatherTime}" pattern="HH시" />
        </div>
        <div><img src="${weather.iconUrl}" style="width: 40px;" /></div>
        <div>${weather.temp}°C</div>
      </div>
    </c:forEach>
  </div>

  <!-- 평균 레벨 -->
  <div class="text-lg font-semibold text-green-600 mt-4">
    평균레벨 <span class="text-black">${scArticle.avgLevelName}</span>
  </div>

  <!-- 참가자 목록 -->
  <div class="mt-6">
    <h2 class="text-md font-bold text-green-600 mb-2">참가자 목록</h2>
    <c:forEach var="player" items="${participants}">
      <form method="post" action="/usr/member/updatePlayerInfo"
            class="flex flex-wrap items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-2 justify-between">

        <input type="hidden" name="memberId" value="${player.id}" />
        <input type="hidden" name="id" value="${scArticle.id}" />


        <div class="flex items-center gap-2">
          <span class="font-semibold text-green-800">${player.nickName}</span>
          <span class="text-sm">| ${player.rankName}</span>
          <span class="text-sm">| 매너온도: ${player.mannerEmoji}</span>
          <span class="text-sm">| 포지션: ${player.position}</span>
        </div>

        <c:choose>

          <c:when test="${pastMatch}">
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

            <button type="submit"
                    class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-sm">
              평가하기
            </button>
          </c:when>

          <c:otherwise>
            <select name="position" class="border border-blue-400 rounded px-2 py-1 text-sm">
              <option value="FW" ${player.position == 'FW' ? 'selected' : ''}>FW</option>
              <option value="MF" ${player.position == 'MF' ? 'selected' : ''}>MF</option>
              <option value="DF" ${player.position == 'DF' ? 'selected' : ''}>DF</option>
            </select>

            <button type="submit"
                    class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-sm">
              포지션 저장
            </button>
          </c:otherwise>
        </c:choose>
      </form>
    </c:forEach>
  </div>


  <!-- 참가하기 버튼 -->
  <div class="mt-4 text-center">
    <c:choose>
      <c:when test="${isAlreadyJoined}">
        <form action="/usr/scArticle/cancelJoin" method="post">
          <input type="hidden" name="id" value="${scArticle.id}" />
          <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-full">
            참가 취소
          </button>
        </form>
      </c:when>
      <c:otherwise>
        <form action="/usr/scArticle/joinMatch" method="post">
          <input type="hidden" name="id" value="${scArticle.id}" />
          <input type="hidden" name="position" id="positionInput" value="" />
          <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full" onclick="return validatePosition();">
            ⚽ 참가하기
          </button>
        </form>
      </c:otherwise>

    </c:choose>
  </div>

  <!-- 주의사항 -->
  <div class="mt-8 text-sm text-gray-700">
    <h3 class="font-bold mb-2">매치 진행 방식</h3>
    <ul class="list-disc ml-6 space-y-1">
      <li>맵은 기본 사이드라인에서 킥인</li>
      <li>골키퍼에 대한 백패스는 손으로 잡으면 안 돼요</li>
      <li>심한 욕설 및 험한 플레이 금지</li>
      <li>음료/간식 개인 음료로 준비하세요</li>
      <li>출석체크 후 복귀 부탁드립니다</li>
      <li>지각하면 팀원들에게 불이익 있어요</li>
      <li>인원 미달 시 실력 맞게 다른 팀과 섞을 수 있어요</li>
    </ul>
  </div>
</div>

</body>
</html>
