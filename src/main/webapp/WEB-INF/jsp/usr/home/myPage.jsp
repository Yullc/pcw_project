<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <title>마이페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<div class="px-[150px]">
  <div class="px-[150px]">
  <!-- 메인 컨테이너 -->
  <header class="bg-white border-b border-gray-300 h-20">
    <div class="max-w-6xl h-full flex items-center px-6 justify-start ml-20">
      <a href="/usr/home/main">
        <img src="/img/Logo_V.png" alt="로고" class="h-12 object-contain" />
      </a>
    </div>
  </header>

<body class="bg-white min-h-screen p-10">

  <!-- 메인 컨테이너 -->


  <div class="flex flex-col lg:flex-row gap-8 ml-20">


    <!-- ✅ 좌측 프로필 전체 영역 -->
    <div class="w-full lg:w-1/3 space-y-6">

      <!-- ✅ 프로필 업로드 영역 -->
      <form id="profileForm"
            enctype="multipart/form-data"
            class="border rounded-xl p-6 flex flex-col items-center gap-3 shadow relative">

        <!-- 실제 파일 선택 인풋 (숨김) -->
        <input type="file" id="profileImg" name="profileImg" accept="image/*"
               class="hidden"
               onchange="handleProfileUpload(this)" />

        <!-- 이미지 클릭시 업로드 트리거 -->
        <label for="profileImg" class="cursor-pointer group">
          <img id="profilePreview"
               src="${profileImg}?v=<%= System.currentTimeMillis() %>"
               class="w-32 h-32 rounded-full object-cover transition duration-300 group-hover:opacity-70" />

        </label>

        <!-- 텍스트 버튼 (이미지 업로드 트리거) -->
        <label for="profileImg"
               class="text-sm bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600 transition cursor-pointer">
          프로필 변경
        </label>

        <!-- 사용자 정보 -->
        <div class="text-xl font-semibold">${nickName}</div>
        <div class="mt-2 text-sm text-gray-600">
          👍 나의 좋아요 수: <strong>${likeCount}</strong>
        </div>
        <div class="text-3xl">${mannerEmoji}</div>

        <!-- 업로드 중 표시 -->
        <div id="loadingSpinner" class="hidden absolute top-3 right-3 text-sm text-gray-400 animate-pulse">
          업로드 중...
        </div>
      </form>

      <script>
        async function handleProfileUpload(input) {
          const file = input.files[0];
          if (!file) return;

          const formData = new FormData();
          formData.append("file", file);

          const spinner = document.getElementById("loadingSpinner");
          const preview = document.getElementById("profilePreview");

          spinner.classList.remove("hidden");

          try {
            const res = await fetch("/usr/home/uploadProfileImg", {
              method: "POST",
              body: formData
            });

            const result = await res.text();

            if (!res.ok || result.startsWith("업로드 실패")) {
              alert("이미지 업로드 실패: " + result);
              return;
            }

            // ✅ 프로필 이미지 갱신 (캐시 방지용 timestamp 포함)
            preview.src = result + "?v=" + new Date().getTime();

          } catch (err) {
            alert("오류 발생: " + err.message);
          } finally {
            spinner.classList.add("hidden");
          }
        }
      </script>



      <!-- ✅ 쪽지 버튼 영역 -->
      <!-- ✅ 쪽지 버튼 영역 (가로 정렬) -->
      <div class="border rounded-xl p-4 shadow">
        <div class="flex justify-between gap-2">
          <button onclick="toggleModal('writeModal')" class="flex-1 bg-white border px-3 py-2 rounded hover:bg-gray-100">
            ✉️ 쪽지
          </button>
          <button onclick="toggleModal('inboxModal')" class="flex-1 bg-white border px-3 py-2 rounded hover:bg-gray-100">
            📥 받은쪽지
          </button>
          <button onclick="toggleModal('outboxModal')" class="flex-1 bg-white border px-3 py-2 rounded hover:bg-gray-100">
            📤 보낸쪽지
          </button>
        </div>
      </div>


      <!-- ✅ 다음 경기 영역 -->
      <div class="border rounded-xl p-4 shadow">
        <h3 class="text-sm font-bold text-green-700 mb-2">🗓️ 나의 다음 경기</h3>
        <c:choose>
          <c:when test="${not empty nextMatch}">
            <a href="${nextMatch.type == '풋살' ? '/usr/ftArticle/foot_detail?id=' : '/usr/scArticle/soccer_detail?id='}${nextMatch.id}"
               class="block bg-white rounded-lg shadow-md hover:shadow-lg transition overflow-hidden">
              <img src="${nextMatch.img}" class="w-48 h-28 rounded-t-lg object-cover" />
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


    <!-- ✅ 우측 정보 및 경기 목록 -->
    <div class="w-full lg:w-2/3 space-y-6">

      <!-- 최근 풋살 경기 -->
      <div>
        <h2 class="text-md font-bold text-green-700">최근 풋살 경기</h2>
        <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
          <c:forEach var="game" items="${recentGames}">
            <a href="/usr/ftArticle/foot_detail?id=${game.id}" class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
              <img src="${game.img}" class="w-full h-28 object-cover rounded-t-lg" />
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
      <div>
        <h2 class="text-md font-bold text-green-700">최근 축구 경기</h2>
        <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
          <c:forEach var="game" items="${recentSoccerGames}">
            <a href="/usr/scArticle/soccer_detail?id=${game.id}" class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
              <img src="${game.img}" class="w-full h-28 object-cover rounded-t-lg" />
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