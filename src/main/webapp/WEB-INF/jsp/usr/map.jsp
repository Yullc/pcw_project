
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Kakao 지도 시작하기</title>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=865ee63e65accb86ded5e65ec9ebfe0b&libraries=services,clusterer,drawing"></script>
</head>
<body>
<div id="map" style="width:500px;height:400px;"></div>

<script>
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };
    var map = new kakao.maps.Map(container, options);
</script>
</body>
</html>

