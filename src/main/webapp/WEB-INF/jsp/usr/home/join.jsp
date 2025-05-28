
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>회원가입</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="bg-white w-full max-w-4xl rounded-xl shadow-lg p-10 flex">

    <!-- 왼쪽 영역 (로고 + 입력 폼 왼쪽) -->
    <div class="w-1/2 pr-8">
        <h1 class="text-4xl font-bold text-green-700 mb-12">로고</h1>

        <form action="/usr/home/doJoin" method="POST" class="space-y-4">
            <div>
                <label class="block mb-1 font-semibold">아이디</label>
                <input type="text" name="loginId" required class="w-full px-4 py-2 border border-green-500 rounded-full bg-red-50" />
            </div>
            <div>
                <label class="block mb-1 font-semibold">비밀번호</label>
                <input type="password" name="loginPw" required class="w-full px-4 py-2 border border-green-500 rounded-full bg-red-50" />
            </div>
            <div>
                <label class="block mb-1 font-semibold">비밀번호 확인</label>
                <input type="password" name="loginPwConfirm" required class="w-full px-4 py-2 border border-green-500 rounded-full bg-red-50" />
            </div>
    </div>

    <!-- 오른쪽 영역 (전화번호 ~ 버튼) -->
    <div class="w-1/2 pl-8">
        <h2 class="text-2xl font-bold mb-10 text-center">회원가입</h2>

        <div class="space-y-4">
            <div>
                <label class="block mb-1 font-semibold">전화번호</label>
                <input type="text" name="phone" required class="w-full px-4 py-2 border border-green-500 rounded-full bg-red-50" />
            </div>

            <div>
                <label class="block mb-1 font-semibold">생년월일</label>
                <div class="flex space-x-2">
                    <select id="year" class="border border-green-500 rounded px-2 py-1">
                        <option>년도</option>
                    </select>
                    <select id="month" class="border border-green-500 rounded px-2 py-1">
                        <option>월</option>
                    </select>
                    <select id="day" class="border border-green-500 rounded px-2 py-1">
                        <option>일</option>
                    </select>
                </div>
                <!-- 조합된 날짜가 담길 input -->
                <input type="hidden" name="bornDate" id="bornDate" />
            </div>

            <script>
                const yearSelect = document.getElementById('year');
                const monthSelect = document.getElementById('month');
                const daySelect = document.getElementById('day');
                const bornDateInput = document.getElementById('bornDate');

                // 년도 옵션 생성 (1950~2025)
                for (let y = 1950; y <= new Date().getFullYear(); y++) {
                    const option = document.createElement('option');
                    option.value = y;
                    option.text = y;
                    yearSelect.appendChild(option);
                }

                // 월 옵션 생성 (1~12)
                for (let m = 1; m <= 12; m++) {
                    const option = document.createElement('option');
                    option.value = m.toString().padStart(2, '0');
                    option.text = m;
                    monthSelect.appendChild(option);
                }

                // 일 옵션 생성 (1~31)
                for (let d = 1; d <= 31; d++) {
                    const option = document.createElement('option');
                    option.value = d.toString().padStart(2, '0');
                    option.text = d;
                    daySelect.appendChild(option);
                }

                // 변경될 때마다 bornDate에 값 넣기
                function updateBornDate() {
                    const y = yearSelect.value;
                    const m = monthSelect.value;
                    const d = daySelect.value;

                    if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                        bornDateInput.value = `${y}-${m}-${d}`;
                    }
                }

                yearSelect.addEventListener('change', updateBornDate);
                monthSelect.addEventListener('change', updateBornDate);
                daySelect.addEventListener('change', updateBornDate);
            </script>


            <div class="flex space-x-4">
                <div>
                    <label class="block mb-1 font-semibold">지역</label>
                    <select name="area" class="border border-green-500 rounded px-4 py-1 bg-white text-green-700">
                        <option>서울</option>
                        <option>부산</option>
                        <option>대전</option>
                        <!-- 추가 -->
                    </select>
                </div>

                <div>
                    <label class="block mb-1 font-semibold">성별</label>
                    <select name="gender" class="border border-green-500 rounded px-4 py-1 bg-white text-green-700">
                        <option>남자</option>
                        <option>여자</option>
                    </select>
                </div>
            </div>

            <div class="mt-6 text-center">
                <button type="submit" class="bg-green-500 text-white px-10 py-2 rounded-full hover:bg-green-600 transition">
                    완료
                </button>
            </div>
        </div>

        </form>
    </div>
</div>
</body>
</html>

