<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-06-16
  Time: 오후 6:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- 팀원 목록 -->
<div class="mt-6">
    <h2 class="text-lg font-bold text-green-700 mb-4">👥 팀원 명단</h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <c:forEach var="member" items="${teamMembers}">
            <div class="bg-white rounded-xl shadow-md p-4 flex items-center gap-4 hover:shadow-lg transition">
                <img src="${member.profileImg}" alt="프로필" class="w-14 h-14 rounded-full border object-cover" />

                <div>
                    <div class="font-semibold text-gray-800">${member.nickName}</div>
                    <div class="text-sm text-gray-500">
                            ${member.rankName} · 매너온도: ${member.manner}°C
                    </div>
                    <c:if test="${member.isLeader}">
                        <div class="text-xs font-bold text-green-600 mt-1">👑 팀장</div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
