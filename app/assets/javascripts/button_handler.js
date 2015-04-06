$(document).ready(function(){

  $('li.small.button.secondary').on('click', function(){
    if (this.textContent == "School On Track"){
      createPerformanceChart(schoolTrack)
    }
    else if (this.textContent == "School Grad Rate"){
      createPerformanceChart(schoolGrad)
    }    
    else if (this.textContent == "School College Rate"){
      createPerformanceChart(schoolCollege)
    }
    else if (this.textContent == "Major Crimes"){
      createSafetyChart(majorCrimes)
    }
    else if (this.textContent == "Other Crimes/Incidents"){
      createSafetyChart(otherCrimes)
    }
  });
});