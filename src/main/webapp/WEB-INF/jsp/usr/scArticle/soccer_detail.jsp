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
<div class="px-[150px]">
  <!-- 헤더 -->
  <header class="bg-white border-b border-gray-300 h-20">
    <div class="max-w-6xl mx-auto h-full flex items-center px-6">
      <a href="/usr/home/main">
        <img src="/img/Logo_V.png" alt="로고" class="h-12 object-contain" />
      </a>
    </div>
  </header>

  <div class="max-w-3xl mx-auto bg-white shadow-lg rounded-lg p-6 mt-8">
    <!-- 경기장 이미지 -->
    <img src="${scArticle.img}" alt="경기장" class="w-full h-64 object-cover rounded mb-4" />

    <!-- 경기 정보 카드 -->
    <!-- 경기 정보 카드 (지도 포함) -->
    <div class=" rounded-lg p-4 mb-4 font-semibold text-black-700 shadow">
      <div class="flex flex-col md:flex-row gap-4">

        <!-- 🟩 왼쪽: 텍스트 정보 -->
        <div class="flex-1 space-y-2">
          <div>
            <span class="font-semibold text-green-700">경기장: </span>
            <span id="title">${scArticle.title}</span>
          </div>
          <div>
            <span class="font-semibold text-green-700">경기 일시: </span>
            ${scArticle.playDate}
          </div>
          <div>
            <span class="font-semibold text-green-700">주소: </span>
            <span id="address">${scArticle.address}</span>
          </div>

        </div>

        <!-- 🟦 오른쪽: 지도 영역 -->
        <div class="flex-1">
          <div id="map" class="w-full h-40 md:h-48 rounded-lg shadow"></div>
        </div>
      </div>
    </div>
    <!-- Kakao Map Script -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=865ee63e65accb86ded5e65ec9ebfe0b&libraries=services"></script>
    <script>
      // ✅ address에서 텍스트 가져오기
      const address = document.getElementById("address").textContent.trim();

      // ✅ 주소 + " 풋살장" 조합으로 키워드 생성
      const keyword = `${scArticle.address} 축구장`;

      // ✅ Kakao Map 초기 설정
      const mapContainer = document.getElementById('map');
      const mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
      };
      const map = new kakao.maps.Map(mapContainer, mapOption);
      const ps = new kakao.maps.services.Places();  // 장소 검색 객체 생성

      // ✅ 키워드로 검색
      ps.keywordSearch(keyword, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
          const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          map.setCenter(coords);
          new kakao.maps.Marker({
            map: map,
            position: coords
          });
        } else {
          console.error("장소 검색 실패", status);
        }
      });
    </script>


    <!-- 날씨 정보 -->
    <!-- ❌ 날씨 정보 -->
    <c:choose>
      <c:when test="${not empty weatherList}">
        <div class="flex gap-4 bg-gray-400 justify-center text-center text-sm mt-2 rounded text-white py-2">
          <c:forEach var="weather" items="${weatherList}">
            <div class="w-16">
              <div>
                <fmt:parseDate var="weatherTime" value="${weather.time}" pattern="yyyy-MM-dd HH:mm:ss" />
                <fmt:formatDate value="${weatherTime}" pattern="HH시" />
              </div>
              <div><img src="${weather.iconUrl}" style="width: 40px;" /></div>
              <div>${weather.temp}°C</div>
            </div>
          </c:forEach>
        </div>
      </c:when>
      <c:otherwise>
        <div class="text-sm text-gray-500 text-center py-3">
          날씨 정보는 5일부터 확인 가능합니다.
        </div>
      </c:otherwise>
    </c:choose>

    <!-- 평균 레벨 -->
    <div class="text-lg font-semibold text-green-600 mt-4">
      평균레벨 <span class="text-black">${scArticle.avgLevelName}</span>
    </div>

    <!-- 참가 폼 (포지션 선택 + 조건별 버튼 포함) -->
    <form action="<c:choose>
                <c:when test='${isAlreadyJoined}'>/usr/scArticle/cancelJoin</c:when>
                <c:otherwise>/usr/scArticle/joinMatch</c:otherwise>
             </c:choose>"
          method="post"
          onsubmit="return validatePositionSelection(this)">

      <input type="hidden" name="id" value="${scArticle.id}" />
      <input type="hidden" name="position" id="positionSelect" />

      <!-- 포지션 선택 버튼 -->
      <div class="flex justify-center gap-4 mt-6 mb-6">
        <button type="button" id="btn-FW"
                onclick="selectPosition('FW')"
                class="px-6 py-2 rounded-full border-2 border-red-500 text-red-500 font-semibold transition hover:bg-red-50">
          FW
        </button>

        <button type="button" id="btn-MF"
                onclick="selectPosition('MF')"
                class="px-6 py-2 rounded-full border-2 border-green-600 text-green-600 font-semibold transition hover:bg-green-50">
          MF
        </button>

        <button type="button" id="btn-DF"
                onclick="selectPosition('DF')"
                class="px-6 py-2 rounded-full border-2 border-blue-500 text-blue-500 font-semibold transition hover:bg-blue-50">
          DF
        </button>
      </div>

      <!-- 참가 or 취소 버튼 -->
      <div class="text-center">
        <c:choose>
          <c:when test="${pastMatch}">
            <div class="text-gray-400 text-sm">종료된 경기입니다. 참가할 수 없습니다.</div>
          </c:when>

          <c:when test="${isAlreadyJoined}">
            <button type="submit"
                    class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-full"
                    onclick="return confirm('정말 참가를 취소하시겠습니까?')">
              참가 취소하기
            </button>
          </c:when>

          <c:otherwise>
            <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full">
              ⚽ 참가하기
            </button>
          </c:otherwise>
        </c:choose>
      </div>
    </form>





    <!-- 참가자 목록 -->
    <!-- 참가자 목록 -->
    <div class="mt-6">
      <h2 class="text-md font-bold text-green-600 mb-2">참가자 목록</h2>

      <c:forEach var="player" items="${participants}">
        <c:choose>
          <c:when test="${pastMatch && rq.loginedMember.nickName != player.nickName}">
            <form method="post" action="/usr/member/updatePlayerInfo"
                  class="flex flex-wrap items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-2 justify-between">
              <input type="hidden" name="memberId" value="${player.id}" />
              <input type="hidden" name="id" value="${scArticle.id}" />
              <input type="hidden" name="boardId" value="${boardId}" />

              <div class="flex items-center gap-2">
                <c:choose>
                  <c:when test="${rq.loginedMember.nickName == player.nickName}">
                    <a href="/usr/home/myPage" class="font-semibold text-green-800 hover:underline">
                        ${player.nickName}
                    </a>
                  </c:when>
                  <c:otherwise>
                    <a href="/usr/home/yourPage?nickName=${player.nickName}" class="font-semibold text-green-800 hover:underline">
                        ${player.nickName}
                    </a>
                  </c:otherwise>
                </c:choose>

                <!-- ✅ 트로피 + 랭크 -->
                <span class="text-sm flex items-center gap-1 text-gray-700">
              | <span class="w-4 h-4 inline-block align-middle">
                <c:out value="${player.trophySvg}" escapeXml="false" />
              </span>
              ${player.rankName}
            </span>

                <span class="text-sm">| 매너온도: ${player.mannerEmoji}</span>
                <span class="text-sm text-gray-500">| 포지션: ${player.position}</span>
              </div>

              <!-- 평가 폼 -->
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
              <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-sm">평가하기</button>
            </form>
          </c:when>

          <c:otherwise>
            <!-- 일반 참가자 출력 -->
            <div class="flex items-center gap-2 bg-green-100 rounded-full px-3 py-1 mb-2 justify-start">
              <span class="font-semibold text-green-800">${player.nickName}</span>

              <!-- ✅ 트로피 + 랭크 -->
              <span class="text-sm flex items-center gap-1 text-gray-700">
            | <span class="w-4 h-4 inline-block align-middle">
              <c:out value="${player.trophySvg}" escapeXml="false" />
            </span>
            ${player.rankName}
          </span>

              <span class="text-sm text-gray-700">| 매너온도: ${player.mannerEmoji}</span>
              <span class="text-sm text-gray-500">| 포지션: ${player.position}</span>
            </div>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>



    <!-- JS 스크립트 -->
    <script>
      function selectPosition(pos) {
        document.getElementById('positionSelect').value = pos;

        const buttons = {
          FW: document.getElementById('btn-FW'),
          MF: document.getElementById('btn-MF'),
          DF: document.getElementById('btn-DF')
        };

        // 모든 버튼 초기화
        Object.entries(buttons).forEach(([key, btn]) => {
          btn.classList.remove('bg-red-500', 'bg-green-600', 'bg-blue-500', 'text-white');

          if (key === 'FW') {
            btn.classList.remove('border-black');
            btn.classList.add('border-red-500', 'text-red-500', 'bg-white');
          }
          if (key === 'MF') {
            btn.classList.add('border-green-600', 'text-green-600', 'bg-white');
          }
          if (key === 'DF') {
            btn.classList.add('border-blue-500', 'text-blue-500', 'bg-white');
          }
        });

        // 선택된 버튼 강조
        const selected = buttons[pos];

        if (pos === 'FW') {
          selected.classList.remove('text-red-500', 'bg-white');
          selected.classList.add('bg-red-500', 'text-white');
        }
        if (pos === 'MF') {
          selected.classList.remove('text-green-600', 'bg-white');
          selected.classList.add('bg-green-600', 'text-white');
        }
        if (pos === 'DF') {
          selected.classList.remove('text-blue-500', 'bg-white');
          selected.classList.add('bg-blue-500', 'text-white');
        }
      }
    </script>



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