Date.prototype.getWeekNumber = function() {
    // Create a copy of this date object
    var target = new Date(this.valueOf());
    // ISO week date weeks start on monday, so correct the day number
    var dauNumber = (this.getDay() + 6) % 7;
    // Set the target to the thursday of this week so the
    // target date is in the right year
    target.setDate(target.getDate() - dauNumber + 3);

    // ISO 8601 states that week 1 is the week with january 4th in it
    var jan4 = new Date(target.getFullYear(), 0, 4);
    // Number of days between target date and january 4th
    var dayDiff = (target - jan4) / 86400000;

    if (new Date(target.getFullYear(), 0, 1).getDay() < 5) {
        // Calculate week number: Week 1 (january 4th) plus the
        // number of weeks between target date and january 4th
        return 1 + Math.ceil(dayDiff / 7);
    }
    else {
        // jan 4th is on the next week (so next week is week 1)
        return Math.ceil(dayDiff / 7);
    }
}

Date.prototype.addDays = function(days) {
    var dat = new Date(this.valueOf());
    dat.setDate(dat.getDate() + days);
    return dat;
}

function getWeekCount(year) {
    var target = Date.fromLocaleDateString(Qt.locale(), "31.12." + year, "dd.MM.yyyy");
    // ISO week date weeks start on monday, so correct the day number
    var dayNumber = (target.getDay() + 6) % 7;
    // Set the target to the thursday of this week so the
    // target date is in the right year
    target.setDate(target.getDate() - dayNumber + 3);

    // ISO 8601 states that week 1 is the week with january 4th in it
    var jan4 = new Date(target.getFullYear(), 0, 4);
    // Number of days between target date and january 4th
    var dayDiff = (target - jan4) / 86400000;

    if (new Date(target.getFullYear(), 0, 1).getDay() < 5) {
        // Calculate week number: Week 1 (january 4th) plus the
        // number of weeks between target date and january 4th
        return 1 + Math.ceil(dayDiff / 7);
    }
    else {
        // jan 4th is on the next week (so next week is week 1)
        return Math.ceil(dayDiff / 7);
    }
}

function getWeekCountCurrentYear() {
    var currentDate = new Date();
    return getWeekCount(currentDate.getFullYear());
}

function getFirstDay(year, week) {
    var firstWeekDate = Date.fromLocaleDateString(Qt.locale(), "04.01." + year, "dd.MM.yyyy");
    var givenWeekInDays = (week - 1) * 6 + 1 * (week - 1);
    var givenWeekDate = firstWeekDate.addDays(givenWeekInDays);
    return givenWeekDate;
}
