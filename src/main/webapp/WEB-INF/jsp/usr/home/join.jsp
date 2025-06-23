<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>회원가입</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-700 min-h-screen flex items-center justify-center px-4">
<form id="joinForm" action="../home/doJoin" method="POST"
      onsubmit="return updateBornDate()"
      class="bg-white w-full max-w-5xl rounded-xl shadow-2xl p-10 flex space-x-8 text-black">

    <!-- 왼쪽 영역 -->
    <div class="w-1/2 space-y-5">
        <h1 class="text-4xl font-bold text-black mb-6">Vamos</h1>

        <div>
            <label class="block mb-1 font-semibold">아이디</label>
            <input type="text" name="loginId" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호</label>
            <input type="password" name="loginPw" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">비밀번호 확인</label>
            <input type="password" name="loginPwCheck" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">이름</label>
            <input type="text" name="name" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>
    </div>

    <!-- 오른쪽 영역 -->
    <div class="w-1/2 space-y-5">
        <h2 class="text-2xl font-bold mb-6 text-center">회원가입</h2>

        <div>
            <label class="block mb-1 font-semibold">닉네임</label>
            <input type="text" name="nickName" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">이메일</label>
            <input type="text" name="email" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">전화번호</label>
            <input type="text" name="phoneNumber" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
        </div>

        <div>
            <label class="block mb-1 font-semibold">생년월일</label>
            <div class="flex space-x-2">
                <select id="year" class="border border-gray-300 rounded px-2 py-1"><option>년도</option></select>
                <select id="month" class="border border-gray-300 rounded px-2 py-1"><option>월</option></select>
                <select id="day" class="border border-gray-300 rounded px-2 py-1"><option>일</option></select>
            </div>
            <input type="hidden" name="bornDate" id="bornDate" />
        </div>

        <div class="flex space-x-4">
            <div>
                <label class="block mb-1 font-semibold">지역</label>
                <select name="area" class="border border-gray-300 rounded px-4 py-1">
                    <option>서울</option><option>경기</option><option>부산</option> <!-- 생략 가능 -->
                </select>
            </div>
            <div>
                <label class="block mb-1 font-semibold">성별</label>
                <select name="gender" class="border border-gray-300 rounded px-4 py-1">
                    <option>남자</option><option>여자</option>
                </select>
            </div>
        </div>

        <div class="flex justify-end mt-6">
            <button type="submit"
                    class="bg-green-600 text-white px-10 py-2 rounded-full hover:bg-green-700 transition">
                완료
            </button>
        </div>
    </div>
</form>


<script>
    console.log("아이디:", document.getElementsByClassName('id'));
    const yearSelect = document.getElementById('year');
    const monthSelect = document.getElementById('month');
    const daySelect = document.getElementById('day');
    const bornDateInput = document.getElementById('bornDate');

    for (let y = 1950; y <= new Date().getFullYear(); y++) {
        const option = document.createElement('option');
        option.value = y;
        option.text = y;
        yearSelect.appendChild(option);
    }

    for (let m = 1; m <= 12; m++) {
        const option = document.createElement('option');
        option.value = m.toString().padStart(2, '0');
        option.text = m;
        monthSelect.appendChild(option);
    }

    for (let d = 1; d <= 31; d++) {
        const option = document.createElement('option');
        option.value = d.toString().padStart(2, '0');
        option.text = d;
        daySelect.appendChild(option);
    }

    function updateBornDate() {
        const y = yearSelect.value;
        console.log("year:", y);
        const m = monthSelect.value;
        console.log("month: ", m);
        const d = daySelect.value;
        console.log("day:", d);

        const result = y + "-" + m + "-" + d;
        console.log(result);
        bornDateInput.value = result;
        console.log("✅ 생년월일 조합:", result);
        return true;
    }


    document.getElementById("joinForm").addEventListener("submit", function () {
        updateBornDate();
    });

    yearSelect.addEventListener('change', updateBornDate);
    monthSelect.addEventListener('change', updateBornDate);
    daySelect.addEventListener('change', updateBornDate);
</script>
</body>
</html>