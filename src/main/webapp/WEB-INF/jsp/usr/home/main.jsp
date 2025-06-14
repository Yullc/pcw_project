<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.example.util.RankUtil" %>
<c:set var="pageTitle" value="MEMBER LOGIN" />

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>횡 스크롤 페이지</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.4/tailwind.min.css">
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/login.css">
</head>
<body>
<div id="horizontal-scroll">

	<!-- Page 1 -->
	<section class="page page1"></section>

	<!-- Page 2: 로그인 -->
	<section class="page page2 flex flex-col items-center justify-center min-h-screen px-4">
		<c:if test="${!rq.logined}">
			<h2 class="font-cookie-bold text-3xl font-bold text-white mb-10">로그인</h2>
			<form action="../home/doLogin" method="POST" class="w-full max-w-md">
				<div class="mb-6">
					<input type="text" name="loginId" placeholder="아이디" class="w-full px-6 py-4 bg-gray-200 rounded-lg text-lg" />
				</div>
				<div class="mb-8">
					<input type="password" name="loginPw" placeholder="비밀번호" class="w-full px-6 py-4 bg-gray-200 rounded-lg text-lg" />
				</div>
				<div class="flex justify-between mb-6">
					<button type="button" class="font-cookie-bold px-6 py-3 bg-green-700 text-white text-lg rounded hover:bg-green-800">취소</button>
					<button type="submit" class="font-cookie-bold px-6 py-3 bg-green-800 text-white text-lg rounded hover:bg-green-900 flex items-center">
						<span class="mr-2">⚽</span>로그인<span class="ml-2">⚽</span>
					</button>
				</div>
				<div class="flex justify-center">
					<button onclick="location.href='join'" type="button"
							class="font-cookie-bold w-full bg-green-500 hover:bg-green-600 text-white py-3 text-lg rounded-full font-semibold">
						회원가입
					</button>
				</div>
			</form>
		</c:if>

		<c:if test="${rq.logined}">
			<h2 class="font-cookie-bold text-3xl font-bold text-white mb-10">${rq.loginedMember.nickName}님 환영합니다!</h2>
			<a href="/usr/home/myPage" class="font-cookie-bold px-8 py-4 bg-blue-600 hover:bg-blue-700 text-white rounded-full text-lg">
				마이페이지로 이동 →
			</a>
		</c:if>
	</section>

	<!-- Page 3: 축구/풋살 선택 -->
	<section class="page page3 relative flex items-center justify-center min-h-screen bg-cover bg-center">
		<div class="flex flex-col items-center space-y-8">
			<div class="flex space-x-12">
				<!-- 축구 버튼 -->
				<button onclick="location.href='/usr/scArticle/soccer_menu'" class="flex flex-col items-center">
					<img src="/img/main_soccer.png" alt="축구" class="w-48 h-48 object-cover rounded-lg shadow-lg hover:scale-105 transition-transform duration-300" />
					<span class="mt-4 text-white text-2xl font-semibold">축구</span>
				</button>

				<!-- 풋살 버튼 -->
				<button onclick="location.href='/usr/ftArticle/foot_menu'" class="flex flex-col items-center">
					<img src="/img/main_football.png" alt="풋살" class="w-48 h-48 object-cover rounded-lg shadow-lg hover:scale-105 transition-transform duration-300" />
					<span class="mt-4 text-white text-2xl font-semibold">풋살</span>
				</button>
			</div>
		</div>
	</section>

</div>
<script src="/js/script.js"></script>
</body>
</html>
