// Please define the expected_minutes_in_oven function
pub fn expected_minutes_in_oven()  -> Int {
  40
}

// Please define the remaining_minutes_in_oven function
pub fn remaining_minutes_in_oven(in_open: Int)  -> Int {
  expected_minutes_in_oven() - in_open
}

// Please define the preparation_time_in_minutes function
pub fn preparation_time_in_minutes(layer: Int)  -> Int {
  layer * 2
}

// Please define the total_time_in_minutes function
pub fn total_time_in_minutes(layer: Int, in_open: Int) -> Int {
  preparation_time_in_minutes(layer) + in_open
}

// Please define the alarm function
pub fn alarm() -> String {
    "Ding!"
}
