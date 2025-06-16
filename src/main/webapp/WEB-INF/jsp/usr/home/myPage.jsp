<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="link" value="/some/path">
  <c:param name="nickName" value="${nickName}" />
</c:url>





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
        <button onclick="toggleModal('writeModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">
          ✉️ 쪽지 보내기
        </button>
        <a href="#" onclick="toggleModal('inboxModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">📥 받은 쪽지함</a>
        <a href="#" onclick="toggleModal('outboxModal')" class="text-black-600 hover:text-red-500 font-semibold flex-1">📤 보낸 쪽지함</a>
      </div>
    </div>

    <!-- 우측: 최근 경기 및 정보 -->
    <!-- 우측: 최근 경기 및 정보 -->
    <div class="w-2/3 space-y-6">

      <!-- ✅ 드롭다운: 풋살/축구 -->
      <div>
        <label for="matchType" class="text-md font-bold text-green-700 mr-2">최근 경기</label>
        <select id="matchType" onchange="toggleMatchList()" class="border border-gray-300 rounded px-2 py-1 text-sm">
          <option value="futsal">풋살</option>
          <option value="football">축구</option>
        </select>
      </div>

      <!-- ✅ 풋살 경기 -->
      <div id="futsalMatches">
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
          <div class="text-sm text-gray-400">참가한 풋살 경기가 없습니다.</div>
        </c:if>
      </div>

      <!-- ✅ 축구 경기 -->
      <div id="footballMatches" class="hidden">
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

      <!-- ✅ 팀/레벨 -->
      <div class="flex gap-4 items-center">
        <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold whitespace-nowrap">팀: ${teamNm}</div>
        <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold whitespace-nowrap">레벨: ${rank}</div>
      </div>

      <!-- ✅ 자기소개 -->
      <div>
        <div class="font-bold mb-1">자기소개</div>
        <textarea class="w-full h-24 border rounded p-2 text-sm" readonly>${intro}</textarea>
      </div>

      <!-- ✅ 수정 버튼 -->
      <div class="text-right">
        <a href="/usr/member/modify?id=${id}" class="bg-green-600 hover:bg-green-500 text-white font-semibold py-2 px-4 rounded-full">
          회원정보 수정
        </a>
      </div>
    </div>

    <!-- ✅ JS 스크립트 -->
    <script>
      function toggleMatchList() {
        const selected = document.getElementById("matchType").value;
        document.getElementById("futsalMatches").classList.add("hidden");
        document.getElementById("footballMatches").classList.add("hidden");

        if (selected === "futsal") {
          document.getElementById("futsalMatches").classList.remove("hidden");
        } else {
          document.getElementById("footballMatches").classList.remove("hidden");
        }
      }
    </script>


<!-- 쪽지 작성 모달 -->
<div id="writeModal" class="fixed inset-0 hidden bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 p-6">
    <!-- 헤더 -->
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-lg font-bold text-black-600">✉️ 쪽지 보내기</h2>
      <button onclick="toggleModal('writeModal')" class="text-gray-500 hover:text-black">✖</button>
    </div>

    <!-- 폼 -->
    <form action="/usr/message/doWriteMsg" method="post" class="space-y-3">
      <!-- 닉네임 입력 -->
      <div>
        <label class="block text-sm font-semibold mb-1">받는 사람 닉네임</label>
        <input type="text" name="nickName" id="nickName" placeholder="닉네임 입력"
               class="w-full border border-gray-400 rounded px-2 py-1" required />
      </div>

      <!-- 내용 입력 -->
      <div>
        <label class="block text-sm font-semibold mb-1">내용</label>
        <textarea name="content" rows="4"
                  class="w-full border border-gray-400 rounded px-2 py-1" required></textarea>
      </div>

      <!-- 전송 버튼 -->
      <div class="text-right">
        <button type="submit"
                class="bg-green-600 hover:bg-blue-700 text-white px-4 py-1 rounded">
          보내기
        </button>
      </div>
    </form>
  </div>
</div>

<script>
  function toggleModal(id) {
    document.getElementById(id).classList.toggle("hidden");
  }
</script>



<!-- 받은 쪽지함 모달 -->

<div id="inboxModal" class="fixed inset-0 ${type == 'received' ? '' : 'hidden'} bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg w-96 max-h-[80vh] overflow-y-auto p-4">
    <div class="flex justify-between items-center mb-2 sticky top-0 bg-white z-10">
      <h2 class="text-lg font-bold text-black-600">📥 받은 쪽지함</h2>
      <div class="flex gap-2">
        <a href="/usr/message/recevied" class="text-sm text-gray-500 hover:text-black border px-2 py-1 rounded">
          🔄
        </a>
        <button onclick="toggleModal('inboxModal')" class="text-gray-500 hover:text-black text-lg px-2">
          ✖
        </button>
      </div>
    </div>

    <c:forEach var="msg" items="${receivedMessages}">
      <div class="border-t py-2">
        <div class="text-sm text-gray-600">보낸 사람: ${msg.senderNickname}</div>
        <div class="text-gray-800">${msg.content}</div>
        <div class="text-xs text-right text-gray-400">${msg.sendDate}</div>
      </div>
    </c:forEach>

    <c:if test="${empty receivedMessages}">
      <div class="text-center text-gray-400 mt-4">받은 쪽지가 없습니다.</div>
    </c:if>
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


<!-- 스크립트: 모달 열기 토글 함수 -->
<script>
  function toggleModal(id) {
    const modal = document.getElementById(id);
    modal.classList.toggle("hidden");
  }
</script>



</body>
</html>
