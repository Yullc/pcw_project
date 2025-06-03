<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>풋살 매칭 UI (Tailwind)</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="h-screen flex flex-col">
<!-- Header -->
<header class="flex items-center justify-between p-5 border-b border-gray-300">
    <div class="text-2xl font-bold text-green-700">로고</div>
    <div class="flex-1 mx-5 relative">
        <input type="text" placeholder="검색..." class="w-full pl-4 pr-10 py-2 rounded-full border border-gray-300">
        <span class="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-500">🔍</span>
    </div>
    <div class="flex items-center gap-4">
        <span>용병 구하기</span>
        <span>팀 구하기</span>
        <img src="/img/pcw.jpeg" alt="profile" class="w-10 h-10 rounded-full">
    </div>
</header>

<!-- Main Layout -->
<div class="flex flex-1 overflow-hidden">
    <!-- Filter Section -->
    <aside class="w-56 p-5 border-r border-gray-300 space-y-6 overflow-y-auto">
        <div>
            <h2 class="font-bold mb-2">지역</h2>
            <div class="flex flex-wrap gap-2">
                <button class="border border-gray-300 px-3 py-1 rounded-full">서울</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">경기</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">강원</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">인천</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">대전</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">세종</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">충북</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">충남</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">대구</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">경북</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">경남</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">부산</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">광주</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">전북</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">울산</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">전남</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">제주</button>
            </div>
        </div>
        <div>
            <h2 class="font-bold mb-2">레벨</h2>
            <div class="flex flex-wrap gap-2">
                <button class="border border-gray-300 px-3 py-1 rounded-full">루키</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">아마추어</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">세미프로</button>
                <button class="border border-gray-300 px-3 py-1 rounded-full">프로</button>
            </div>
        </div>
    </aside>

    <!-- Card Content Section -->
    <main class="flex-1 overflow-x-auto p-5">
        <div class="flex gap-5 w-max">
            <!-- 카드 예시 -->
            <div class="w-48 flex-shrink-0 border border-gray-300 rounded-lg overflow-hidden flex flex-col">
                <img src="/img/sta.jpg" alt="경기장" class="w-full h-32 object-cover">
                <div class="p-2 text-sm">
                    <div class="font-semibold">0000 경기장</div>
                    <div>평균 레벨: 아마추어2</div>
                    <div>05-22 20:00</div>
                </div>
            </div>
            <!-- 복제 카드 -->
            <div class="w-48 flex-shrink-0 border border-gray-300 rounded-lg overflow-hidden flex flex-col">
                <img src="/img/sta.jpg" alt="경기장" class="w-full h-32 object-cover">
                <div class="p-2 text-sm">
                    <div class="font-semibold">0000 경기장</div>
                    <div>평균 레벨: 아마추어2</div>
                    <div>05-22 20:00</div>
                </div>
            </div>
            <div class="w-48 flex-shrink-0 border border-gray-300 rounded-lg overflow-hidden flex flex-col">
                <img src="/img/sta.jpg" alt="경기장" class="w-full h-32 object-cover">
                <div class="p-2 text-sm">
                    <div class="font-semibold">0000 경기장</div>
                    <div>평균 레벨: 아마추어2</div>
                    <div>05-22 20:00</div>
                </div>
            </div>
            <div class="w-48 flex-shrink-0 border border-gray-300 rounded-lg overflow-hidden flex flex-col">
                <img src="/img/sta.jpg" alt="경기장" class="w-full h-32 object-cover">
                <div class="p-2 text-sm">
                    <div class="font-semibold">0000 경기장</div>
                    <div>평균 레벨: 아마추어2</div>
                    <div>05-22 20:00</div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>

</html>