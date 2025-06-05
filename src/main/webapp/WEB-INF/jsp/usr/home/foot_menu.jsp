<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>풋살 매칭 UI (Tailwind)</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    /* 가로 스크롤을 마우스 휠로 전환 */
    #scrollWrapper {
      scroll-snap-type: x mandatory;
    }
    .snap {
      scroll-snap-align: start;
    }
  </style>

</head>

<body class="h-screen flex flex-col">
<div class="px-[150px]">
  <header class="flex items-center justify-between p-5 border-b border-gray-300">
    <!-- 왼쪽 로고 -->
    <div class="text-2xl font-bold text-green-700">로고</div>

    <!-- 중앙 검색창 -->
    <div class="flex-1 flex justify-center">
      <div class="relative w-64">
        <input type="text" placeholder="검색..."
               class="w-full pl-4 pr-10 py-2 rounded-full border border-green-500 focus:outline-none focus:ring-2 focus:ring-green-300" />
        <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500">
        🔍
      </span>
      </div>
    </div>

    <!-- 오른쪽 메뉴 -->
    <div class="flex items-center gap-4">
      <span>용병 구하기</span>
      <span>팀 구하기</span>
      <img src="/img/pcw.jpeg" alt="profile" class="w-10 h-10 rounded-full">
    </div>
  </header>

<div class="flex flex-1 overflow-hidden">

  <aside class="w-56 p-5 border-r border-gray-300 space-y-6 overflow-y-auto">
    <!-- 지역 필터 -->
    <div>
      <h2 class="font-bold mb-2">지역</h2>
      <div class="flex flex-wrap gap-2">
        <c:forEach var="region" items="${['서울','경기','강원','인천','대전','세종','충북','충남','대구','경북','경남','부산','광주','전북','울산','전남','제주']}">
          <a href="/usr/home/foot_menu?area=${region}&avgLevel=${avgLevel}&playDate=${playDate}"
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
          <a href="/usr/home/foot_menu?area=${area}&avgLevel=${levelOption}&playDate=${playDate}"
             class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200 ${levelOption == avgLevel ? 'bg-green-500 text-white' : ''}">
              ${levelOption}
          </a>
        </c:forEach>
      </div>
    </div>



    <!-- 달력용 CSS 링크 -->
    <link rel="stylesheet" href="/css/calender.css">

    <!-- ========== 달력 컴포넌트 삽입 ========== -->
    <div class="calendar-container">
      <!-- 1) 달력 헤더 -->
      <div class="calendar-header">
        <button type="button" id="prevMonthBtn">&lt;</button>
        <div class="month-year" id="monthYearLabel">2025년 12월</div>
        <button type="button" id="nextMonthBtn">&gt;</button>
      </div>

      <!-- 2) 요일 이름 행 -->
      <div class="calendar-weekdays">
        <div class="sun">일</div>
        <div>월</div>
        <div>화</div>
        <div>수</div>
        <div>목</div>
        <div>금</div>
        <div class="sat">토</div>
      </div>

      <!-- 3) 날짜(일) 그리드 -->
      <div class="calendar-dates" id="datesGrid">
        <!-- JavaScript로 동적으로 채워집니다 -->
      </div>

      <!-- 4) 선택된 날짜 표시 -->
      <div class="selected-info" id="selectedInfo">
        선택된 날짜: <span id="selectedDateDisplay">없음</span>
      </div>
    </div>

  </aside>
  <script src="/js/calender.js"></script>

  <main class="scrollWrapper flex-1 overflow-x-auto p-5">
    <div class="px-[100px]">
    <div class="grid grid-cols-4 grid-rows-4 gap-5 w-[1000px] min-w-max">
      <c:forEach var="ftArticle" items="${ftArticles}">
        <div class="border border-gray-300 rounded-lg overflow-hidden flex flex-col w-48">
          <img src="${ftArticle.img}" alt="경기장" class="w-full h-32 object-cover" />
          <div class="p-2 text-sm">
            <div class="font-semibold">${ftArticle.stadiumName}</div>
            <div>${ftArticle.area}</div>
            <div class="text-xs text-gray-500">${ftArticle.address}</div>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty ftArticles}">
        <div class="text-gray-500 text-center col-span-4 row-span-4">경기장 정보가 없습니다.</div>
      </c:if>
    </div>
  </main>

</div>

<script>
  function scrollHorizontally(e) {
    const wrapper = document.getElementById('scrollWrapper');
    if (e.deltaY !== 0) {
      e.preventDefault();
      wrapper.scrollLeft += e.deltaY;
    }
  }

</script>
</body>
</html>
<!-- ✅ 페이지네이션 -->
<div class="mt-6 flex justify-center space-x-2">
  <c:forEach begin="1" end="${pagesCount}" var="i">
    <a href="/usr/home/foot_menu?page=${i}&area=${area}"
       class="px-3 py-1 border rounded-full
                  <c:if test='${i == page}'>bg-green-600 text-white</c:if>
                  <c:if test='${i != page}'>bg-white text-gray-800 hover:bg-gray-200</c:if>">
        ${i}
    </a>
  </c:forEach>
</div>