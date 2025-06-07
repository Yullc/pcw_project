document.addEventListener("DOMContentLoaded", function () {
    const today = new Date();
    let currentYear = today.getFullYear();
    let currentMonth = today.getMonth(); // 0~11

    const monthYearLabel = document.getElementById("monthYearLabel");
    const datesGrid = document.getElementById("datesGrid");
    const selectedDateDisplay = document.getElementById("selectedDateDisplay");
    const prevMonthBtn = document.getElementById("prevMonthBtn");
    const nextMonthBtn = document.getElementById("nextMonthBtn");

    function renderCalendar(year, month) {
        monthYearLabel.textContent = `${year}년 ${month + 1}월`;
        datesGrid.innerHTML = "";

        const firstDay = new Date(year, month, 1).getDay();
        const totalDays = new Date(year, month + 1, 0).getDate();

        // 빈 칸 채우기
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

            // 날짜 클릭 이벤트
            dateDiv.addEventListener("click", function () {
                const prevSelected = document.querySelector(".calendar-dates .selected");
                if (prevSelected) prevSelected.classList.remove("selected");
                dateDiv.classList.add("selected");

                const selectedFullDate = new Date(year, month, day);
                const yyyy = selectedFullDate.getFullYear();
                const mm = String(selectedFullDate.getMonth() + 1).padStart(2, "0");
                const dd = String(selectedFullDate.getDate()).padStart(2, "0");
                const playDateStr = `${yyyy}-${mm}-${dd}`;

                selectedDateDisplay.textContent = playDateStr;

                // ✅ URL 파라미터 붙여서 이동
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