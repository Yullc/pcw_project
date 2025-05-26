<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>공유누리 체육시설</title>
    <link href="https://cdn.tailwindcss.com" rel="stylesheet">
</head>
<body class="p-10">
<h1 class="text-2xl font-bold mb-5">공유누리 체육시설 목록</h1>
<table class="table-auto border w-full">
    <thead class="bg-gray-100">
    <tr>
        <th class="border px-4 py-2">자원명</th>
        <th class="border px-4 py-2">기관명</th>
        <th class="border px-4 py-2">지역</th>
        <th class="border px-4 py-2">분류</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${resources}">
        <tr>
            <td class="border px-4 py-2">${item.rsrcName}</td>
            <td class="border px-4 py-2">${item.insttNm}</td>
            <td class="border px-4 py-2">${item.ctpvNm}</td>
            <td class="border px-4 py-2">${item.rsrcClNm}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
