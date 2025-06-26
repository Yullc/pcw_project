<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
    <title>${nickName}님의 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- jQuery CDN (head나 script 위에 넣어야 함) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-white min-h-screen">
<header class="bg-white border-b border-gray-300 h-20">
    <div class="max-w-6xl h-full flex items-center px-6 justify-start ml-20">
        <a href="/usr/home/main">
            <img src="/img/Logo_V.png" alt="로고" class="h-12 object-contain" />
        </a>
    </div>
</header>

<!-- ✅ 페이지 컨텐츠 영역 -->
<div class="px-[150px] pt-10">
    <!-- 메인 컨테이너 -->
    <div class="flex flex-col lg:flex-row gap-8 ml-20">
        <!-- ✅ 좌측 프로필 전체 영역 -->
        <div class="w-full lg:w-1/3 space-y-6">
            <!-- ✅ 프로필 보기 영역 (업로드 제거) -->
            <div class="border rounded-xl p-6 flex flex-col items-center gap-3 shadow">
                <img src="${profileImg}?v=<%= System.currentTimeMillis() %>" class="w-32 h-32 rounded-full object-cover" alt="프로필 이미지" />
                <div class="text-xl font-semibold">${nickName}</div>
                <c:if test="${rq.loginedMember.nickName ne nickName}">
                    <button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${id})">
                        ❤ 좋아요 <span class="likeCount">${likeCount}</span>
                    </button>

                </c:if>
                <script>
                    function doGoodReaction(toMemberId) {
                        $.ajax({
                            url: '/usr/reactionPoint/doGoodReaction',
                            type: 'POST',
                            data: {
                                toMemberId: toMemberId
                            },
                            dataType: 'json',
                            success: function(data) {
                                console.log("👍 AJAX 성공");
                                console.log("전체 응답:", data);

                                const goodRP = data.data1; // ✅ 변경된 포인트

                                if (goodRP === undefined) {
                                    console.error("❌ 좋아요 수가 응답에 없습니다.");
                                    return;
                                }

                                console.log("좋아요 수:", goodRP);

                                if (data.resultCode === 'S-1') {
                                    const btn = $('#likeButton');
                                    const likeCountEl = $('.likeCount');

                                    likeCountEl.text(goodRP); // 좋아요 수 업데이트

                                    if (btn.hasClass('btn-outline')) {
                                        btn.removeClass('btn-outline').addClass('btn-active');
                                    } else {
                                        btn.removeClass('btn-active').addClass('btn-outline');
                                    }
                                } else {
                                    alert(data.msg);
                                }
                            },
                            error: function(xhr, status, error) {
                                console.error("❌ AJAX 오류:", status, error);
                                alert("좋아요 처리 중 오류 발생: " + status);
                            }
                        });
                    }
                </script>
                <div class="text-3xl">${mannerEmoji}</div>
            </div>
        </div>

        <!-- ✅ 우측 정보 및 경기 목록 -->
        <div class="w-full lg:w-2/3 space-y-6 pl-12">
            <!-- 최근 풋살 경기 -->
            <div>
                <h2 class="text-md font-bold text-green-700">최근 풋살 경기</h2>
                <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
                    <c:forEach var="game" items="${recentGames}">
                        <div class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md">
                            <img src="${game.img}" class="w-full h-28 object-cover rounded-t-lg" />
                            <div class="p-2 text-sm">
                                <div class="font-semibold">${game.stadium}</div>
                                <div class="text-gray-500">${game.playDate}</div>
                                <div class="text-gray-700">${game.title}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${empty recentGames}">
                    <div class="text-sm text-gray-400">참가한 경기가 없습니다.</div>
                </c:if>
            </div>

            <!-- 최근 축구 경기 -->
            <div>
                <h2 class="text-md font-bold text-green-700">최근 축구 경기</h2>
                <div class="flex overflow-x-auto gap-4 mt-2 pb-4">
                    <c:forEach var="game" items="${recentSoccerGames}">
                        <div class="flex-shrink-0 w-48 bg-white rounded-lg shadow-md">
                            <img src="${game.img}" class="w-full h-28 object-cover rounded-t-lg" />
                            <div class="p-2 text-sm">
                                <div class="font-semibold">${game.stadium}</div>
                                <div class="text-gray-500">${game.playDate}</div>
                                <div class="text-gray-700">${game.title}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${empty recentSoccerGames}">
                    <div class="text-sm text-gray-400">참가한 축구 경기가 없습니다.</div>
                </c:if>
            </div>

            <!-- 팀/레벨 -->
            <div class="flex gap-4">
                <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">팀: ${teamNm}</div>
                <div class="bg-green-600 text-white rounded-full px-4 py-1 font-semibold">레벨: ${rank}</div>
            </div>

            <!-- 자기소개 -->
            <div>
                <div class="font-bold mb-1">자기소개</div>
                <textarea class="w-full h-24 border rounded p-2" readonly>${intro}</textarea>
            </div>
        </div>
    </div>
</div>
</body>
</html>
