<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.4.18/dist/full.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-white flex flex-col items-center justify-center min-h-screen">
<h1 class="text-4xl font-bold text-green-700 mb-8">로그</h1>

<div class="flex flex-col items-center">
    <h2 class="text-2xl font-bold text-red-400 mb-6">로그인</h2>

    <form class="w-72">
        <div class="mb-4">
            <input type="text" placeholder="아이디" class="input input-bordered w-full bg-gray-200" />
        </div>
        <div class="mb-6">
            <input type="password" placeholder="비밀번호" class="input input-bordered w-full bg-gray-200" />
        </div>

        <div class="flex justify-between">
            <button type="button" class="btn bg-green-800 text-white hover:bg-green-900">취소</button>
            <button type="submit" class="btn bg-green-700 text-white hover:bg-green-800">
                <span class="mr-1">⚽</span>로그인<span class="ml-1">⚽</span>
            </button>
        </div>
    </form>
</div>
</body>
</html>