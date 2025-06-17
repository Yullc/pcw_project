<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>SMS 테스트</title>
</head>
<body>
<h2>📱 SMS 전송 테스트</h2>

<form method="post" action="/sendSms">
    <label>수신자 번호: <input type="text" name="to" value="01033894452" /></label><br/>
    <label>메시지: <input type="text" name="text" value="테스트 문자입니다!" /></label><br/>
    <button type="submit">전송</button>
</form>

<c:if test="${not empty result}">
    <p><strong>결과:</strong> ${result}</p>
</c:if>

</body>
</html>
