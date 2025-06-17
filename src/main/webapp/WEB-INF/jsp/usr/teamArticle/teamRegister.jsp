<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀 등록</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen p-10">
<div class="max-w-xl mx-auto bg-white p-8 rounded-xl shadow">

    <h1 class="text-2xl font-bold text-green-700 mb-6">🏆 팀 등록</h1>

    <form action="/usr/teamArticle/doRegister" method="post" class="space-y-5">

        <!-- 팀 이름 -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">팀 이름</label>
            <input type="text" name="teamName" required
                   class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring focus:border-green-400" />
        </div>

        <!-- 지역 -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">지역</label>
            <select name="area" required
                    class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring focus:border-green-400">
                <option value="">-- 지역 선택 --</option>
                <c:forEach var="region" items="${['서울','경기','강원','인천','대전','세종','충북','충남','대구','경북','경남','부산','광주','전북','울산','전남','제주']}">
                    <option value="${region}">${region}</option>
                </c:forEach>
            </select>
        </div>

        <!-- 팀 리더 표시용 -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">팀 리더</label>
            <div class="border border-gray-300 rounded px-4 py-2 bg-gray-100">
                ${rq.loginedMember.nickName}
            </div>
        </div>


        <!-- 팀 소개 (intro) -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">팀 소개</label>
            <textarea name="intro" placeholder="내용 없음" rows="4"
                      class="w-full border border-gray-300 rounded px-4 py-2 resize-none focus:outline-none focus:ring focus:border-green-400"></textarea>
        </div>

        <!-- 등록 버튼 -->
        <div class="text-right">
            <button type="submit"
                    class="bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-2 rounded-full">
                팀 등록
            </button>
        </div>
    </form>
</div>
</body>
</html>
