<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>팀 모집 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex justify-center p-10">

<div class="max-w-3xl w-full bg-white rounded-xl shadow-2xl overflow-hidden">
    <!-- 상세 정보 카드 -->
    <div class="p-6 space-y-4">
        <div class="text-sm text-gray-500">📅 등록일: ${teamArticle.regDate}</div>

        <h1 class="text-2xl font-bold text-green-700">${teamArticle.title}</h1>

        <div class="text-gray-700 whitespace-pre-line border-t border-b py-4">
            ${teamArticle.body}
        </div>

        <div class="flex flex-col md:flex-row justify-between items-start md:items-center text-sm text-gray-600 gap-2 border-t pt-4">
            <div>
                👤 <span class="font-semibold">작성자</span>: ${teamArticle.extra__writer}
            </div>
            <div>
                📍 <span class="font-semibold">지역</span>: ${teamArticle.area}
            </div>
            <div>
                🎖️ <span class="font-semibold">팀 레벨</span>: ${teamArticle.avgLevelName}
            </div>
        </div>

        <!-- 뒤로가기 버튼 -->
        <div class="pt-4 text-right">
            <a href="/usr/article/findTeam" class="text-sm text-white bg-green-600 hover:bg-green-600 px-4 py-2 rounded-full">
                ← 목록으로
            </a>
        </div>
    </div>
</div>

</body>
</html>
