use context url-file("https://raw.githubusercontent.com/neu-pdi/cs2000-public-resources/refs/heads/main/static/","cs2000.arr")

import lists as L

fun heat-needed(tem :: Number, setpoint :: Number) -> Number:
  doc:"returns how many degrees the temperature is below the setpoint, or 0 if the temperture is at or above the setpoint"
  if setpoint > tem:
    setpoint - tem
  else:
    0
  end
where:
  heat-needed(65, 67) is 2
  heat-needed(30, 30) is 0
  heat-needed(28, 20) is 0
end

fun heating-log(temlog1 :: List<Number>, setpoint1 :: Number) -> List<Number>:
  doc:"returns a list of the heat needed in each hour, in the same order"
  
  L.map(lam(a): heat-needed(a, setpoint1) end, temlog1)
where:
  heating-log([list: 60, 70, 80], 80) is [list: 20, 10, 0]
  heating-log([list: 50, 40, 90], 80) is [list: 30, 40, 0]
  heating-log([list: ], 80) is [list: ]
end

fun furnace-starts(temlog2 :: List<Number>, setpoint2 :: Number) -> Number block:
  
  doc:"returns how many times the furnace turns on"
  
  var count1 = 0
  
  for each(temlog from temlog2):
    if temlog < setpoint2:
      count1 := count1 + 1
    else:
      count1 := count1
    end
  end
  count1
  
where:
  furnace-starts([list: 60, 70, 80], 80) is 2
  furnace-starts([list: 50, 85, 90], 80) is 1
  furnace-starts([list: ], 80) is 0
end

fun heating-report(table1 :: Table, setpoint3 :: Number) -> String block:
  doc:" returns a one sentence saying in how many hours the furnace was on, out of how many hours are in the table and how many times it turned on"
  L.length(get-column(table1, temp))

  fun get-num(n1 :: Number, n2 :: Number) -> Number block:

  var count2 = 0
  if get-column(table1, temp) < setpoint3:
    count2 := count2 + 1
  else:
    count2 := count2
  end
  count2
    end
  end
end
  
  starts-hour = count2 - 1
  
  one-line = "Furname on " + count2 + " of " + L.length(get-column(table1, temp)) + " hours, starts: " + starts-hour


    