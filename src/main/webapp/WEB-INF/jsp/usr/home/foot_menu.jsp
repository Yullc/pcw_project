
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<<<<<<< HEAD
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
=======
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
>>>>>>> 4dff9505c4d7b88fb7aaef0efd99447bbfaa3009

</head>

<body class="h-screen flex flex-col">
<div class="px-[150px]">
<<<<<<< HEAD
    <header class="flex items-center justify-between p-5 border-b border-gray-300">
        <!-- 왼쪽 로고 -->
        <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">
            로고
        </a>


        <form action="/usr/home/foot_menu" method="post" class="flex justify-center w-full">
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
            <input type="hidden" name="playDate" value="${playDate}" />
        </form>


        <!-- 오른쪽 메뉴 -->
        <div class="flex items-center gap-6 whitespace-nowrap">
            <a href="/usr/home/findMercenary" class="text-sm text-black hover:text-green-600">용병 구하기</a>
            <a href="/usr/home/findTeam" class="text-sm text-black hover:text-green-600">팀 구하기</a>
            <!-- 로그아웃 버튼 추가 -->
            <a href="/usr/member/doLogout" class="text-sm text-black hover:text-red-500">로그아웃</a>

            <a href="/usr/home/myPage" class="block w-10 h-10">
                <img src="${profileImg}" alt="profile"
                     class="w-full h-full rounded-full object-cover" />
            </a>
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
                                <div>${ftArticle.playDate}</div>
                                <div class="text-xs text-gray-500">${ftArticle.address}</div>
                                <div class="text-xs text-gray-500">${ftArticle.avgLevel}</div>
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
            <a href="/usr/home/foot_menu?page=${groupStart - 1}&area=${area}"
               class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
                &lt;
            </a>
        </c:if>

        <!-- 현재 그룹의 페이지 번호 출력 -->
        <c:forEach begin="${groupStart}" end="${groupEnd}" var="i">
            <a href="/usr/home/foot_menu?page=${i}&area=${area}"
               class="px-3 py-1 border rounded-full
              ${i == page ? 'bg-green-600 text-white' : 'bg-white text-gray-800 hover:bg-gray-200'}">
                    ${i}
            </a>
        </c:forEach>

        <!-- 다음 그룹 버튼 -->
        <c:if test="${groupEnd < pagesCount}">
            <a href="/usr/home/foot_menu?page=${groupEnd + 1}&area=${area}"
               class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
                &gt;
            </a>
        </c:if>

    </div>


</body>
</html>
=======
  <header class="flex items-center justify-between p-5 border-b border-gray-300">
    <!-- 왼쪽 로고 -->
    <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">
      로고
    </a>


    <form action="/usr/home/foot_menu" method="post" class="flex justify-center w-full">
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
      <input type="hidden" name="playDate" value="${playDate}" />
    </form>


    <!-- 오른쪽 메뉴 -->
    <div class="flex items-center gap-6 whitespace-nowrap">
      <a href="/usr/home/findMercenary" class="text-sm text-black hover:text-green-600">용병 구하기</a>
      <a href="/usr/home/findTeam" class="text-sm text-black hover:text-green-600">팀 구하기</a>

      <a href="/usr/home/myPage" class="block w-10 h-10">
        <img src="${profileImg}" alt="profile"
             class="w-full h-full rounded-full object-cover" />
      </a>
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
                <div>${ftArticle.playDate}</div>
                <div class="text-xs text-gray-500">${ftArticle.address}</div>
                <div class="text-xs text-gray-500">${ftArticle.avgLevel}</div>
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
      <a href="/usr/home/foot_menu?page=${groupStart - 1}&area=${area}"
         class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
        &lt;
      </a>
    </c:if>

    <!-- 현재 그룹의 페이지 번호 출력 -->
    <c:forEach begin="${groupStart}" end="${groupEnd}" var="i">
      <a href="/usr/home/foot_menu?page=${i}&area=${area}"
         class="px-3 py-1 border rounded-full
              ${i == page ? 'bg-green-600 text-white' : 'bg-white text-gray-800 hover:bg-gray-200'}">
          ${i}
      </a>
    </c:forEach>

    <!-- 다음 그룹 버튼 -->
    <c:if test="${groupEnd < pagesCount}">
      <a href="/usr/home/foot_menu?page=${groupEnd + 1}&area=${area}"
         class="px-3 py-1 border rounded-full bg-white text-gray-800 hover:bg-gray-200">
        &gt;
      </a>
    </c:if>

  </div>


</body>
</html>
>>>>>>> 4dff9505c4d7b88fb7aaef0efd99447bbfaa3009
