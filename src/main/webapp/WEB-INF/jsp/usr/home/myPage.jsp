<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>마이페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white min-h-screen p-10">
<div class="px-[150px]">

  <!-- 헤더 -->
  <a href="/usr/home/main" class="text-2xl font-bold text-green-700 whitespace-nowrap">로고</a>

  <!-- 메인 컨테이너 -->
  <div class="flex gap-8">

    <!-- 좌측: 프로필 -->
    <div class="w-1/3 border rounded-xl p-6 flex flex-col items-center gap-3">
      <img src="${profileImg}" class="w-32 h-32 rounded-full object-cover" />
      <div class="text-xl font-semibold">${nickName}</div>

      <!-- 받은 좋아요 수만 보여주는 영역 -->
      <div class="text-gray-700 text-sm mt-2">
        👍 나의 좋아요 수: <span class="likeCount font-semibold">${likeCount}</span>
      </div>


      <div class="text-3xl">${mannerEmoji}</div>

      <!-- 쪽지 버튼 -->
      <div class="flex justify-between w-full text-center mt-4">
        <button onclick="toggleModal('writeModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">
          ✉️ 쪽지 보내기
        </button>
        <a href="#" onclick="toggleModal('inboxModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">
          📥 받은 쪽지함
        </a>
        <a href="#" onclick="toggleModal('outboxModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">
          📤 보낸 쪽지함
        </a>
      </div>

      <!-- 다음 경기 -->
      <div class="w-full mt-6">
        <h3 class="text-sm font-bold text-green-700 mb-2">🗓️ 나의 다음 경기</h3>
        <c:choose>
          <c:when test="${not empty nextMatch}">
            <a href="${nextMatch.type == '풋살' ? '/usr/ftArticle/foot_detail?id=' : '/usr/scArticle/soccer_detail?id='}${nextMatch.id}"
               class="w-48 block bg-white rounded-lg shadow-md hover:shadow-lg transition overflow-hidden">
              <img src="${nextMatch.img}" alt="경기장 이미지" class="w-full h-28 object-cover" />
              <div class="p-2 text-sm">
                <div class="font-semibold truncate">${nextMatch.stadium}</div>
                <div class="text-gray-500 text-xs">${nextMatch.playDate}</div>
                <div class="text-gray-700 text-sm truncate">${nextMatch.title}</div>
              </div>
            </a>
          </c:when>
          <c:otherwise>
            <div class="text-sm text-gray-400 text-center mt-2">다가오는 경기가 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- 우측: 최근 경기 및 정보 -->
    <div class="w-2/3 space-y-6">

      <!-- 최근 풋살 경기 -->
      <div>
        <h2 class="text-md font-bold text-green-700">최근 풋살 경기</h2>
        <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
          <c:forEach var="game" items="${recentGames}">
            <a href="/usr/ftArticle/foot_detail?id=${game.id}" class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
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

      <!-- 최근 축구 경기 -->
      <div class="mb-6">
        <h2 class="text-md font-bold text-green-700">최근 축구 경기</h2>
        <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
          <c:forEach var="game" items="${recentSoccerGames}">
            <a href="/usr/scArticle/soccer_detail?id=${game.id}" class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
              <img src="${game.img}" alt="경기장 이미지" class="w-full h-28 object-cover rounded-t-lg" />
              <div class="p-2 text-sm">
                <div class="font-semibold">${game.stadium}</div>
                <div class="text-gray-500">${game.playDate}</div>
                <div class="text-gray-700">${game.title}</div>
              </div>
            </a>
          </c:forEach>
        </div>
        <c:if test="${empty recentSoccerGames}">
          <div class="text-sm text-gray-400">참가한 축구 경기가 없습니다.</div>
        </c:if>
      </div>

      <!-- 팀 / 레벨 -->
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

<!-- 쪽지 작성 모달 -->
<div id="writeModal" class="fixed inset-0 hidden bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 p-6">
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-lg font-bold text-black-600">✉️ 쪽지 보내기</h2>
      <button onclick="toggleModal('writeModal')" class="text-gray-500 hover:text-black">✖</button>
    </div>
    <form action="/usr/message/doWriteMsg" method="post" class="space-y-3">
      <div>
        <label class="block text-sm font-semibold mb-1">받는 사람 닉네임</label>
        <input type="text" name="nickName" id="nickName" class="w-full border border-gray-400 rounded px-2 py-1" required />
      </div>
      <div>
        <label class="block text-sm font-semibold mb-1">내용</label>
        <textarea name="content" rows="4" class="w-full border border-gray-400 rounded px-2 py-1" required></textarea>
      </div>
      <div class="text-right">
        <button type="submit" class="bg-green-600 hover:bg-blue-700 text-white px-4 py-1 rounded">보내기</button>
      </div>
    </form>
  </div>
</div>

<!-- 받은 쪽지함 모달 -->
<div id="inboxModal" class="fixed inset-0 ${type == 'received' ? '' : 'hidden'} bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 max-h-[80vh] overflow-y-auto p-4">
    <div class="flex justify-between items-center mb-2 sticky top-0 bg-white z-10">
      <h2 class="text-lg font-bold text-black-600">📥 받은 쪽지함</h2>
      <div class="flex gap-2">
        <button onclick="toggleModal('inboxModal')" class="text-gray-500 hover:text-black text-lg px-2">✖</button>
      </div>
    </div>
    <c:forEach var="msg" items="${receivedMessages}">
      <div class="border-t py-2">
        <div class="text-sm text-gray-600">보낸 사람: ${msg.senderNickname}</div>
        <div class="text-gray-800">${msg.content}</div>
        <div class="text-xs text-right text-gray-400">${msg.sendDate}</div>

        <!-- 신청 메시지일 경우만 버튼 표시 -->
        <c:if test="${fn:contains(msg.content, '에 지원 합니다!')}">
          <form action="/usr/team/handleJoinRequest" method="post" class="flex gap-2 mt-2">
            <input type="hidden" name="teamId" value="${msg.teamId}" />
            <input type="hidden" name="memberId" value="${msg.senderId}" />

            <button type="submit" name="action" value="accept" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-sm">
              수락
            </button>
            <button type="submit" name="action" value="reject" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm">
              거절
            </button>
          </form>
        </c:if>
      </div>
    </c:forEach>


  </div>
</div>

<!-- 보낸 쪽지함 모달 -->
<div id="outboxModal" class="fixed inset-0 ${type == 'sent' ? '' : 'hidden'} bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 max-h-[80vh] overflow-y-auto p-4">
    <div class="flex justify-between items-center mb-2 sticky top-0 bg-white z-10">
      <h2 class="text-lg font-bold text-black-600">📤 보낸 쪽지함</h2>
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

<!-- 스크립트: 모달 토글 -->
<script>
  function toggleModal(id) {
    document.getElementById(id).classList.toggle("hidden");
  }
</script>

</body>
</html>
