<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>마이페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white min-h-screen p-10">
<div class="px-[150px]">
<!-- 헤더 -->
  <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">
    로고
  </a>


<!-- 메인 컨테이너 -->
<div class="flex gap-8">

  <!-- 좌측: 프로필 -->
  <div class="w-1/3 border rounded-xl p-6 flex flex-col items-center gap-3">
    <img src="${profileImg}" class="w-32 h-32 rounded-full object-cover" />
    <div class="text-xl font-semibold">${nickName}</div>
    <div class="text-red-500 text-lg">❤️ </div>
    <div class="text-3xl">😊</div>

    <div class="flex justify-between w-full text-center mt-4">
      <a href="#" class="text-green-600 font-semibold flex-1">매너온도</a>
      <a href="#" class="text-green-600 font-semibold flex-1">쪽지</a>
    </div>
  </div>

  <!-- 우측: 최근 경기 및 정보 -->
  <div class="w-2/3 space-y-6">

    <!-- 최근 경기 -->
    <div>
      <div class="text-lg font-bold mb-2">최근게임</div>
      <div class="flex gap-4">
        <c:forEach var="game" items="ㅋㅋ" end="2">
          <div class="w-28">
            <img src="${profileImg}" class="rounded w-full h-20 object-cover" />

            <div class="text-xs text-gray-500">레벨: ${rank}</div>

          </div>
        </c:forEach>
      </div>
    </div>

    <!-- 팀/레벨 -->
    <div class="flex gap-4">
      <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">팀: 없음</div>
      <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">레벨: ${rank}</div>
    </div>

    <!-- 자기소개 -->
    <div>
      <div class="font-bold mb-1">자기소개</div>
      <textarea class="w-full h-24 border rounded p-2">ㅌㅌㅌㅌ</textarea>
    </div>

    <!-- 수정 버튼 -->
    <div class="text-right">
      <a href="/usr/member/modify" class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-full">
        회원정보 수정
      </a>
    </div>

  </div>
</div>
</div>
</body>
</html>
