// D3 Performance
var schoolTrack;
var schoolGrad;
var schoolCollege;

function setPerformanceVariables(json){
  schoolTrack = [
  {label: "Students On Track (2012)", value: parseInt(json.on_track_2012 * 100)},
  {label: "Students On Track (2013)", value: parseInt(json.on_track_2013 * 100)},
  {label: "Students On Track(Similar Schools)", value: parseInt(json.on_track_sim_schools * 100)}
  ];

  schoolGrad = [
  {label: "Grad Rate (2012)", value: parseInt(json.grad_rate_2012 * 100)},
  {label: "Grad Rate (2013)", value: parseInt(json.grad_rate_2013 * 100)},
  {label: "Grad Rate (Similar Schools)", value: parseInt(json.grad_rate_sim_schools * 100)}
  ];

  schoolCollege = [
  {label: "College Rate (2012)", value: parseInt(json.college_rate_2012 * 100)},
  {label: "College Rate (2013)", value: parseInt(json.college_rate_2013 * 100)},
  {label: "College Rate (Similar Schools)", value: parseInt(json.college_rate_sim_schools * 100)}
  ];
};

function createPerformanceChart(data){
  var width = 300,
  height = 300;

  var y = d3.scale.linear()
  .range([height, 0])
  .domain([0, 100]);

  var chart = d3.select("#performance")
    .attr("width", width)
    .attr("height", height);

    chart.selectAll('g').remove();


    var barWidth = width / data.length;

    var bar = chart.selectAll('g')
      .data(data)
      .enter().append("g")
      .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; });

    bar.append("rect")
    .attr("y", function(d) { return y(d.value); })
    .attr("height", function(d) { return height - y(d.value); })
    .attr("width", barWidth - 1);

    bar.append("text")
    .attr("x", barWidth / 2)
    .attr("y", function(d) { return y(d.value) + 3; })
    .attr("dy", ".75em")
    .text(function(d) { return d.value; });

    function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}
}