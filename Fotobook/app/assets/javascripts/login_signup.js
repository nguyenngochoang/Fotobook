$(document).ready(function () {
	var stopAnimation = false;
	$(".logbtn").mouseover(
		function animation() {
			if (stopAnimation) {
				stopAnimation = false;
			}
			else {
				$(".logbtn").animate({ opacity: "-=0.5" }, "slow");
				$(".logbtn").animate({ opacity: "+=0.5" }, "slow", animation);
			}
	});

	$(".logbtn").mouseout(function () {
		stopAnimation = true;
	});

	$(".logbtn2").mouseover(
		function animation() {
			if (stopAnimation) {
				stopAnimation = false;
			}
			else {
				$(".logbtn2").animate({ width: "+=25px" }, "slow");
				$(".logbtn2").animate({ width: "-=25px" }, "slow", animation);
			}
		}
	);

	$(".logbtn2").mouseout(function () {
		stopAnimation = true;
	});
});
