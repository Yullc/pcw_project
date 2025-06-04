// 페이지 로드 시 DOM이 완전히 준비된 후 달력 초기화
document.addEventListener("DOMContentLoaded", function() {
    // 오늘 날짜 객체
    const today = new Date();

    // 현재 보고 있는 달과 년도를 변수로 저장 (초기값: 오늘)
    let currentYear = today.getFullYear();
    let currentMonth = today.getMonth(); // 0~11

    // 페이지 내 요소 가져오기
    const monthYearLabel = document.getElementById("monthYearLabel");
    const datesGrid = document.getElementById("datesGrid");
    const selectedDateDisplay = document.getElementById("selectedDateDisplay");
    const prevMonthBtn = document.getElementById("prevMonthBtn");
    const nextMonthBtn = document.getElementById("nextMonthBtn");

    // --- 달력을 렌더링하는 함수 ---
    function renderCalendar(year, month) {
        // 1) 헤더(년·월) 업데이트
        monthYearLabel.textContent = `${year}년 ${month + 1}월`;

        // 2) 이전에 있던 날짜 요소들 제거
        datesGrid.innerHTML = "";

        // 3) 해당 월의 첫 번째 날(요일)과 총 일 수 계산
        const firstDay = new Date(year, month, 1).getDay();       // 0(일) ~ 6(토)
        const totalDays = new Date(year, month + 1, 0).getDate(); // 해당 월의 마지막 날짜

        // 4) 그리드에 '빈 칸' 추가 (첫 번째 날 요일까지)
        for (let i = 0; i < firstDay; i++) {
            const emptyDiv = document.createElement("div");
            emptyDiv.classList.add("empty");
            datesGrid.appendChild(emptyDiv);
        }

        // 5) 실제 날짜(1일부터 totalDays까지) 생성
        for (let day = 1; day <= totalDays; day++) {
            const dateDiv = document.createElement("div");
            dateDiv.textContent = day;

            // 요일(일~토)을 계산해서 클래스 부여 (색깔 구분용)
            const dayOfWeek = new Date(year, month, day).getDay();
            if (dayOfWeek === 0) {
                dateDiv.classList.add("sun"); // 일요일이면 빨강
            } else if (dayOfWeek === 6) {
                dateDiv.classList.add("sat"); // 토요일이면 파랑
            }

            // 클릭 이벤트 등록
            dateDiv.addEventListener("click", function() {
                // 1) 기존에 선택된 셀 있으면 스타일 해제
                const prevSelected = document.querySelector(".calendar-dates .selected");
                if (prevSelected) {
                    prevSelected.classList.remove("selected");
                }
                // 2) 클릭된 셀에 선택 스타일 추가
                dateDiv.classList.add("selected");

                // 3) 선택된 날짜 화면에 표시
                const selectedFullDate = new Date(year, month, day);
                const yyyy = selectedFullDate.getFullYear();
                const mm = String(selectedFullDate.getMonth() + 1).padStart(2, "0");
                const dd = String(selectedFullDate.getDate()).padStart(2, "0");
                selectedDateDisplay.textContent = `${yyyy}-${mm}-${dd}`;

                // 4) JSP 폼으로 전송하거나, Ajax 호출 등을 넣으려면
                //    예: document.getElementById("hiddenDateInput").value = `${yyyy}-${mm}-${dd}`;
            });

            datesGrid.appendChild(dateDiv);
        }
    }

    // --- 이전 달 버튼 클릭 시 ---
    prevMonthBtn.addEventListener("click", function() {
        currentMonth--;
        if (currentMonth < 0) {
            currentYear--;
            currentMonth = 11;
        }
        renderCalendar(currentYear, currentMonth);
    });

    // --- 다음 달 버튼 클릭 시 ---
    nextMonthBtn.addEventListener("click", function() {
        currentMonth++;
        if (currentMonth > 11) {
            currentYear++;
            currentMonth = 0;
        }
        renderCalendar(currentYear, currentMonth);
    });

    // --- 초기 렌더링 (페이지 로드 시 현재 달로 표시) ---
    renderCalendar(currentYear, currentMonth);
});
