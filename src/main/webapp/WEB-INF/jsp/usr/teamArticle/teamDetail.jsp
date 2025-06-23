<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${team.teamName} 팀 명단</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white min-h-screen px-[150px] py-10">

<!-- 🔰 페이지 상단: 팀 이름 -->
<div class="mb-10">
    <h1 class="text-3xl font-bold text-green-700 mb-2">🏆 ${team.teamName}</h1>
</div>

<!-- ✅ 메인 레이아웃: 좌측(1/3) + 우측(2/3) -->
<div class="flex flex-col lg:flex-row gap-10">

    <!-- ✅ 좌측: 팀 정보 + 경기 정보 -->
    <div class="w-full lg:w-1/3 space-y-6">

        <!-- 팀 정보 -->
        <div class="border rounded-xl p-6 shadow">
            <div class="text-lg font-semibold mb-2">팀 리더</div>
            <div class="text-gray-800">${team.teamLeader}</div>

            <div class="mt-4">
                <div class="bg-green-600 text-white rounded-full px-4 py-1 inline-block font-semibold mb-2">
                    팀 레벨: ${team.teamRank}
                </div>
            </div>

            <div class="text-sm text-gray-500">팀원 수: ${fn:length(teamMembers)}명</div>

            <button onclick="openJoinPopup()" class="mt-6 w-full bg-green-500 hover:bg-green-600 text-white py-2 rounded-xl">
                🙋‍♂️ 팀 가입하기
            </button>
        </div>

        <!-- 최근 경기 -->
        <div>
            <h2 class="text-md font-bold text-green-700 mb-2">📅 최근 경기</h2>
            <div class="flex overflow-x-auto gap-4 pb-2">
                <c:forEach var="game" items="${recentTeamGames}">
                    <div class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md hover:shadow-lg transition">
                        <img src="${game.img}" class="w-full h-28 object-cover rounded-t-lg" />
                        <div class="p-2 text-sm">
                            <div class="font-semibold">${game.stadium}</div>
                            <div class="text-gray-500">${game.playDate}</div>
                            <div class="text-gray-700">${game.title}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 다음 경기 -->
        <div>
            <h2 class="text-md font-bold text-green-700 mb-2">⏳ 예정된 경기</h2>
            <c:choose>
                <c:when test="${not empty nextGame}">
                    <div class="bg-gray-50 p-4 rounded-xl shadow text-sm">
                        <div class="font-semibold text-lg">${nextGame.title}</div>
                        <div class="text-gray-600">${nextGame.playDate} - ${nextGame.stadium}</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-sm text-gray-400">예정된 경기가 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- ✅ 우측: 팀원 명단 + 팀 소개 -->
    <div class="w-full lg:w-2/3 space-y-6">

        <!-- 팀원 명단 -->
        <div class="bg-white p-6 rounded-xl shadow-md">
            <h2 class="text-lg font-bold text-green-700 mb-4">👥 팀원 명단</h2>
            <div class="max-h-[400px] overflow-y-auto space-y-3 pr-2">
                <c:forEach var="member" items="${teamMembers}">
                    <div class="flex items-center gap-4 p-4 rounded-xl border border-green-300 bg-white shadow hover:shadow-md transition">
                        <img src="${member.profileImg}" alt="프로필" class="w-12 h-12 rounded-full object-cover border border-gray-300" />
                        <div>
                            <a href="/usr/home/yourPage?nickName=${member.nickName}" class="hover:text-green-600 hover:underline">
                                    ${member.nickName}
                            </a>
                            <div class="text-sm text-gray-600 mt-1">
                                    ${member.rankName} &nbsp;|&nbsp; 😊 매너온도: ${member.mannerEmoji}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 팀 소개 -->
        <div class="bg-white p-6 rounded-xl shadow-md">
            <h2 class="text-lg font-bold text-green-700 mb-2">📢 팀 소개</h2>
            <p class="text-sm text-gray-700 whitespace-pre-line">${team.intro}</p>
        </div>

    </div>
</div>

<!-- ✅ 하단 버튼 -->
<div class="mt-12 flex justify-between max-w-4xl mx-auto">
    <button onclick="history.back()" class="bg-gray-300 hover:bg-gray-400 text-black px-4 py-2 rounded-xl">
        ⬅ 뒤로가기
    </button>

</div>

<!-- ✅ 가입 신청 팝업 -->
<div id="joinPopup" class="hidden fixed top-0 left-0 w-full h-full bg-black bg-opacity-50 z-50 flex items-center justify-center">
    <div class="bg-white rounded-xl p-6 w-96 shadow-lg">
        <h3 class="text-lg font-bold mb-4">팀 가입 신청</h3>
        <form action="/usr/team/joinRequest" method="post">
            <input type="hidden" name="teamId" value="${team.id}" />
            <input type="hidden" name="teamLeader" value="${team.teamLeader}" />

            <label class="block text-sm mb-2">자기소개</label>
            <textarea name="message" class="w-full border rounded p-2 mb-4" rows="4" required></textarea>

            <div class="flex justify-end gap-2">
                <button type="button" onclick="closeJoinPopup()" class="px-3 py-1 bg-gray-300 rounded">취소</button>
                <button type="submit" class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600">신청하기</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openJoinPopup() {
        document.getElementById('joinPopup').classList.remove('hidden');
    }

    function closeJoinPopup() {
        document.getElementById('joinPopup').classList.add('hidden');
    }
</script>

<!-- <div id="joinPopup" class="hidden fixed ..."> ... </div> -->



</body>
</html>
