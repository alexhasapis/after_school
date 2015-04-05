// D3 Safety
var  majorCrimes;
var  otherCrimes;

function createSafetyVariables(json){
  majorCrimes = [ {label: "Violent Crimes", value: json.violent_crimes }, {label: "Major Property Crimes", value: json.property_crimes}, {label: "Violent Crimes at Similar Schools", value: json.avg_violent_crimes}, {label: "Major Property Crimes at Similar Schools", value: json.avg_property_crimes} ];
  
  otherCrimes = [ {label: "Other Crimes", value: json.other_crimes}, {label: "Incidents", value: json.incidents}, {label: "Other Crimes at Similar Schools", value: json.avg_other_crimes}, {label: "Incidents at Similar Schools", value: json.avg_incidents} ];

};

function createSafetyChart(data){
  var width = 300,
  height = 300;

  var tooltip = d3.select('body')
    .append('div')
    .attr('id', 'safetip')
    .attr('class', 'tip')

  var y = d3.scale.linear()
  .range([height, 0])
  .domain([0, 100]);

  var safetyChart = d3.select("#safety")
    .attr("width", width)
    .attr("height", height);


    safetyChart.selectAll('g').remove();


    var barWidth = width / data.length;

    var bar = safetyChart.selectAll('g')
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

    safetyChart.selectAll('g')
    .on('mouseover', function(d){
        tooltip.text(d.label); 
        return tooltip.style("visibility", "visible");
        })
    .on('mouseout', function(d){
        return tooltip.style('visibility', 'hidden');
    });

    function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}
}
