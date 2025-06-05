<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-white p-10">
<div class="w-full max-w-5xl border rounded-lg shadow p-10 flex gap-20">
    <!-- 왼쪽: 기존 정보 수정 -->
    <form action="/usr/member/doModify" method="post" class="flex-1 space-y-5">
        <h2 class="text-2xl font-bold text-green-700 mb-4">회원정보 수정</h2>

        <div>
            <label class="block mb-1 font-semibold">아이디</label>
            <input type="text" name="loginId" value="${member.loginId}" readonly class="w-full border border-green-500 rounded px-4 py-2 bg-gray-100" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">이름</label>
            <input type="text" name="name" value="${member.name}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호</label>
            <input type="password" name="loginPw" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호 확인</label>
            <input type="password" name="loginPwConfirm" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <button type="submit" class="bg-green-600 text-white font-semibold py-2 px-6 rounded hover:bg-green-700">수정 완료</button>
    </form>

    <!-- 오른쪽: 기타 정보 -->
    <div class="flex-1 space-y-5">
        <div>
            <label class="block mb-1 font-semibold">닉네임</label>
            <input type="text" name="nickname" value="${member.nickname}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">전화번호</label>
            <input type="text" name="phoneNumber" value="${member.phoneNumber}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <

        <div class="flex gap-4">
            <div>
                <label class="block mb-1 font-semibold">지역</label>
                <select name="area" class="border border-green-500 rounded px-2 py-1">
                    <option>서울</option><option>경기</option><option>대전</option><option>부산</option>

                </select>
            </div>

        </div>
    </div>
</div>
</body>
</html>
