<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>공유누리 체육시설</title>
    <link href="https://cdn.tailwindcss.com" rel="stylesheet">
</head>
<body class="p-10">
<h1 class="text-2xl font-bold mb-5">공유누리 체육시설 전체 정보</h1>

<table class="table-auto border w-full text-sm">
    <thead class="bg-gray-100">
    <tr>
        <th class="border px-2 py-1">자원번호</th>
        <th class="border px-2 py-1">자원명</th>

        <th class="border px-2 py-1">주소</th>
        <th class="border px-2 py-1">상세주소</th>

        <th class="border px-2 py-1">이미지</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${resources}">
        <tr>
            <td class="border px-2 py-1">${item.rsrcNo}</td>
            <td class="border px-2 py-1">${item.rsrcNm}</td>

            <td class="border px-2 py-1">${item.addr}</td>
            <td class="border px-2 py-1">${item.daddr}</td>


            <td class="border px-2 py-1">
                <c:if test="${not empty item.imgFileUrlAddr}">
                    <img src="${item.imgFileUrlAddr}" alt="이미지" width="100" />
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
