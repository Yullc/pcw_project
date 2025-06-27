<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="org.example.util.RankUtil" %>
<html>
<head>
    <title>풋살 매치 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<header class="bg-white border-b border-gray-300 h-20">
    <div class="max-w-6xl mx-auto h-full flex items-center px-6">
        <a href="/usr/home/main">
            <img src="/img/Logo_V.png" alt="로고" class="h-12 object-contain"/>
        </a>
    </div>
</header>
<div class="max-w-3xl mx-auto bg-white shadow-lg rounded-lg p-6 mt-8">

    <!-- 경기장 이미지 -->
    <img src="${ftArticle.img}" alt="경기장" class="w-full h-64 object-cover rounded mb-4"/>


    <!-- 경기 정보 카드 (지도 포함) -->
    <div class=" rounded-lg p-4 mb-4 font-semibold text-black-700 shadow">
        <div class="flex flex-col md:flex-row gap-4">

            <!-- 🟩 왼쪽: 텍스트 정보 -->
            <div class="flex-1 space-y-2">
                <div>
                    <span class="font-semibold text-green-700">경기장: </span>
                    <span id="title">${ftArticle.title}</span>
                </div>
                <div>
                    <span class="font-semibold text-green-700">경기 일시: </span>${ftArticle.playDate}
                </div>
                <div>
                    <span class="font-semibold text-green-700">주소: </span>
                    <span id="address">${ftArticle.address}</span>
                </div>
            </div>

            <!-- 🟦 오른쪽: 지도 영역 -->
            <div class="flex-1">
                <div id="map" class="w-full h-40 md:h-48 rounded-lg shadow"></div>
            </div>
        </div>
    </div>
    <!-- Kakao Map Script -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=865ee63e65accb86ded5e65ec9ebfe0b&libraries=services"></script>
    <script>
        // ✅ address에서 텍스트 가져오기
        const address = document.getElementById("address").textContent.trim();

        // ✅ 주소 + " 풋살장" 조합으로 키워드 생성
        const keyword = `${ftArticle.address} 풋살장`;

        // ✅ Kakao Map 초기 설정
        const mapContainer = document.getElementById('map');
        const mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };
        const map = new kakao.maps.Map(mapContainer, mapOption);
        const ps = new kakao.maps.services.Places();  // 장소 검색 객체 생성

        // ✅ 키워드로 검색
        ps.keywordSearch(keyword, function (result, status) {
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


    <!-- ❌ 날씨 정보 -->
    <c:choose>
        <c:when test="${not empty weatherList}">
            <div class="flex gap-4 bg-gray-400 justify-center text-center text-sm mt-2 rounded text-white py-2">
                <c:forEach var="weather" items="${weatherList}">
                    <div class="w-16">
                        <div>
                            <fmt:parseDate var="weatherTime" value="${weather.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <fmt:formatDate value="${weatherTime}" pattern="HH시"/>
                        </div>
                        <div><img src="${weather.iconUrl}" style="width: 40px;"/></div>
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
        평균레벨 <span class="text-black">${ftArticle.avgLevelName}</span>
    </div>

    <!-- 참가자 목록 -->
    <div class="mt-6">
        <h2 class="text-md font-bold text-green-600 mb-2">참가자 목록</h2>
        <!-- ✅ 고정 높이 + overflow-y 적용 -->
        <div class="h-72 overflow-y-auto pr-2 space-y-2">

        <c:forEach var="player" items="${participants}">
            <c:choose>

                <c:when test="${pastMatch && rq.loginedMember.nickName != player.nickName}">
                    <form method="post" action="/usr/member/updatePlayerInfo"
                          class="flex flex-wrap items-center gap-3 bg-green-100 rounded-xl px-4 py-2 mb-2 justify-between w-full">
                        <input type="hidden" name="memberId" value="${player.id}" />
                        <input type="hidden" name="id" value="${ftArticle.id}" />
                        <input type="hidden" name="boardId" value="${boardId}" />


                        <div class="flex items-center gap-2 flex-wrap">
                            <a href="/usr/home/yourPage?nickName=${player.nickName}"
                               class="font-semibold text-green-800 hover:underline">${player.nickName}</a>

                            <span class="text-sm flex items-center gap-1 text-gray-700">
                            | <span class="w-4 h-4 inline-block align-middle">
                                <c:out value="${player.trophySvg}" escapeXml="false" />
                              </span> ${player.rankName}
                        </span>

                            <span class="text-sm text-gray-700">| 메너온도: ${player.mannerEmoji}</span>
                        </div>


                        <div class="flex gap-2 flex-wrap">
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
                            <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-sm">
                                평가하기
                            </button>
                        </div>
                    </form>
                </c:when>


                <c:otherwise>
                    <div class="flex flex-wrap items-center gap-2 bg-green-100 rounded-xl px-4 py-2 mb-2 justify-start">
                        <a href="/usr/home/yourPage?nickName=${player.nickName}"
                           class="font-semibold text-green-800 hover:underline">${player.nickName}</a>

                        <span class="text-sm flex items-center gap-1 text-gray-700">
                        | <span class="w-4 h-4 inline-block align-middle">
                            <c:out value="${player.trophySvg}" escapeXml="false" />
                          </span> ${player.rankName}
                    </span>

                        <span class="text-sm text-gray-700">| 메너온도: ${player.mannerEmoji}</span>
                    </div>
                </c:otherwise>

            </c:choose>
        </c:forEach>
        </div>
    </div>


    <!-- 참가하기 버튼 -->
    <div class="mt-4 text-center">
        <c:choose>
            <c:when test="${pastMatch}">
                <div class="text-gray-400 text-sm">종료된 경기입니다. 참가할 수 없습니다.</div>
            </c:when>
            <c:when test="${isAlreadyJoined}">
                <form action="/usr/ftArticle/cancelJoin" method="post" onsubmit="return confirm('정말 참가를 취소하시겠습니까?')">
                    <input type="hidden" name="id" value="${ftArticle.id}"/>
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-full">참가
                        취소하기
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <form action="/usr/ftArticle/joinMatch" method="post" onsubmit="return validatePositionSelection(this)">
                    <input type="hidden" name="id" value="${ftArticle.id}"/>
                    <input type="hidden" name="position" id="selectedPosition"/>
                    <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full">⚽
                        참가하기
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
            <li>고르키퍼에 대한 백패스는 손으로 잡으면 안 되요</li>
            <li>심한 요식 및 헛한 플레이 까지</li>
            <li>음료/간식 개인 음료로 준비하세요</li>
            <li>출석체크 후 복귀 보호드립니다</li>
            <li>지각하면 팀원들에게 비의히 있어요</li>
            <li>인원 미달 시 실력 맞게 다른 팀과 석을 수 있어요</li>
        </ul>
    </div>
</div>

</div>
</body>
</html>