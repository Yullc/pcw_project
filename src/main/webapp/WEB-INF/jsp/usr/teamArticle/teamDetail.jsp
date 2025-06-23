<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${team.teamName} 팀 명단</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white min-h-screen px-[150px] py-10">

<!-- 🔰 팀명 + 소개 -->
<div class="mb-10">
    <h1 class="text-3xl font-bold text-green-700 mb-2">🏆 ${team.teamName}</h1>
    <p class="text-gray-600">${team.intro}</p>
</div>

<div class="flex flex-col lg:flex-row gap-10">

    <!-- ✅ 좌측: 팀 정보 -->
    <div class="w-full lg:w-1/3 space-y-6">
        <div class="border rounded-xl p-6 shadow">
            <div class="text-lg font-semibold mb-2">팀 리더</div>
            <div class="text-gray-800">${team.teamLeader}</div>

            <div class="mt-4">
                <div class="bg-green-600 text-white rounded-full px-4 py-1 inline-block font-semibold mb-2">
                    팀 레벨: ${team.rankName}
                </div>
            </div>

            <div class="text-sm text-gray-500">팀원 수: ${fn:length(teamMembers)}명</div>

            <button onclick="openJoinPopup()" class="mt-6 w-full bg-green-500 hover:bg-green-600 text-white py-2 rounded-xl">
                🙋‍♂️ 팀 가입하기
            </button>
        </div>
    </div>

    <!-- ✅ 우측: 경기 정보 -->
    <div class="w-full lg:w-2/3 space-y-8">

        <!-- 최근 경기 -->
        <div>
            <h2 class="text-md font-bold text-green-700">📅 최근 경기</h2>
            <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
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
            <h2 class="text-md font-bold text-green-700">⏳ 예정된 경기</h2>
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
</div>

<!-- ✅ 팀원 리스트 아래쪽으로 배치 -->
<div class="mt-12 max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-md">
    <h2 class="text-lg font-bold mb-4 text-green-700">👥 팀원 명단</h2>
    <div class="grid grid-cols-1 gap-4">
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

<!-- ✅ 팝업 그대로 유지 -->
<!-- ... joinPopup 그대로 ... -->

</body>


<script>
    function openJoinPopup() {
        document.getElementById('joinPopup').classList.remove('hidden');
    }

    function closeJoinPopup() {
        document.getElementById('joinPopup').classList.add('hidden');
    }
</script>

</body>
</html>
