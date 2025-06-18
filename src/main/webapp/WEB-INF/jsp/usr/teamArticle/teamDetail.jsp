<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${team.teamName} 팀 명단</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen p-8">


<!-- 팀 이름 -->
<div class="text-center mb-10">
    <h1 class="text-3xl font-bold text-green-700">🏆 ${team.teamName} 팀 명단</h1>
</div>


<!-- 팀 가입하기 버튼 -->
<div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow-md mt-6">


    <c:forEach var="member" items="${teamMembers}">
        <div class="flex items-center gap-4 bg-green-100 rounded-xl px-5 py-3 mb-2 shadow-sm">
            <span class="font-semibold text-green-800">${member.nickName}</span>
            <span class="text-sm">| ${member.rankName}</span>
            <span class="text-sm">| 매너온도: ${member.mannerEmoji}</span>
        </div>
    </c:forEach>

    <!-- 하단 버튼 영역 -->
    <div class="mt-8 flex justify-between">
        <button onclick="history.back()" class="bg-gray-300 hover:bg-gray-400 text-black px-4 py-2 rounded-xl">
            ⬅ 뒤로가기
        </button>
        <button onclick="openJoinPopup()" class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-xl">
            🙋‍♂️ 팀 가입하기
        </button>
    </div>
</div>

<!-- 가입 신청 팝업 -->
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

</body>
</html>
