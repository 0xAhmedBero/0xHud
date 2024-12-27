function createProgressBar(id, label, percentage, color) {
  const existingBar  = document.getElementById(`bar-${id}`);
  if (existingBar) {
      console.log("Progress bar exist")
      return
  }
  const container = document.getElementById("bars-container");

  const bar = document.createElement("div");
  bar.classList.add("bar");
  bar.id = `bar-${id}`;

  const fullBackground = document.createElement("div");
  fullBackground.classList.add("full-background");

  const barLabel = document.createElement("div");
  barLabel.classList.add("label");
  barLabel.innerText = `${label}`;

  const progress = document.createElement("div");
  progress.classList.add("progress");
  progress.style.width = `${percentage}%`;
  progress.style.backgroundColor = `rgba(${color.join(',')})`;     
  fullBackground.style.backgroundColor = `rgba(${color.join(',')}, 0.250)`;

  bar.appendChild(barLabel);
  bar.appendChild(fullBackground);
  fullBackground.appendChild(progress);

  container.appendChild(bar);
}



function updateProgressBar(id, percentage) {
  const bar = document.getElementById(`bar-${id}`);
  if (bar) {
      const progress = bar.querySelector(".progress");
      progress.style.width = `${percentage}%`;
  }
}

function removeProgressBar(id) {
  const bar = document.getElementById(`bar-${id}`);
  if (bar) {
      bar.remove();
  }
}

function createText(id, label, text, color) {
  const existingBar  = document.getElementById(`bar-${id}`);
  if (existingBar) {
      console.log("Text bar exist")
      return
  }
  let String = text;
  let max = 15;
  if (String.length > max) {
      text = String.slice(0, max);
  }
  const container = document.getElementById("bars-container");

  const bar = document.createElement("div");
  bar.classList.add("bar");
  bar.id = `bar-${id}`;


  const barLabel = document.createElement("div");
  barLabel.classList.add("label");
  barLabel.innerText = `${label}`;

  const barText = document.createElement("div");
  barText.classList.add("textbar");
  barText.innerText = `${text}`;
  barText.style.color = `rgba(${color.join(',')})`;

  bar.appendChild(barLabel);
  bar.appendChild(barText);

  container.appendChild(bar);
}

function UpdateText(id, text, color) {
    const bar = document.getElementById(`bar-${id}`);
    if (bar) {
        const textBar = bar.querySelector(".textbar");
        textBar.innerText = `${text}`;
        textBar.style.color = `rgba(${color.join(',')})`;
    }
}

function createCircles(id, label, quantity, color, alpha) {
  const existingBar  = document.getElementById(`bar-${id}`);
  if (existingBar) {
      console.log("Circles bar exist")
      return
  }
  const container = document.getElementById("bars-container");

  const bar = document.createElement("div");
  bar.classList.add("bar");
  bar.id = `bar-${id}`;


  const barLabel = document.createElement("div");
  barLabel.classList.add("label");
  barLabel.innerText = `${label}`;
  const fullBackground = document.createElement("div");
  fullBackground.classList.add("circlebackground");
  bar.appendChild(barLabel);
  bar.appendChild(fullBackground);
  let max = 9;
  quantity = Math.min(quantity, max);
  for (let i = 0; i < quantity; i++) {
      const circle = document.createElement("div");
      circle.classList.add("circle");
      circle.id = `circle-${i + 1}`;
      circle.style.width = `13px`;
      circle.style.height = `13px`;
      circle.style.borderRadius = `50px`;
      circle.style.backgroundColor = `rgba(${color.join(',')})`;
      fullBackground.appendChild(circle);
  }


  container.appendChild(bar);
}


function updateCircle(id, circleid, color) {
  const bar = document.getElementById(`bar-${id}`);
  if (bar) {
      const circle = bar.querySelector(`#circle-${circleid}`);
      if (circle) {
          circle.style.backgroundColor = `rgba(${color.join(',')})`;
      }
  }
}

function removeCircle(id, circleid) {
  const bar = document.getElementById(`bar-${id}`);
  if (bar) {
      const circle = bar.querySelector(`#circle-${circleid}`); 
      if (circle) {
          circle.remove();
      }
  }
}

function killCircle(id, circleid) {
  const bar = document.getElementById(`bar-${id}`);
  if (bar) {
      const circle = bar.querySelector(`#circle-${circleid}`); 
      if (circle) {
          const iconClass = document.createElement("div");
          iconClass.classList.add("icons");
          const icon = document.createElement("i");
          icon.classList.add("fas", "fa-xmark"); 
          iconClass.appendChild(icon);
          circle.appendChild(iconClass);
      }
  }
}

function createTimerProgressBar(id, label, duration, color) {
  const existingBar  = document.getElementById(`bar-${id}`);
  if (existingBar) {
      console.log("Timer Progress bar exist")
      return
  }
  createProgressBar(id, label, 100, color);
  let timeRemaining = duration;
  const intervalId = setInterval(() => {
      if (timeRemaining <= 0) {
          clearInterval(intervalId);
          removeProgressBar(id);
          return;
      }

      let percentage = (timeRemaining / duration) * 100;
      updateProgressBar(id, percentage);
      timeRemaining--;
  }, 1000);
}

function createCountdownTimer(id, label, duration, color) {
  const existingBar  = document.getElementById(`bar-${id}`);
  if (existingBar) {
      console.log("Countdown Timer bar exist")
      return
  }
  const container = document.getElementById("bars-container");

  const countdownDiv = document.createElement("div");
  countdownDiv.classList.add("bar");
  countdownDiv.id = `countdown-timer-${id}`;

  const barLabel = document.createElement("div");
  barLabel.classList.add("label");
  barLabel.innerText = `${label}`;

  const countdownText = document.createElement("div");
  countdownText.classList.add("countdown-text");
  countdownText.innerText = `${formatTime(duration)}`;
  countdownText.style.color = `rgba(${color.join(',')})`;

  countdownDiv.appendChild(barLabel);
  countdownDiv.appendChild(countdownText);
  container.appendChild(countdownDiv);

  let timeRemaining = duration;
  const intervalId = setInterval(() => {
      if (timeRemaining <= 0) {
          clearInterval(intervalId);
          countdownText.innerText = "00:00";
          return;
      }

      timeRemaining--;
      countdownText.innerText = formatTime(timeRemaining);
  }, 1000);
}

function formatTime(seconds) {
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`;
}

// tests
// createProgressBar("5FAFA", 'طعام', 50, [255, 133, 85]);
// createText("daeheaa", 'المال', "€500000", [53, 154, 71]);
// createCircles("KHKHKTZ", 'إمداد', 10, [155, 155, 155, 0.5]);
// updateCircle("KHKHKTZ", 1, [93, 182, 229, 1])
// updateCircle("KHKHKTZ", 2, [235, 36, 39, 1])
// updateCircle("KHKHKTZ", 3, [53, 154, 71, 1])
// killCircle("KHKHKTZ", 1)
// createTimerProgressBar("FAFAHTJ", 'موقت', 100, [93, 182, 229]);
// createCountdownTimer("KGKSZT", 'موقت', 100, [93, 182, 229]);
// setTimeout(() => {
//     removeCircle("KHKHKTZ", 2)
// }, 2000); 

window.addEventListener('message', function(event) {
  const data = event.data;
  if (data.bar === 'progress') { 
      createProgressBar(data.id, data.label, data.action, data.color);
  } else if (data.bar === 'circle') {
      createCircles(data.id, data.label, data.action, data.color);
  } else if (data.bar === 'text') {
      createText(data.id, data.label, data.action, data.color);
  } else if (data.bar === 'countdown') {
      createCountdownTimer(data.id, data.label, data.action, data.color);
  } else if (data.bar === 'timerProgress') {
      createTimerProgressBar(data.id, data.label, data.action, data.color);
  }
});
window.addEventListener('message', function(event) {
  const data = event.data;
  if (data.hide === true) { 
      const existingBar  = document.getElementById(`bars-container`);
      if (existingBar) {
          existingBar.style.display = 'none';
      }
  } else if (data.hide === false) {
      const existingBar  = document.getElementById(`bars-container`);
      if (existingBar) {
          existingBar.style.display = 'flex';
      }
  }
});
window.addEventListener('message', function(event) {
    const data = event.data;
    if (data.action === "updateProgress") {
        const existingBar  = document.getElementById(`bar-${data.id}`);
        if (existingBar) {
            updateProgressBar(data.id, data.percentage)
        }
    } else if (data.action === "removeBar") {
        const existingBar  = document.getElementById(`bar-${data.id}`);
        if (existingBar) {
            updateCircle(data.id, data.circle, data.color)
            if(data.kill === true) {
                removeProgressBar(data.id)
            }
        }
    } else if (data.action === "updateCircle") {
        const existingBar  = document.getElementById(`bar-${data.id}`);
        if (existingBar) {
            updateCircle(data.id, data.circle, data.color)
            if(data.kill === true) {
                killCircle(data.id, data.circle)
            }
        }
    } else if (data.action === "removeCircle") {
        const existingBar  = document.getElementById(`bar-${data.id}`);
        if (existingBar) {
            removeCircle(data.id, data.circle)
        }
    } else if (data.action === "updateText") {
        const existingBar  = document.getElementById(`bar-${data.id}`);
        if (existingBar) {
            UpdateText(data.id, data.text, data.color)
        }
    }
});