.import "./dateUtils.js" as DU
var _weeklyOutcomeCount = 3;
var _dailyGoalCount = 5;

var _weekOutcomesTemplate = [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ];
var _dailyGoalsTemplate = [
            [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ],
            [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ],
            [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ],
            [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ],
            [ { "done": false, "text": "" }, { "done": false, "text": "" }, { "done": false, "text": "" } ]
        ];

/*
  Storage Format
  {
      "year": [
          {
              "week_outcomes": [
                    {
                        "done": true,
                        "text": ""
                    }
              ],
              "daily_goals": [
                    [
                        {
                            "done": true,
                            "text": ""
                        }
                    ]
              ],
          }
      ]
  }
 */

function getWeekOutcomes(year, weekNumber) {
    var weekIndex = weekNumber - 1;

    var parsedStorage = JSON.parse(mainWindow.appStorage);
    var yearContents = parsedStorage[year.toString()];
    var emptyOutcomes = [];
    if (yearContents === undefined || yearContents[weekIndex.toString()] === undefined) {
        for (var i = 0; i < _weeklyOutcomeCount; i++) {
            emptyOutcomes.push({ "text": "", "done": false });
        }

        return emptyOutcomes;
    }

    return yearContents[weekIndex.toString()].week_outcomes;
}

function getDailyGoals(year, weekNumber, dayNumber) {
    var weekIndex = weekNumber - 1;
    var dayIndex = dayNumber - 1;

    var parsedStorage = JSON.parse(mainWindow.appStorage);
    var yearContents = parsedStorage[year.toString()];
    var emptyDay = [];
    if (yearContents === undefined || yearContents[weekIndex.toString()] === undefined) {
        for (var i = 0; i < _dailyGoalCount; i++) {
            emptyDay.push({ "text": "", "done": false });
        }

        return emptyDay;
    }

    if (yearContents[weekIndex.toString()].daily_goals[dayIndex] === undefined) {
        for (var i = 0; i < _dailyGoalCount; i++) {
            emptyDay.push({ "text": "", "done": false });
        }

        return emptyDay;
    }

    return yearContents[weekIndex.toString()].daily_goals[dayIndex];
}

function saveWeekOutcome(year, weekNumber, index, text, isDone) {
    var weekIndex = weekNumber - 1;
    var parsedStorage = JSON.parse(mainWindow.appStorage);
    var yearContents = parsedStorage[year];

    if (yearContents === undefined) {
        yearContents = [];
        for (var i = 0; i < weekNumber - 1; i++) {
            yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": _dailyGoalsTemplate.slice() })
        }

        var outcomes = _weekOutcomesTemplate.slice();
        outcomes[index] = { "done": isDone, "text": text };
        yearContents.push({ "week_outcomes": outcomes, "daily_goals": _dailyGoalsTemplate.slice() });

        parsedStorage[year] = yearContents;
    }
    else if (yearContents[weekIndex] === undefined) {
        for (var i = 0; i < weekNumber - 1; i++) {
            if (yearContents[i] === undefined) {
                yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": _dailyGoalsTemplate.slice() })
            }
        }

        outcomes = _weekOutcomesTemplate.slice();
        outcomes[index] = { "done": isDone, "text": text };
        yearContents.push({ "week_outcomes": outcomes, "daily_goals": _dailyGoalsTemplate.slice() });

        parsedStorage[year] = yearContents;
    }
    else if (yearContents[weekIndex].week_outcomes[index] === undefined) {
        yearContents[weekIndex].week_outcomes.push({ "text": text, "done": isDone });
    }
    else {
        yearContents[weekIndex].week_outcomes[index] = { "text": text, "done": isDone };
        parsedStorage[year] = yearContents;
    }

    mainWindow.appStorage = JSON.stringify(parsedStorage);
}

function saveDailyGoals(year, weekNumber, dayNumber, index, text, isDone) {
    var weekIndex = weekNumber - 1;
    var dayIndex = dayNumber - 1;
    var parsedStorage = JSON.parse(mainWindow.appStorage);

    var yearContents = parsedStorage[year];

    if (yearContents === undefined) {
        yearContents = [];
        for (var i = 0; i < weekNumber - 1; i++) {
            yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": _dailyGoalsTemplate.slice() })
        }

        var dailyGoals = _dailyGoalsTemplate.slice();
        dailyGoals[dayIndex][index] = { "done": isDone, "text": text };
        yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": dailyGoals });

        parsedStorage[year] = yearContents;
    }
    else if (yearContents[weekIndex] === undefined) {
        for (var i = 0; i < weekNumber - 1; i++) {
            if (yearContents[i] === undefined) {
                yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": _dailyGoalsTemplate.slice() })
            }
        }

        dailyGoals = _dailyGoalsTemplate.slice();
        dailyGoals[dayIndex][index] = { "done": isDone, "text": text };
        yearContents.push({ "week_outcomes": _weekOutcomesTemplate.slice(), "daily_goals": dailyGoals });

        parsedStorage[year] = yearContents;
    }
    else if (yearContents[weekIndex].daily_goals[dayIndex] === undefined) {
        yearContents[weekIndex].daily_goals.push([ { "text": text, "done": isDone } ]);
    }
    else if (yearContents[weekIndex].daily_goals[dayIndex][index] === undefined) {
        yearContents[weekIndex].daily_goals[dayIndex].push({ "text": text, "done": isDone });
    }
    else {
        yearContents[weekIndex].daily_goals[dayIndex][index] = { "text": text, "done": isDone };
        parsedStorage[year] = yearContents;
    }

    mainWindow.appStorage = JSON.stringify(parsedStorage);
}
