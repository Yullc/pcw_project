document.addEventListener("DOMContentLoaded", function () {
    const today = new Date();
    let currentYear = today.getFullYear();
    let currentMonth = today.getMonth(); // 0~11

    const monthYearLabel = document.getElementById("monthYearLabel");
    const datesGrid = document.getElementById("datesGrid");
    const selectedDateDisplay = document.getElementById("selectedDateDisplay");
    const prevMonthBtn = document.getElementById("prevMonthBtn");
    const nextMonthBtn = document.getElementById("nextMonthBtn");

    // ✅ URL에서 playDate 파라미터 읽기
    const urlParams = new URLSearchParams(window.location.search);
    const selectedDateFromURL = urlParams.get("playDate"); // ex: "2025-06-20"

    // ✅ 렌더링 기준 날짜 수정 (선택된 날짜가 있으면 해당 월로 이동)
    if (selectedDateFromURL) {
        const parts = selectedDateFromURL.split("-");
        currentYear = parseInt(parts[0]);
        currentMonth = parseInt(parts[1]) - 1;
    }

    function renderCalendar(year, month) {
        monthYearLabel.textContent = `${year}년 ${month + 1}월`;
        datesGrid.innerHTML = "";

        const firstDay = new Date(year, month, 1).getDay();
        const totalDays = new Date(year, month + 1, 0).getDate();

        for (let i = 0; i < firstDay; i++) {
            const emptyDiv = document.createElement("div");
            emptyDiv.classList.add("empty");
            datesGrid.appendChild(emptyDiv);
        }

        for (let day = 1; day <= totalDays; day++) {
            const dateDiv = document.createElement("div");
            dateDiv.textContent = day;

            const dayOfWeek = new Date(year, month, day).getDay();
            if (dayOfWeek === 0) dateDiv.classList.add("sun");
            else if (dayOfWeek === 6) dateDiv.classList.add("sat");

            // 현재 날짜 문자열 만들기
            const yyyy = String(year);
            const mm = String(month + 1).padStart(2, "0");
            const dd = String(day).padStart(2, "0");
            const fullDate = `${yyyy}-${mm}-${dd}`;

            // ✅ URL에서 넘어온 날짜와 일치하면 선택 표시
            if (selectedDateFromURL === fullDate) {
                dateDiv.classList.add("selected");
                selectedDateDisplay.textContent = fullDate;
            }

            // 날짜 클릭 이벤트
            dateDiv.addEventListener("click", function () {
                const playDateStr = fullDate;
                selectedDateDisplay.textContent = playDateStr;

                // URL 이동
                const urlParams = new URLSearchParams(window.location.search);
                urlParams.set("playDate", playDateStr);
                window.location.href = "/usr/home/foot_menu?" + urlParams.toString();
            });

            datesGrid.appendChild(dateDiv);
        }
    }

    prevMonthBtn.addEventListener("click", function () {
        currentMonth--;
        if (currentMonth < 0) {
            currentYear--;
            currentMonth = 11;
        }
        renderCalendar(currentYear, currentMonth);
    });

    nextMonthBtn.addEventListener("click", function () {
        currentMonth++;
        if (currentMonth > 11) {
            currentYear++;
            currentMonth = 0;
        }
        renderCalendar(currentYear, currentMonth);
    });

    renderCalendar(currentYear, currentMonth);
});
