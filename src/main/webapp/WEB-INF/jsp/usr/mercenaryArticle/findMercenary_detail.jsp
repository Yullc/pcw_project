<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>용병 모집 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex justify-center p-10">

<div class="max-w-3xl w-full bg-white rounded-xl shadow-2xl overflow-hidden">
    <!-- 상세 정보 카드 -->
    <div class="p-6 space-y-4">
        <div class="text-sm text-gray-500">📅 등록일: ${mercenaryArticle.regDate}</div>

        <h1 class="text-2xl font-bold text-green-700">${mercenaryArticle.title}</h1>

        <div class="text-gray-700 whitespace-pre-line border-t border-b py-4">
            ${mercenaryArticle.body}
        </div>

        <div class="flex flex-col md:flex-row justify-between items-start md:items-center text-sm text-gray-600 gap-2 border-t pt-4">
            <div>
                👤 작성자 <a href="/usr/home/yourPage?nickName=${mercenaryArticle.extra__writer}" class="font-semibold hover:underline">
                ${mercenaryArticle.extra__writer}
            </a>
            </div>
            <div>
                📍 <span class="font-semibold">지역</span>: ${mercenaryArticle.area}
            </div>
            <div>
                🎖️ <span class="font-semibold">레벨</span>: ${mercenaryArticle.avgLevelName}
            </div>
        </div>

        <!-- ✅ 작성자일 경우에만 수정/삭제 버튼 노출 -->
        <c:if test="${rq.loginedMemberId == mercenaryArticle.memberId}">
            <div class="pt-4 flex justify-end space-x-2">
                <a href="/usr/mercenaryArticle/modify?id=${mercenaryArticle.id}"
                   class="text-sm text-white bg-yellow-500 hover:bg-yellow-600 px-4 py-2 rounded-full">
                    ✏️ 수정
                </a>
                <a href="/usr/mercenaryArticle/doDelete?id=${mercenaryArticle.id}"
                   onclick="return confirm('정말 삭제하시겠습니까?');"
                   class="text-sm text-white bg-red-500 hover:bg-red-600 px-4 py-2 rounded-full">
                    🗑️ 삭제
                </a>
            </div>
        </c:if>
        <!-- 댓글 영역 -->
        <!-- 댓글 작성 폼 -->
        <c:if test="${rq.isLogined()}">
            <form action="/usr/mercenaryReply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;"
                  class="mt-10 space-y-4">
                <input type="hidden" name="relTypeCode" value="mercenaryArticle"/>
                <input type="hidden" name="relId" value="${mercenaryArticle.id}"/>

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
                            <span class="ml-2 reply-body">${reply.body}</span>
                        </div>

                        <c:if test="${rq.loginedMemberId == reply.memberId}">
                            <div class="space-x-2 text-right">
                                <button type="button"
                                        class="text-yellow-600 text-sm font-semibold edit-btn"
                                        data-id="${reply.id}">
                                    ✏️ 수정
                                </button>
                                <form action="/usr/mercenaryReply/doDelete" method="post" class="inline">
                                    <input type="hidden" name="id" value="${reply.id}"/>
                                    <button type="submit" class="text-red-600 text-sm font-semibold">🗑 삭제</button>
                                </form>
                            </div>
                        </c:if>
                    </div>

                    <!-- ✅ 숨겨진 수정 폼 -->
                    <form onsubmit="submitReplyModify(event, '${reply.id}')"
                          class="edit-form mt-2 hidden"
                          id="edit-form-${reply.id}">
                        <input type="hidden" name="id" value="${reply.id}"/>
                        <textarea name="body"
                                  class="reply-textarea w-full p-2 border rounded text-sm">${reply.body}</textarea>
                        <div class="text-right mt-1">
                            <button type="submit" class="bg-green-500 text-white text-sm px-3 py-1 rounded">💾 저장
                            </button>
                            <button type="button" class="cancel-btn text-gray-500 text-sm ml-2" data-id="${reply.id}">
                                취소
                            </button>
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

                        // 본문 숨기기, 폼 보이기
                        replyDiv.querySelector("span.reply-body").style.display = "none";
                        this.style.display = "none";
                        editForm.classList.remove("hidden");
                    });
                });

                cancelButtons.forEach(btn => {
                    btn.addEventListener("click", function () {
                        const id = this.dataset.id;
                        const replyDiv = document.getElementById("reply-" + id);
                        const editForm = document.getElementById("edit-form-" + id);

                        // 본문 보이기, 폼 숨기기
                        replyDiv.querySelector("span.reply-body").style.display = "inline";
                        replyDiv.querySelector(".edit-btn").style.display = "inline";
                        editForm.classList.add("hidden");
                    });
                });
            });

            // ✅ AJAX 댓글 수정 함수
            function submitReplyModify(event, replyId) {
                event.preventDefault();

                const form = document.getElementById("edit-form-" + replyId);
                const textArea = form.querySelector(".reply-textarea");
                const newBody = textArea.value.trim();

                if (newBody.length < 3) {
                    alert("댓글은 3글자 이상이어야 합니다.");
                    textArea.focus();
                    return;
                }

                fetch("/usr/mercenaryReply/doModify", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: "id=" + replyId + "&body=" + encodeURIComponent(newBody)

                })
                    .then(res => res.text())
                    .then(res => {
                        const replyDiv = document.getElementById("reply-" + replyId);
                        replyDiv.querySelector("span.reply-body").textContent = newBody;
                        replyDiv.querySelector("span.reply-body").style.display = "inline";
                        replyDiv.querySelector(".edit-btn").style.display = "inline";
                        form.classList.add("hidden");
                    })
                    .catch(err => {
                        alert("댓글 수정 중 오류 발생");
                        console.error(err);
                    });
            }
        </script>


        <!-- 뒤로가기 버튼 -->
        <div class="pt-4 text-right">
            <a href="/usr/mercenaryArticle/findMercenary"
               class="text-sm text-white bg-green-600 hover:bg-green-700 px-4 py-2 rounded-full">
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