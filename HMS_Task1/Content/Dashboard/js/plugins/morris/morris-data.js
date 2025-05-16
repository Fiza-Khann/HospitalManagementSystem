//$(function() {
function Chart(r) {
    debugger;
    var test = r;
    Morris.Area({
        element: 'morris-area-chart',
        data: [{ "CatName": "AEROASIA", "Resolved": 0, "Unresolved": 86, "Total": 86 }, { "CatName": "AIR BLUE", "Resolved": 177, "Unresolved": 133, "Total": 310 }, { "CatName": "AIR CIRO", "Resolved": 2, "Unresolved": 2, "Total": 4 }, { "CatName": "AIR INDUS", "Resolved": 3, "Unresolved": 17, "Total": 20 }, { "CatName": "AIRLINE", "Resolved": 0, "Unresolved": 23, "Total": 23 }, { "CatName": "ANF", "Resolved": 32, "Unresolved": 51, "Total": 83 }, { "CatName": "ASF", "Resolved": 129, "Unresolved": 56, "Total": 185 }, { "CatName": "CAA", "Resolved": 1485, "Unresolved": 591, "Total": 2076 }, { "CatName": "CAA VIGILANCE", "Resolved": 0, "Unresolved": 1, "Total": 1 }, { "CatName": "CAA", "Resolved": 17, "Unresolved": 2, "Total": 19 }, { "CatName": "CUSTOMS", "Resolved": 83, "Unresolved": 82, "Total": 165 }, { "CatName": "EITHAD AIRWAYS", "Resolved": 21, "Unresolved": 26, "Total": 47 }, { "CatName": "EMIRATES AIRLINE", "Resolved": 47, "Unresolved": 35, "Total": 82 }, { "CatName": "FIA", "Resolved": 33, "Unresolved": 50, "Total": 83 }, { "CatName": "GULF AIR", "Resolved": 11, "Unresolved": 13, "Total": 24 }, { "CatName": "GULF AIRLINE", "Resolved": 2, "Unresolved": 0, "Total": 2 }, { "CatName": "HEALTH DEPTT", "Resolved": 2, "Unresolved": 1, "Total": 3 }, { "CatName": "INDUS AIR", "Resolved": 18, "Unresolved": 0, "Total": 18 }, { "CatName": "KUWAIT AIRWAYS", "Resolved": 14, "Unresolved": 3, "Total": 17 }, { "CatName": "NAS AIR", "Resolved": 1, "Unresolved": 0, "Total": 1 }, { "CatName": "NAS AIRLINE", "Resolved": 2, "Unresolved": 0, "Total": 2 }, { "CatName": "NBP", "Resolved": 1, "Unresolved": 1, "Total": 2 }, { "CatName": "OMAN AIR", "Resolved": 4, "Unresolved": 4, "Total": 8 }, { "CatName": "OPF", "Resolved": 2, "Unresolved": 0, "Total": 2 }, { "CatName": "OTHER", "Resolved": 10, "Unresolved": 45, "Total": 55 }, { "CatName": "PIAC", "Resolved": 258, "Unresolved": 443, "Total": 701 }, { "CatName": "POLICE", "Resolved": 2, "Unresolved": 6, "Total": 8 }, { "CatName": "QATAR AIRWAYS", "Resolved": 17, "Unresolved": 11, "Total": 28 }, { "CatName": "RAS AL KHAIMA AIR", "Resolved": 0, "Unresolved": 2, "Total": 2 }, { "CatName": "ROYAL AIRPORT SERVICES", "Resolved": 0, "Unresolved": 1, "Total": 1 }, { "CatName": "SAPS", "Resolved": 1, "Unresolved": 2, "Total": 3 }, { "CatName": "SAUDI AIRLINE", "Resolved": 25, "Unresolved": 32, "Total": 57 }, { "CatName": "SHAHEEN AIR", "Resolved": 119, "Unresolved": 107, "Total": 226 }, { "CatName": "SWEDISH AIR", "Resolved": 0, "Unresolved": 3, "Total": 3 }, { "CatName": "THAI AIRWAYS", "Resolved": 10, "Unresolved": 14, "Total": 24 }, { "CatName": "TURKISH AIRLINE", "Resolved": 4, "Unresolved": 3, "Total": 7 }, { "CatName": "UZBEK AIRLINE", "Resolved": 2, "Unresolved": 0, "Total": 2 }],
        xkey: 'Resolved',
        ykeys: ['Resolved', 'Unresolved', 'Total'],
        labels: ['Resolved', 'Under Process', 'Total Complaints'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true
    });

    Morris.Donut({
        element: 'morris-donut-chart',
        data: [{
            label: "Download Sales",
            value: 12
        }, {
            label: "In-Store Sales",
            value: 30
        }, {
            label: "Mail-Order Sales",
            value: 20
        }],
        resize: true
    });

    Morris.Bar({
        element: 'morris-bar-chart',
        data: r,
        xkey: 'Resolved',
        ykeys: ['Resolved', 'Unresolved', 'Total'],
        labels: ['Resolved', 'Under Process', 'Total Complaints'],
        hideHover: 'auto',
        resize: true
    });
}
//});
