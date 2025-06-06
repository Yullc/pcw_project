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
    <!-- form 시작 -->
    <form action="/usr/member/doModify" method="post" class="flex-1 space-y-5 flex flex-col">
        <h2 class="text-2xl font-bold text-green-700 mb-4">회원정보 수정</h2>

        <!-- id hidden -->
        <input type="hidden" name="id" value="${rq.loginedMember.id}" />



        <div>
            <label class="block mb-1 font-semibold">이름</label>
            <input type="text" name="name" value="${rq.loginedMember.name}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>



        <div>
            <label class="block mb-1 font-semibold">닉네임</label>
            <input type="text" name="nickName" value="${rq.loginedMember.nickName}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">전화번호</label>
            <input type="text" name="phoneNumber" value="${rq.loginedMember.phoneNumber}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">이메일</label>
            <input type="text" name="email" value="${rq.loginedMember.email}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">지역</label>
            <select name="area" class="border border-green-500 rounded px-2 py-1 w-full">
                <option ${rq.loginedMember.area == '서울' ? 'selected' : ''}>서울</option>
                <option ${rq.loginedMember.area == '경기' ? 'selected' : ''}>경기</option>
                <option ${rq.loginedMember.area == '대전' ? 'selected' : ''}>대전</option>
                <option ${rq.loginedMember.area == '부산' ? 'selected' : ''}>부산</option>
            </select>
        </div>

        <div>
            <label class="block mb-1 font-semibold">자기소개</label>
            <textarea name="intro" class="w-full border border-green-500 rounded px-4 py-2">${rq.loginedMember.intro}</textarea>
        </div>


        <a href="/usr/member/checkPw?id=${id}" class="bg-green-600 hover:bg-green-500 text-white font-semibold py-2 px-4 rounded-full">
            회원정보 수정
        </a>

        <button type="submit" class="bg-green-600 text-white font-semibold py-2 px-6 rounded hover:bg-green-700">수정 완료</button>
    </form>
</div>
</body>
</html>
