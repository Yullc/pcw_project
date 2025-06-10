<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.example.util.RankUtil" %>

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
      <div class="text-red-500 text-lg">❤️</div>
      <div class="text-3xl">${mannerEmoji}</div>

      <!-- 쪽지 버튼 -->
      <div class="flex justify-between w-full text-center mt-4">
        <a href="#" onclick="toggleModal('inboxModal')" class="text-green-600 font-semibold flex-1">📥 받은 쪽지함</a>
        <a href="#" onclick="toggleModal('outboxModal')" class="text-green-600 font-semibold flex-1">📤 보낸 쪽지함</a>
      </div>
    </div>

    <!-- 우측: 최근 경기 및 정보 -->
    <div class="w-2/3 space-y-6">

      <!-- 최근 경기 -->
      <div>
        <h2 class="text-md font-bold text-green-600">최근 참가한 경기</h2>
        <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
          <c:forEach var="game" items="${recentGames}">
            <a href="/usr/article/foot_detail?id=${game.id}" class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
              <img src="${game.img}" alt="경기장 이미지" class="w-full h-28 object-cover rounded-t-lg" />
              <div class="p-2 text-sm">
                <div class="font-semibold">${game.stadium}</div>
                <div class="text-gray-500">${game.playDate}</div>
                <div class="text-gray-700">${game.title}</div>
              </div>
            </a>
          </c:forEach>
        </div>
        <c:if test="${empty recentGames}">
          <div class="text-sm text-gray-400">참가한 경기가 없습니다.</div>
        </c:if>
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

      <!-- 수정 버튼 -->
      <div class="text-right">
        <a href="/usr/member/modify?id=${id}" class="bg-green-600 hover:bg-green-500 text-white font-semibold py-2 px-4 rounded-full">
          회원정보 수정
        </a>
      </div>
    </div>
  </div>
</div>

<!-- 받은 쪽지함 모달 -->
<div id="inboxModal" class="fixed inset-0 hidden bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 p-4">
    <div class="flex justify-between items-center mb-2">
      <h2 class="text-lg font-bold text-blue-600">📥 받은 쪽지함</h2>
      <button onclick="toggleModal('inboxModal')" class="text-gray-500 hover:text-black">✖</button>
    </div>
    <c:forEach var="msg" items="${receivedMessages}">
      <div class="border-t py-2">
        <div class="text-sm text-gray-600">보낸 사람: ${msg.senderNickname}</div>
        <div class="text-gray-800">${msg.content}</div>
        <div class="text-xs text-right text-gray-400">${msg.sendDate}</div>
      </div>
    </c:forEach>
    <c:if test="${empty receivedMessages}">
      <div class="text-center text-gray-400">받은 쪽지가 없습니다.</div>
    </c:if>
  </div>
</div>

<!-- 보낸 쪽지함 모달 -->
<div id="outboxModal" class="fixed inset-0 hidden bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 p-4">
    <div class="flex justify-between items-center mb-2">
      <h2 class="text-lg font-bold text-green-600">📤 보낸 쪽지함</h2>
      <button onclick="toggleModal('outboxModal')" class="text-gray-500 hover:text-black">✖</button>
    </div>
    <c:forEach var="msg" items="${sentMessages}">
      <div class="border-t py-2">
        <div class="text-sm text-gray-600">받는 사람: ${msg.receiverNickname}</div>
        <div class="text-gray-800">${msg.content}</div>
        <div class="text-xs text-right text-gray-400">${msg.sendDate}</div>
      </div>
    </c:forEach>
    <c:if test="${empty sentMessages}">
      <div class="text-center text-gray-400">보낸 쪽지가 없습니다.</div>
    </c:if>
  </div>
</div>

<script>
  function toggleModal(id) {
    const modal = document.getElementById(id);
    modal.classList.toggle("hidden");
  }
</script>
</body>
</html>
