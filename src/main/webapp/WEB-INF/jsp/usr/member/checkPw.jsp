<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 수정</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-white p-10">
<div class="w-full max-w-5xl border rounded-lg shadow p-10 flex gap-20">
  <!-- form 시작 -->
  <form action="/usr/member/doModifyPw" method="post" class="flex-1 space-y-5 flex flex-col">
    <h2 class="text-2xl font-bold text-green-700 mb-4">비밀번호 수정</h2>

    <div>
      <label class="block mb-1 font-semibold">현재 비밀번호</label>
      <input type="password" name="loginPw" placeholder="현재 비밀번호를 입력하세요" class="w-full border border-green-500 rounded px-4 py-2" required />
    </div>

    <div>
      <label class="block mb-1 font-semibold">새 비밀번호</label>
      <input type="password" name="newLoginPw" placeholder="새 비밀번호를 입력하세요" class="w-full border border-green-500 rounded px-4 py-2" required />
    </div>

    <div>
      <label class="block mb-1 font-semibold">새 비밀번호 확인</label>
      <input type="password" name="newLoginPwConfirm" placeholder="새 비밀번호를 다시 입력하세요" class="w-full border border-green-500 rounded px-4 py-2" required />
    </div>

    <button type="submit" class="bg-green-600 text-white font-semibold py-2 px-6 rounded hover:bg-green-700">수정 완료</button>
  </form>

</div>
</body>
</html>
