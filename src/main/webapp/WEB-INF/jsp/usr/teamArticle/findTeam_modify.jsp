<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>팀 구하기 글 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="max-w-4xl mx-auto mt-10 p-8 bg-white rounded-2xl shadow-2xl">
    <h1 class="text-2xl font-bold mb-6 text-center text-green-700">팀 구하기 글 수정</h1>

    <form onsubmit="ArticleModify__submit(this); return false;" action="/usr/teamArticle/doModify" method="POST">
        <input type="hidden" name="id" value="${teamArticle.id}" />
        <input type="hidden" name="body" id="body" />

        <div class="mb-4">
            <label class="block mb-2 font-semibold">제목</label>
            <input name="title" type="text" value="${teamArticle.title}" placeholder="제목을 입력하세요"
                   class="w-full border border-green-600 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400" required />
        </div>

        <div class="mb-6">
            <label class="block mb-2 font-semibold">내용</label>

            <!-- ✅ 초기값 저장용 textarea -->
            <textarea id="editor-init" style="display:none;"><c:out value="${teamArticle.body}" /></textarea>

            <!-- ✅ toast-ui editor가 그려질 영역 -->
            <div id="editor-root"></div>
        </div>

        <div class="flex justify-between">
            <button type="submit"
                    class="bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-6 rounded-lg">
                수정
            </button>
            <button type="button" onclick="history.back();"
                    class="border border-gray-400 text-gray-700 hover:bg-gray-100 font-semibold py-2 px-6 rounded-lg">
                뒤로가기
            </button>
        </div>
    </form>
</div>

<script>
    let editor;

    document.addEventListener("DOMContentLoaded", function () {
        const initialContent = document.getElementById("editor-init").value;

        console.log("🔥 editor 초기값:", initialContent);

        editor = new toastui.Editor({
            el: document.getElementById("editor-root"),
            height: '400px',
            initialEditType: 'markdown',
            previewStyle: 'vertical',
            initialValue: initialContent
        });
    });

    function ArticleModify__submit(form) {
        const title = form.title.value.trim();
        const markdown = editor.getMarkdown().trim();

        console.log("🧪 사용자 입력한 markdown:", markdown);

        if (title.length === 0) {
            alert("제목을 입력해주세요.");
            return false;
        }

        if (markdown.length === 0) {
            alert("내용을 입력해주세요.");
            return false;
        }

        form.querySelector("#body").value = markdown;

        console.log("📤 전송될 body 내용:", markdown);


        form.submit();
    }
</script>
</body>
</html>
