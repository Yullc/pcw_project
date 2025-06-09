<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
  <title>매치 상세</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="max-w-3xl mx-auto bg-white shadow-lg rounded-lg p-6 mt-8">
  <!-- 경기장 이미지 -->
  <img src="${ftArticle.img}" alt="경기장" class="w-full h-64 object-cover rounded mb-4" />

  <!-- 날씨 정보 -->
  <div class="flex gap-4 justify-center text-center text-sm mt-2">
    <c:forEach var="weather" items="${weatherList}">
      <div>
        <!-- 시간 -->
        <div>
          <fmt:parseDate var="weatherTime" value="${weather.time}" pattern="yyyy-MM-dd HH:mm:ss" />
          <fmt:formatDate value="${weatherTime}" pattern="HH시" />
        </div>

        <!-- 아이콘 -->
        <div><img src="${weather.iconUrl}" style="width: 40px;" /></div>

        <!-- 온도 -->
        <div>${weather.temp}°C</div>

        <!-- 상태 (선택사항: description도 출력하고 싶다면 여기에 추가) -->
      </div>
    </c:forEach>
  </div>

  <!-- 평균 레벨 -->
  <div class="text-lg font-semibold text-green-600">평균레벨 <span class="text-black">${ftArticle.avgLevel}</span></div>


  <!-- 참가 선수 -->
  <div class="mt-6">
    <h2 class="text-md font-bold text-green-600 mb-2">참가선수</h2>
    <c:forEach var="player" items="${participants}">
      <div class="flex items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-1">
        <span class="font-semibold text-green-800">${player.nickName}</span>
        <span class="text-sm">| ${player.rank}</span>
        <span class="text-sm">| 매너온도: ${player.manner}</span>
        <span>😊</span>
      </div>
    </c:forEach>
  </div>

  <!-- 참가하기 버튼 -->
  <div class="mt-4 text-center">
    <c:choose>
      <c:when test="${isAlreadyJoined}">
        <button class="bg-gray-400 text-white px-6 py-2 rounded-full cursor-not-allowed" disabled>
          ✅ 이미 참가했어요
        </button>
      </c:when>
      <c:otherwise>
        <form action="/usr/article/joinMatch" method="post">
          <input type="hidden" name="id" value="${ftArticle.id}" />
          <p>ftArticle.id: ${ftArticle.id}</p>
          <p style="color: red;">디버그: ftArticle.id = ${ftArticle.id}</p>

          <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full">
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