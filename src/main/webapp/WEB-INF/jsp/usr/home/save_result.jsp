<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>자원 저장 결과</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 p-10">
<div class="max-w-xl mx-auto bg-white rounded shadow p-6 text-center">
  <h1 class="text-2xl font-bold mb-4">공유누리 자원 저장 결과</h1>

  <c:choose>
    <c:when test="${not empty error}">
      <p class="text-red-600 font-semibold">${error}</p>
    </c:when>
    <c:otherwise>
      <p class="text-green-700 font-medium mb-2">
        ✅ 축구장 <strong>${footballCount}</strong>개 저장 완료
      </p>
      <p class="text-green-700 font-medium mb-4">
        ✅ 풋살장 <strong>${futsalCount}</strong>개 저장 완료
      </p>
    </c:otherwise>
  </c:choose>

  <a href="/usr/home/api" class="inline-block mt-6 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
    목록 보기로 이동
  </a>
</div>
</body>
</html>
