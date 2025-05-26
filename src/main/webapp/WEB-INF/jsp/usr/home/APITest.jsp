<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="체육시설" />

<script>
	const API_KEY = '6cb3e79c3e7a3284b2bf0cd85bf1cd6a'; // Encoding된 키

	async function getAirData() {
		const url = 'https://www.eshare.go.kr/eshare-openapi/rsrc/list/010500/'
			+ API_KEY;


		try {
			const response = await fetch(url);
			if (!response.ok) {
				throw new Error(`HTTP 오류! 상태 코드: ${response.status}`);
			}
			const data = await response.json();
			console.log("api 정보:", data);
		} catch (e) {
			console.error("API 호출 실패:", e);
		}
	}
	getAirData();
</script>
