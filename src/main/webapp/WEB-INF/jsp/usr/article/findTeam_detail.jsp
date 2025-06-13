<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>팀 모집 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex justify-center p-10">

<div class="max-w-3xl w-full bg-white rounded-xl shadow-2xl overflow-hidden">
    <!-- 상세 정보 카드 -->
    <div class="p-6 space-y-4">
        <div class="text-sm text-gray-500">📅 등록일: ${teamArticle.regDate}</div>

        <h1 class="text-2xl font-bold text-green-700">${teamArticle.title}</h1>

        <div class="text-gray-700 whitespace-pre-line border-t border-b py-4">
            ${teamArticle.body}
        </div>

        <div class="flex flex-col md:flex-row justify-between items-start md:items-center text-sm text-gray-600 gap-2 border-t pt-4">
            <div>
                👤 <span class="font-semibold">작성자</span>: ${teamArticle.extra__writer}
            </div>
            <div>
                📍 <span class="font-semibold">지역</span>: ${teamArticle.area}
            </div>
            <div>
                🎖️ <span class="font-semibold">팀 레벨</span>: ${teamArticle.avgLevelName}
            </div>
        </div>

        <!-- ✅ 작성자일 경우에만 수정/삭제 버튼 노출 -->
        <c:if test="${rq.loginedMemberId == teamArticle.memberId}">
            <div class="pt-4 flex justify-end space-x-2">
                <a href="/usr/reply/doModify?id=${teamArticle.id}"
                   class="text-sm text-white bg-yellow-500 hover:bg-yellow-600 px-4 py-2 rounded-full">
                    ✏️ 수정
                </a>
                <a href="/usr/reply/doDelete?id=${teamArticle.id}"
                   onclick="return confirm('정말 삭제하시겠습니까?');"
                   class="text-sm text-white bg-red-500 hover:bg-red-600 px-4 py-2 rounded-full">
                    🗑️ 삭제
                </a>
            </div>
        </c:if>
        <!-- 댓글 영역 -->
        <!-- 댓글 작성 폼 -->
        <c:if test="${rq.isLogined()}">
            <form action="/usr/reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;" class="mt-10 space-y-4">
                <input type="hidden" name="relTypeCode" value="teamArticle" />
                <input type="hidden" name="relId" value="${teamArticle.id}" />

                <textarea name="body" rows="3"
                          class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                          placeholder="댓글을 입력하세요"></textarea>

                <div class="text-right">
                    <button type="submit"
                            class="bg-green-600 text-white px-6 py-2 rounded-full hover:bg-green-700 transition">
                        댓글 작성
                    </button>
                </div>
            </form>
        </c:if>

        <c:if test="${!rq.isLogined()}">
            <div class="text-gray-500 mt-8 text-center">
                댓글을 작성하려면
                <a href="${rq.loginUri}" class="text-green-600 font-semibold hover:underline">로그인</a>
                이 필요합니다.
            </div>
        </c:if>


        <!-- 댓글 리스트 -->
        <div class="mt-8 space-y-4">
            <c:forEach var="reply" items="${replies}">
                <div id="reply-${reply.id}" class="bg-gray-100 rounded p-2 my-2">

                    <div class="flex justify-between items-start">
                        <div class="text-sm text-gray-700">
                            <strong>${reply.extra__writer}</strong>
                            <span class="ml-2">${reply.body}</span>
                        </div>

                        <c:if test="${rq.loginedMemberId == reply.memberId}">
                            <div class="space-x-2 text-right">
                                <button class="text-yellow-600 text-sm font-semibold edit-btn" data-id="${reply.id}" data-body="${reply.body}">
                                    ✏️ 수정
                                </button>
                                <form action="/usr/reply/doDelete" method="post" class="inline">
                                    <input type="hidden" name="id" value="${reply.id}" />
                                    <button type="submit" class="text-red-600 text-sm font-semibold">🗑 삭제</button>
                                </form>
                            </div>
                        </c:if>
                    </div>

                    <!-- ✅ 숨겨진 수정 폼 -->
                    <form action="/usr/reply/doModify" method="post" class="edit-form mt-2 hidden" id="edit-form-${reply.id}">
                        <input type="hidden" name="id" value="${reply.id}" />
                        <textarea name="body" class="w-full p-2 border rounded text-sm">${reply.body}</textarea>
                        <div class="text-right mt-1">
                            <button type="submit" class="bg-green-500 text-white text-sm px-3 py-1 rounded">💾 저장</button>
                            <button type="button" class="cancel-btn text-gray-500 text-sm ml-2" data-id="${reply.id}">취소</button>
                        </div>
                    </form>
                </div>
            </c:forEach>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const editButtons = document.querySelectorAll(".edit-btn");
                const cancelButtons = document.querySelectorAll(".cancel-btn");

                editButtons.forEach(btn => {
                    btn.addEventListener("click", function () {
                        const id = this.dataset.id;
                        const replyDiv = document.getElementById("reply-" + id);
                        const editForm = document.getElementById("edit-form-" + id);

                        // 기존 댓글 텍스트 숨기기
                        replyDiv.querySelector("span").style.display = "none";
                        this.style.display = "none";

                        // 수정 폼 보여주기
                        editForm.classList.remove("hidden");
                    });
                });

                cancelButtons.forEach(btn => {
                    btn.addEventListener("click", function () {
                        const id = this.dataset.id;
                        const replyDiv = document.getElementById("reply-" + id);
                        const editForm = document.getElementById("edit-form-" + id);

                        // 댓글 텍스트 다시 보이기
                        replyDiv.querySelector("span").style.display = "inline";
                        replyDiv.querySelector(".edit-btn").style.display = "inline";

                        // 수정 폼 숨기기
                        editForm.classList.add("hidden");
                    });
                });
            });
        </script>

        <!-- 뒤로가기 버튼 -->
        <div class="pt-4 text-right">
            <a href="/usr/article/findTeam" class="text-sm text-white bg-green-600 hover:bg-green-700 px-4 py-2 rounded-full">
                ← 목록으로
            </a>
        </div>
    </div>
</div>
<!-- 댓글 영역 -->



<script>
    function ReplyWrite__submit(form) {
        form.body.value = form.body.value.trim();

        if (form.body.value.length < 3) {
            alert("댓글은 3글자 이상 입력해주세요.");
            form.body.focus();
            return;
        }

        form.submit();
    }

    function toggleModifybtn(replyId) {
        document.querySelector(`#reply-${replyId}`).style.display = "none";
        document.querySelector(`#modify-form-${replyId}`).classList.remove("hidden");
        document.querySelector(`#modify-btn-${replyId}`).classList.add("hidden");
        document.querySelector(`#save-btn-${replyId}`).classList.remove("hidden");
    }

    function doModifyReply(replyId) {
        document.querySelector(`#modify-form-${replyId}`).submit();
    }
</script>

</body>
</html>