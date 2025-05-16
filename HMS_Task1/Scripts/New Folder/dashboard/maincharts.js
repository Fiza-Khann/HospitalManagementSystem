
$(document).ready(function () {
    $(".Clander").datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true
    });
    //$("select").select2();
});
setInterval(function () {
    $("li:contains('Open in Highcharts Cloud')").hide();
}, 50);
$.ajaxSetup({ cache: false });
$(document).ajaxSend(function () {
    $("#progressbar").progressbar();
    $("#progressbar").fadeIn();

}).ajaxComplete(function () {
    $("#progressbar").fadeOut();
});
function ShiftCharts() {
    catName = [];
    $.ajax({
        // use the method as defined in the <form method="POST" ...
        type: "POST",
        // use the action as defined in <form action="/Home/AddComment?ThreadId=123"
        url: "/Home/GetCatWiseTotalMilk",
        dataType: 'json',
        success: function (response) {
            var chartTitle = response.SubHeading;
                DrawStatusArea('MilkCatchart', response.ChartList, catName, chartTitle, 'column');
            //DrawStatusPieChart('hazardStatusPiechart', response.ChartList, catName, chartTitle, 'pie');
        },
        error: function (error) {
            alert(error);
        }
    });
    return false;
}
function DrawStatusArea(id, response, catName, chartTitle, chartType) {
    CatNames = [];
    Morning = [];
    Afternoon = [];
    Evening = [];
    Night = [];
    Total = [];
    for (var x = 0; x < response.length; x++) {

        CatNames[x] = response[x].CatName;
        Morning[x] = response[x].Morning;
        Afternoon[x] = response[x].Afternoon;
        Evening[x] = response[x].Evening;
        Night[x] = response[x].Night;
        Total[x] = response[x].Total;
    }
    $('#' + id + '').highcharts({
        //Highcharts.chart('#hazardareachart', {
        chart: {
            type: 'cylinder',
        },
        credits: {
            enabled: false
        },
        title: {
            text: chartTitle
        },
        subtitle: {
            text: ' '
        },
        legend: {
            enabled: true
        },
        xAxis: {
            categories: CatNames
        },
        yAxis: {
            title: {
                text: 'Values in No'
            },
            stackLabels: {
                enabled: true,
            }
        },
        plotOptions: {
            series: {
                shadow:true,
                dataLabels: {
                    enabled: true,
                    format: '<b>{series.name} : {point.y}</b>'
                },
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                            //alert('Category: ' + this.name);
                            $("#hdCatName").val(this.category);
                            $("#hdShift").val(this.series.name);
                            $("#CatView").text(this.series.name);
                            $("#CatDetailForm").submit();
                            $('html, body').animate({
                                scrollTop: $("#PanelCatForm").offset().top - 100
                            }, 1200);
                        }
                    }
                }
            }
        },
        //plotOptions: {
        //    column: {
        //        dataLabels: {
        //            enabled: true
        //        }
        //    }
        //},
        tooltip: {
            headerFormat: '<b>{point.x}</b><br/>',
            pointFormat: '{series.name}: {point.y}'
        },
        series: [{
            name: 'Morning',
            color: '#108c12',
            data: Morning

        }, {
            name: 'Afternoon',
            color: '#770f8a',
            data: Afternoon

        }, {
            name: 'Evening',
            color: '#ea0101',
            data: Evening

        }, {
            name: 'Night',
            color: '#0851901',
            data: Night

        }, {
            name: 'Total',
            color: '#ef9009',
            data: Total

        }]
    });
    $('#' + id + '').find('text').last().hide();
}
function DrawStatusPieChart(id, response, catName, chartTitle, chartType) {
    CatNames = [];
    var Open = 0;
    var Closed = 0;
    var Total = 0;
    for (var x = 0; x < response.length; x++) {

        CatNames[x] = response[x].CatName;
        Open = Open + response[x].Open;
        Closed = Closed + response[x].Closed;
        Total = Total + response[x].Total;
    }
    $('#' + id + '').highcharts({
        //Highcharts.chart('#hazardareachart', {
        chart: {
            type: chartType
        },
        credits: {
            enabled: false
        },
        title: {
            text: chartTitle
        },
        tooltip: {
            pointFormat: '<b>{point.percentage:.1f}</b> %'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: true
            }
        },
        series: [{
            name: ' ',
            data: [{
                name: 'Open',
                color: '#24C86F',
                y: Open
            }, {
                name: 'Closed',
                color: '#F62424',
                y: Closed
            },{
                name: '',
                visible: false,
                showInLegend: false
            }]
        }]
    });
    $('#' + id + '').find('text').last().hide();
}
function DrawStackedArea(id,series,catName,chartTitle,chartType)
{
    $('#'+id+'').highcharts({
    //Highcharts.chart('#hazardareachart', {
        chart: {
            type: 'cylinder',
            options3d: {
                enabled: true,
                alpha: 10,
                beta: 10,
                depth: 200,
                viewDistance: 25
            }
        },
        credits: {
            enabled: false
        },
        title: {
            text: chartTitle
        },
        subtitle: {
            text: ' '
        },
        legend: {
            enabled: false
        },
        xAxis: {
            categories: catName,
            tickmarkPlacement: 'on',
            title: {
                enabled: false
            }
        },
        yAxis: {
            title: {
                text: 'Values in No'
            }
        },
        plotOptions: {
            series: {
                depth: 300,
                borderWidth: 100,
                pointWidth: 100,
                opacity: .68,
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}: {point.y}</b>'
                },
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                            //alert('Category: ' + this.name);
                            $("#hdCatName").val(this.name);
                            $("#CatView").text(this.name);
                            $("#CatDetailForm").submit();
                            $('html, body').animate({
                                scrollTop: $("#PanelCatForm").offset().top -100
                            }, 1200);
                        }
                    }
                }
            }
        },
        tooltip: {
            split: true,
            valueSuffix: ' '
        },
        colors: [
        '#108c12',
        '#ea0101',
        '#ef9009',
        '#7718e6',
        '#3D96AE',
        '#DB843D',
        '#92A8CD',
        '#A47D7C',
        '#B5CA92'
         ],
        series: [{
            name: 'Total Hazard',
            colorByPoint: true,
            data: series
       
        }],
    });
    $('#'+id+'').find('text').last().hide();
}
function DrawPieChart(id, series, catName, chartTitle, chartType) {

    $('#' + id + '').highcharts({
        //Highcharts.chart('#hazardareachart', {
        chart: {
            type: chartType,
        },
        credits: {
            enabled: false
        },
        title: {
            text: chartTitle
        },
        tooltip: {
            pointFormat: '<b>{series.name}: {point.percentage:.1f} %</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: true
            }
        },
        colors: [
       '#24C86F',
       '#ea0101',
       '#ef9009',
       '#7718e6',
       '#3D96AE',
       '#DB843D',
       '#92A8CD',
       '#A47D7C',
       '#B5CA92'
        ],
        series: [{
            name: 'Hazard',
            colorByPoint: true,
            data: series

        }]
    });
    $('#' + id + '').find('text').last().hide();
}
function PopulateTimeSlot(AirportCode, DateFrom, DateTo) {
    $.ajax({
        // use the method as defined in the <form method="POST" ...
        type: "POST",
        // use the action as defined in <form action="/Home/AddComment?ThreadId=123"
        url: "/Dashboard/GetTimeSlotHazardChartData",
        data: { AirportCode: AirportCode, DateFrom: DateFrom, DateTo: DateTo },
        dataType: 'json',
        success: function (response) {
            TimeSlotTabChart(response, 'birdhitTimeSlotchart', 'normal', '1');
        },
        error: function (error) {
            alert(error);
        }
    });
    return false;
}
function TimeSlotTabChart(r, ID, TabType, ReportType) {
    CatNames = [];
    Total = [];
    var chartTitle = "";
    if (ReportType == '1') {
        chartTitle = $("#ddlLocAirportTimeSlot option:selected").text();
    }
    for (var x = 0; x < r.length; x++) {

        CatNames[x] = r[x].CatNames;
        Total[x] = r[x].Total;
    }
    var chart = new Highcharts.Chart({
        chart: {
            type: 'column',
            renderTo: '' + ID + ''
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Hazard <br>'+chartTitle
        },
        xAxis: {
            categories: CatNames
        },
        plotOptions: {
            column: {
                stacking: '' + TabType + '',
                depth: 40,
                dataLabels: {
                    enabled: true
                }
            }
        },
        series: [
        {
            name: 'Total',
            color: '#d51919',
            data: Total
        }
        ]
    });
    $('#' + ID + '').find('text').last().hide();
}
function PopulateMonthlyTabChart(AirportCode, DateFrom, DateTo) {
    $.ajax({
        // use the method as defined in the <form method="POST" ...
        type: "POST",
        // use the action as defined in <form action="/Home/AddComment?ThreadId=123"
        url: "/Dashboard/GetMonthWiseHazardChartData",
        data: { AirportCode: AirportCode, DateFrom: DateFrom, DateTo: DateTo },
        dataType: 'json',
        success: function (response) {
            MonthlyTabChart(response);
        },
        error: function (error) {
            alert(error);
        }
    });
    return false;
}
function MonthlyTabChart(r) {
    CatNames = [];
    SMS = [];
    EMS = [];
    GENERAL = [];
    OHSAS = [];
    for (var x = 0; x < r.length; x++) {

        CatNames[x] = r[x].Month;
        SMS[x] = r[x].SMS;
        EMS[x] = r[x].EMS;
        GENERAL[x] = r[x].GENERAL;
        OHSAS[x] = r[x].OHSAS;
    }
    var chart = new Highcharts.Chart({
        chart: {
            type: 'column',
            renderTo: 'hazardMonthlychart'
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Hazard <br> Month Wise Chart'
        },
        xAxis: {
            categories: CatNames
        },
        //plotOptions: {
        //    column: {
        //        stacking: 'normal',
        //        depth: 40
        //    }
        //},
        series: [{
            name: 'SMS',
            data: SMS
        },
        {
            name: 'GENERAL',
            data: GENERAL
        },
         {
             name: 'OHSAS',
             data: OHSAS
         },
         {
             name: 'EMS',
             data: EMS
         }
        ]
    });
    $('#hazardMonthlychart').find('text').last().hide();
}
function showDialog(FormName, Title, Height, Width) {
    // e.preventDefault(); use this or return false
    $("#Dialog").dialog({
        title: Title,
        autoOpen: false,
        resizable: false,
        height: Height,
        width: Width,
        show: { direction: "up" },
        modal: true,
        draggable: true,

        buttons: false
    });

    $("#Dialog").dialog('open');
    $.validator.unobtrusive.parse("#" + FormName + "");
}


