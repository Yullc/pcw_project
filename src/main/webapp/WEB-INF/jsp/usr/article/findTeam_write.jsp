<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>팀 구하기 글쓰기</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="text/javascript">
        function ArticleWrite__submit(form) {
            form.title.value = form.title.value.trim();
            if (form.title.value.length === 0) {
                alert('제목을 입력해주세요.');
                return;
            }

            const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
            const markdown = editor.getMarkdown().trim();

            if (markdown.length === 0) {
                alert('내용을 입력해주세요.');
                return;
            }

            form.body.value = markdown;
            form.submit();
        }
    </script>
</head>
<body class="bg-gray-50">
<div class="max-w-4xl mx-auto mt-10 p-8 bg-white rounded-2xl shadow-2xl">
    <h1 class="text-2xl font-bold mb-6 text-center text-green-700">팀 구하기 글쓰기</h1>

    <form onsubmit="ArticleWrite__submit(this); return false;" action="../article/doWrite" method="POST">
        <input type="hidden" name="body" />

        <div class="mb-4">
            <label class="block mb-2 font-semibold">제목</label>
            <input name="title" type="text" placeholder="제목을 입력하세요"
                   class="w-full border border-green-600 p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400" required />
        </div>



        <div class="mb-6">
            <label class="block mb-2 font-semibold">내용</label>
            <div class="toast-ui-editor">
                <script type="text/x-template"></script>
            </div>
        </div>

        <div class="flex justify-between">
            <button type="submit"
                    class="bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-6 rounded-lg">
                작성
            </button>
            <button type="button" onclick="history.back();"
                    class="border border-gray-400 text-gray-700 hover:bg-gray-100 font-semibold py-2 px-6 rounded-lg">
                뒤로가기
            </button>
        </div>
    </form>
</div>
</body>
</html>
