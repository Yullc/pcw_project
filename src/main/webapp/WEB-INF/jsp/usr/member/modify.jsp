<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<script type="text/javascript">
    function MemberModify__submit(form) {
        form.loginPw.value = form.loginPw.value.trim();

        if (form.loginPw.value.length > 0) {
            form.loginPwCheck.value = form.loginPwCheck.value.trim();
            if (form.loginPwCheck.value == 0) {
                alert('비번 확인 써');
                return;
            }

            if (form.loginPwCheck.value != form.loginPw.value) {
                alert('비번 불일치');
                return;
            }

        }

        form.submit();
    }
</script>
<body class="min-h-screen flex items-center justify-center bg-white p-10">
<div class="w-full max-w-5xl border rounded-lg shadow p-10 flex gap-20">
    <!-- form 시작 -->
    <form action="/usr/member/doModify" method="post" class="flex-1 space-y-5 flex flex-col">
        <h2 class="text-2xl font-bold text-green-700 mb-4">회원정보 수정</h2>

        <!-- id hidden -->
        <input type="hidden" name="id" value="${rq.loginedMember.id}" />
        
        <div>
            <label class="block mb-1 font-semibold">닉네임</label>
            <input type="text" name="nickName" value="${rq.loginedMember.nickName}" class="w-full border border-green-500 rounded px-4 py-2" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호</label>
            <input class="input w-full border border-green-500 rounded px-4 py-2" name="loginPw" autocomplete="off"
                   type="text" placeholder="새 비밀번호를 입력해" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호 확인</label>

            <input class="input w-full border border-green-500 rounded px-4 py-2" name="loginPwCheck"
                   autocomplete="off" type="text" placeholder="새 비밀번호확인을 입력해" />

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
                <option ${rq.loginedMember.area == '강원' ? 'selected' : ''}>강원</option>
                <option ${rq.loginedMember.area == '인천' ? 'selected' : ''}>인천</option>
                <option ${rq.loginedMember.area == '대전' ? 'selected' : ''}>대전</option>
                <option ${rq.loginedMember.area == '세종' ? 'selected' : ''}>세종</option>
                <option ${rq.loginedMember.area == '충북' ? 'selected' : ''}>충북</option>
                <option ${rq.loginedMember.area == '충남' ? 'selected' : ''}>충남</option>
                <option ${rq.loginedMember.area == '대구' ? 'selected' : ''}>대구</option>
                <option ${rq.loginedMember.area == '경북' ? 'selected' : ''}>경북</option>
                <option ${rq.loginedMember.area == '경남' ? 'selected' : ''}>경남</option>
                <option ${rq.loginedMember.area == '부산' ? 'selected' : ''}>부산</option>
                <option ${rq.loginedMember.area == '울산' ? 'selected' : ''}>울산</option>
                <option ${rq.loginedMember.area == '광주' ? 'selected' : ''}>광주</option>
                <option ${rq.loginedMember.area == '전북' ? 'selected' : ''}>전북</option>
                <option ${rq.loginedMember.area == '전남' ? 'selected' : ''}>전남</option>
                <option ${rq.loginedMember.area == '제주' ? 'selected' : ''}>제주</option>

            </select>
        </div>

        <div>
            <label class="block mb-1 font-semibold">자기소개</label>
            <textarea name="intro" class="w-full border border-green-500 rounded px-4 py-2">${rq.loginedMember.intro}</textarea>
        </div>



        <button type="submit" class="bg-green-600 text-white font-semibold py-2 px-4 rounded hover:bg-green-700">수정 완료</button>
    </form>
</div>
</body>
</html>