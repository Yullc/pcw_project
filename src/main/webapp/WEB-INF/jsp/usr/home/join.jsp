<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>회원가입</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-green-900 min-h-screen flex items-center justify-center px-4">
<form id="joinForm" action="../home/doJoin" method="POST" class="overflow-hidden w-full max-w-5xl bg-white rounded-xl shadow-2xl text-black relative">

    <!-- 슬라이더 컨테이너 -->
    <div id="slider" class="flex transition-transform duration-700 ease-in-out w-[200%]">

        <!-- 1단계 -->
        <div class="w-1/2 p-10 flex space-x-8 items-center">
            <!-- 왼쪽: 회원정보 입력 -->
            <div class="w-1/2 space-y-5">
                <h1 class="text-4xl font-bold text-black mb-6">Vamos</h1>

                <!-- 아이디, 비밀번호 등 -->
                <div>
                    <label class="block mb-1 font-semibold">아이디</label>
                    <input type="text" name="loginId" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                </div>

                <div>
                    <label class="block mb-1 font-semibold">비밀번호</label>
                    <input type="password" name="loginPw" id="loginPw" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                    <p id="pwError" class="text-sm text-red-500 mt-1 hidden">비밀번호는 8~20자이며 특수문자를 포함해야 합니다.</p>
                </div>

                <div>
                    <label class="block mb-1 font-semibold">비밀번호 확인</label>
                    <input type="password" name="loginPwCheck" id="loginPwCheck" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                    <p id="pwCheckError" class="text-sm text-red-500 mt-1 hidden">비밀번호가 일치하지 않습니다.</p>
                </div>


                <div>
                    <label class="block mb-1 font-semibold">이름</label>
                    <input type="text" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                </div>

                <div class="flex justify-end">
                    <button type="button" id="nextBtn"
                            class="bg-green-600 text-white px-6 py-2 rounded-full hover:bg-green-700">
                        다음
                    </button>
                </div>
            </div>


            <!-- 오른쪽: 이미지 -->
            <div class="w-1/2 flex justify-center items-center">
                <img src="/img/joinImg2.jpg" alt="가입 이미지"
                     class="w-full h-[600px] object-cover rounded-lg shadow" />
            </div>
        </div>

        <!-- 2단계 -->
        <div class="w-1/2 p-10 flex space-x-8 items-center">
            <!-- 왼쪽: 이미지 영역 -->
            <div class="w-1/2 flex justify-center items-center h-[600px]">
                <img src="/img/join3.jpg" alt="가입 이미지"
                     class="w-full h-full object-cover rounded-lg shadow" />
            </div>

            <!-- 오른쪽: 추가 정보 입력 -->
            <div class="w-1/2 flex flex-col justify-between h-full">

                <!-- 상단: 입력 필드 -->
                <div class="space-y-5">
                    <h2 class="text-2xl font-bold mb-6 text-center">VAMOS</h2>

                    <div>
                        <label class="block mb-1 font-semibold">닉네임</label>
                        <input type="text" name="nickName" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                    </div>

                    <div>
                        <label class="block mb-1 font-semibold">이메일</label>
                        <input type="text" name="email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
                    </div>

                    <div>
                        <label class="block mb-1 font-semibold">전화번호</label>
                        <input type="text" name="phoneNumber" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-500" />
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
                            <option>서울</option><option>경기</option><option>강원</option><option>인천</option><option>대전</option>
                            <option>세종</option><option>충북</option><option>충남</option><option>대구</option><option>경북</option>
                            <option>경남</option><option>부산</option><option>울산</option><option>광주</option><option>전북</option>
                            <option>전남</option><option>제주</option>
                        </select>
                    </div>
                    <div>
                        <label class="block mb-1 font-semibold">성별</label>
                        <select name="gender" class="border border-gray-300 rounded px-4 py-1">
                            <option>남자</option><option>여자</option>
                        </select>
                    </div>
                </div>
                </div>

            <div class="flex justify-end">
                <button type="submit"
                        class="bg-green-600 text-white px-10 py-2 rounded-full hover:bg-green-700">
                    완료
                </button>
            </div>
            </div>
        </div>
    </div>
</form>

<script>
    // 슬라이드 처리
    const slider = document.getElementById("slider");
    const nextBtn = document.getElementById("nextBtn");

    nextBtn.addEventListener("click", function () {
        if (validateJoinForm()) {
            slider.style.transform = "translateX(-50%)";
        }
    });
</script>

<script>
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


    // 비밀번호 유효성 검사 + 일치 확인
    function validateJoinForm() {
        const pw = document.getElementById("loginPw").value;
        const pwCheck = document.getElementById("loginPwCheck").value;
        const pwError = document.getElementById("pwError");
        const pwCheckError = document.getElementById("pwCheckError");

        let valid = true;

        // 비밀번호 유효성 검사 (8~20자 + 특수문자)
        const pwRegex = /^(?=.*[!@#$%^&*(),.?":{}|<>])[^\s]{8,20}$/;
        if (!pwRegex.test(pw)) {
            pwError.classList.remove("hidden");
            valid = false;
        } else {
            pwError.classList.add("hidden");
        }

        // 비밀번호 일치 확인
        if (pw !== pwCheck) {
            pwCheckError.classList.remove("hidden");
            valid = false;
        } else {
            pwCheckError.classList.add("hidden");
        }

        return valid;
    }

    // 최종 제출 처리
    document.getElementById("joinForm").addEventListener("submit", function (e) {
        const isBirthValid = updateBornDate();
        const isPwValid = validateJoinForm();

        if (!isBirthValid || !isPwValid) {
            e.preventDefault(); // 폼 제출 막기
        }
    });

    // 선택 변경 시 즉시 반영
    yearSelect.addEventListener('change', updateBornDate);
    monthSelect.addEventListener('change', updateBornDate);
    daySelect.addEventListener('change', updateBornDate);
</script>

</body>
</html>