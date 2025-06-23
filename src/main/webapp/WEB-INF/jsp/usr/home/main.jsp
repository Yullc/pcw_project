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
	<section class="page page1">
		<div class="relative min-h-screen bg-green-900">
			<div class="absolute inset-0 flex items-center justify-center">
				<div class="text-center text-white px-6">
					<h1 class="text-4xl md:text-6xl font-extrabold mb-6 animate-pulse">
						사람은 안 돌아와도, 공은 돌아옵니다.
					</h1>
					<p class="text-lg md:text-xl font-medium">
						팀원 모집부터 경기 참가까지<br />Vamos에서 한 번에!
					</p>
					<p class="text-sm md:text-base font-extrabold mt-10">
						마우스 휠을 조작해 보세요!
					</p>
				</div>
			</div>
		</div>
	</section>



	<!-- Page 2: 로그인 -->
	<section class="page page2 flex flex-col items-center justify-center min-h-screen bg-green-900 px-4 text-white">
		<c:if test="${!rq.logined}">
			<h2 class="text-3xl font-bold mb-10 tracking-wide">로그인</h2>
			<form action="../home/doLogin" method="POST"
				  class="w-full max-w-md bg-white border border-gray-300 p-10 rounded-2xl shadow-2xl text-black">
				<div class="mb-6">
					<input type="text" name="loginId" placeholder="아이디"
						   class="w-full px-4 py-3 border border-gray-400 text-black placeholder-gray-500 rounded-lg focus:outline-none focus:border-green-600 transition" />
				</div>
				<div class="mb-8">
					<input type="password" name="loginPw" placeholder="비밀번호"
						   class="w-full px-4 py-3 border border-gray-400 text-black placeholder-gray-500 rounded-lg focus:outline-none focus:border-green-600 transition" />
				</div>
				<div class="flex justify-between mb-6">
					<button type="button"
							class="px-6 py-3 border border-gray-500 text-green-900 rounded-lg hover:bg-green-50 transition">
						취소
					</button>
					<button type="submit"
							class="px-6 py-3 bg-green-900 text-white rounded-lg hover:bg-green-800 transition font-semibold">
						로그인
					</button>
				</div>
				<div class="flex justify-center">
					<button onclick="location.href='join'" type="button"
							class="w-full bg-green-900 text-white hover:bg-green-800 py-3 rounded-full transition font-semibold">
						회원가입
					</button>
				</div>
			</form>
		</c:if>

		<c:if test="${rq.logined}">
			<div class="text-center">
				<h2 class="text-2xl mb-6 font-bold">${rq.loginedMember.nickName}님 환영합니다!</h2>
				<div class="flex gap-4 justify-center">
					<a href="/usr/home/myPage"
					   class="px-6 py-3 border-2 border-white text-white rounded-full hover:bg-white hover:text-green-900 transition font-semibold">
						마이페이지
					</a>
					<a href="/usr/member/doLogout"
					   class="px-6 py-3 border-2 border-red-300 text-red-300 rounded-full hover:bg-red-600 hover:text-white transition font-semibold">
						로그아웃
					</a>

				</div>
			</div>
		</c:if>
	</section>


	<!-- Page 3: 경기 종류 선택 또는 로그인 유도 -->
	<section class="page page3 relative flex items-center justify-center min-h-screen bg-green-900 px-4 text-white">
		<c:choose>
			<c:when test="${rq.logined}">
				<div class="flex flex-col items-center justify-center w-full">
					<h2 class="text-3xl font-bold mb-10">경기 종류를 선택하세요.</h2>
					<div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-3xl">
						<!-- 풋살 -->
						<a href="/usr/ftArticle/foot_menu"
						   class="bg-white border-2 border-green-600 rounded-2xl p-8 text-center shadow hover:shadow-xl hover:bg-green-50 transition text-green-900">
							<h3 class="text-2xl font-bold text-green-700 mb-4">풋살</h3>
							<p class="text-gray-700">작은 경기장, 빠른 전개, 짜릿한 승부!</p>
						</a>

						<!-- 축구 -->
						<a href="/usr/scArticle/soccer_menu"
						   class="bg-white border-2 border-blue-600 rounded-2xl p-8 text-center shadow hover:shadow-xl hover:bg-blue-50 transition text-blue-900">
							<h3 class="text-2xl font-bold text-blue-700 mb-4">축구</h3>
							<p class="text-gray-700">넓은 필드에서 펼쳐지는 진짜 축구!</p>
						</a>
					</div>
				</div>
			</c:when>

			<c:otherwise>
				<div class="text-center">
					<h2 class="text-2xl font-bold mb-6">로그인 후 이용할 수 있습니다.</h2>
				</div>
			</c:otherwise>
		</c:choose>
	</section>

</div>
<script src="/js/script.js"></script>
</body>
</html>