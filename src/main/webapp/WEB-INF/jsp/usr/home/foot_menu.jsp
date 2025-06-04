<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>풋살 매칭 UI (Tailwind)</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="h-screen flex flex-col">
<header class="flex items-center justify-between p-5 border-b border-gray-300">
  <div class="text-2xl font-bold text-green-700">로고</div>
  <div class="flex-1 mx-5 relative">
    <input type="text" placeholder="검색..." class="w-full pl-4 pr-10 py-2 rounded-full border border-gray-300">
    <span class="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500">🔍</span>
  </div>
  <div class="flex items-center gap-4">
    <span>용병 구하기</span>
    <span>팀 구하기</span>
    <img src="/img/pcw.jpeg" alt="profile" class="w-10 h-10 rounded-full">
  </div>
</header>

<div class="flex flex-1 overflow-hidden">
  <aside class="w-56 p-5 border-r border-gray-300 space-y-6 overflow-y-auto">
    <div>
      <h2 class="font-bold mb-2">지역</h2>
      <div class="flex flex-wrap gap-2">
        <!-- 지역 버튼 리스트 -->
        <c:forEach var="region" items="${['서울','경기','강원','인천','대전','세종','충북','충남','대구','경북','경남','부산','광주','전북','울산','전남','제주']}">
          <a href="/usr/home/foot_menu?area=${region}"
             class="border border-gray-300 px-3 py-1 rounded-full hover:bg-green-200">
              ${region}
          </a>
        </c:forEach>

      </div>
    </div>
    <div>
      <h2 class="font-bold mb-2">레벨</h2>
      <div class="flex flex-wrap gap-2">
        <c:forEach var="level" items="${['루키','아마추어','세미프로','프로']}">
          <button class="border border-gray-300 px-3 py-1 rounded-full">${level}</button>
        </c:forEach>
      </div>
    </div>
  </aside>

  <main class="flex-1 overflow-x-auto p-5">
    <div class="flex gap-5 w-max">
      <c:forEach var="ftArticle" items="${ftArticles }">
        <div class="w-48 flex-shrink-0 border border-gray-300 rounded-lg overflow-hidden flex flex-col">
          <img src="${ftArticle.img }" alt="경기장" class="w-full h-32 object-cover" />
          <div class="p-2 text-sm">
            <div class="font-semibold">${ftArticle.stadiumName }</div>
            <div>${ftArticle.area}</div>
            <div class="text-xs text-gray-500">${ftArticle.address }</div>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty ftArticles}">
        <div class="text-gray-500 text-center">경기장 정보가 없습니다.</div>
      </c:if>
    </div>
  </main>
</div>
</body>
</html>
