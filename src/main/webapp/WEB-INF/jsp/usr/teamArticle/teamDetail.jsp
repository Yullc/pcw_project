<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${team.teamName} 팀 명단</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body class="bg-white min-h-screen px-[150px] py-10">
<header class="bg-white border-b border-gray-300 h-20">
    <div class="max-w-6xl h-full flex items-center px-6 justify-start ml-20">
        <a href="/usr/home/main">
            <img src="/img/Logo_V.png" alt="로고" class="h-12 object-contain" />
        </a>
    </div>
</header>

<div class="px-[150px] pt-10">

<!-- ✅ 메인 레이아웃: 좌측(1/3) + 우측(2/3) -->
    <div class="flex flex-col lg:flex-row gap-10">

    <!-- ✅ 좌측: 팀 정보 + 경기 정보 -->
        <div class="w-full lg:w-1/4 space-y-6">
        <!-- 팀 정보 -->
        <div class="border rounded-xl p-6 shadow flex flex-col items-center text-center">
            <h1 class="text-3xl font-bold text-green-700 mb-2"> ${team.teamName}</h1>

            <div class="text-lg font-semibold mb-2">팀장: ${team.teamLeader}</div>

            <div class="mt-4">
                <div class="bg-green-600 text-white rounded-full px-4 py-1 inline-block font-semibold mb-2">
                    팀 평균 레벨: ${team.avgLevelName}
                </div>
            </div>

            <div class="text-sm text-gray-500">팀원 수: ${fn:length(teamMembers)}명</div>

            <!-- 팀 가입/탈퇴/채팅 버튼 -->
            <!-- 팀 가입/탈퇴 버튼 영역 -->
            <div class="mt-6 flex gap-4 w-full justify-center">
                <c:choose>
                    <c:when test="${not empty rq.loginedMember && rq.loginedMember.teamNm eq team.teamName}">
                        <!-- 팀 탈퇴 버튼 -->
                        <form action="/usr/team/leave" method="post" onsubmit="return confirm('정말로 팀을 탈퇴하시겠습니까?');" class="w-48">
                            <input type="hidden" name="teamId" value="${team.id}" />
                            <button type="submit" class="w-full bg-red-500 hover:bg-red-600 text-white py-2 rounded-xl">
                                ❌ 팀 탈퇴하기
                            </button>
                        </form>

                    </c:when>
                    <c:otherwise>
                        <!-- 팀 가입 버튼 -->
                        <button onclick="openJoinPopup()" class="w-48 bg-green-500 hover:bg-green-600 text-white py-2 rounded-xl">
                            🙋‍♂️ 팀 가입하기
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>

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
        <div class="w-full lg:w-1/2 space-y-6">
            <div class="bg-white p-6 rounded-xl shadow-md">
                <h2 class="text-lg font-bold text-green-700 mb-4">👥 팀원 명단</h2>
                <div class="max-h-[400px] overflow-y-auto space-y-3 pr-2">
                    <c:forEach var="member" items="${teamMembers}">
                        <div class="flex items-center gap-4 p-4 rounded-xl border border-green-300 bg-white shadow hover:shadow-md transition">
                            <img src="${member.profileImg}" alt="프로필" class="w-12 h-12 rounded-full object-cover border border-gray-300" />
                            <div>
                                <a href="/usr/home/yourPage?nickName=${member.nickName}" class="hover:text-green-600 hover:underline">${member.nickName}</a>
                                <div class="text-sm text-gray-600 mt-1">${member.rankName} &nbsp;|&nbsp; 😊 매너온도: ${member.mannerEmoji}</div>
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

        <div class="w-full lg:w-1/4 space-y-6">
            <div class="bg-white rounded-xl shadow-lg flex flex-col h-[500px]">
                <div class="bg-blue-500 text-white px-4 py-2 rounded-t-xl flex justify-between items-center">
                    <span class="font-semibold">💬 팀 채팅</span>
                </div>

                <div id="chatMessages" class="flex flex-col flex-1 p-4 overflow-y-auto text-sm gap-2"></div>


                <form onsubmit="sendMessage(event)" class="flex border-t">
                    <input id="chatInput" type="text" placeholder="메시지를 입력하세요..." class="flex-1 p-2 text-sm focus:outline-none" required />
                    <button type="submit" class="bg-blue-500 text-white px-4 hover:bg-blue-600">전송</button>
                </form>
            </div>
        </div>

    </div>

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
    let stompClient = null;
    const teamId = <c:out value="${team.id}" default="0" />;
    const memberId = <c:out value="${rq.loginedMember.id}" default="0" />;

    // 문자열은 반드시 따옴표로 감싸야 함
    const sender = "<c:out value='${rq.loginedMember.nickName}' default='unknown' />";

    function connectWebSocket() {
        console.log("[WebSocket] 연결 시도...");
        const socket = new SockJS('/ws-stomp');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, (frame) => {
            console.log("[WebSocket] 연결 성공!", frame);

            // 🔹 실시간 채팅 수신 구독
            stompClient.subscribe(`/sub/chatroom/${teamId}`, (message) => {
                const msg = JSON.parse(message.body);
                console.log("[실시간 메시지 수신]", msg);
                showMessage(msg.sender, msg.message);
            });

            // 🔹 DB에 저장된 이전 메시지 불러오기
            fetch(`/chat/history?teamId=${teamId}`)
                .then(response => response.json())
                .then(data => {
                    console.log("[초기 메시지 불러오기]", data);
                    data.forEach(msg => showMessage(msg.nickName, msg.message));
                })
                .catch(error => console.error("[초기 메시지 오류]", error));
        });
    }

    function sendMessage(event) {
        event.preventDefault();

        const input = document.getElementById('chatInput');
        const message = input.value.trim();
        if (!message) return;

        const payload = {
            teamId: teamId,
            sender: sender,
            memberId: memberId,
            message: message
        };

        console.log("[메시지 전송]", payload);
        stompClient.send("/pub/chat/send", {}, JSON.stringify(payload));
        input.value = '';
    }

    function showMessage(sender, message) {
        const chatBox = document.getElementById('chatMessages');
        const messageDiv = document.createElement('div');

        const isMine = sender === "${rq.loginedMember.nickName}";
        messageDiv.classList.add("mb-2", "p-2", "rounded", "max-w-[80%]");
        messageDiv.classList.add(isMine ? "bg-blue-100" : "bg-gray-100");
        messageDiv.classList.add("self-" + (isMine ? "end" : "start"));

        messageDiv.innerHTML = `
            <div class="text-xs text-gray-500">${sender}</div>
            <div class="text-sm">${message}</div>
        `;

        chatBox.appendChild(messageDiv);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    window.addEventListener('load', connectWebSocket);
</script>

</body>
</html>
