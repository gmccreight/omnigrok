var EZTEST = {};

(function() {
    var undefined;

    var failures = [];

    EZTEST.start = function () {
        failures = [];
    }

    EZTEST.isok = function (expected, actual, message) {
        if (expected == actual) {
            assertion_result(1, expected, actual, message);
        }
        else {
            assertion_result(0, expected, actual, message);
        }
    }

    function assertion_result (ok, expected, actual, message) {
        if (ok == 0) {
            print("not ok: Expected - " + expected + " got - " + actual + " --- " + message);
            failures.push(message);
        }
        else {
            print("ok: " + message);
        }
    }

    EZTEST.finish = function () {
        if (failures.length == 0) {
            print("ALL TESTS PASSED");
        }
        else {
            print(failures.length + " TESTS FAILED");
        }
    }

})();

start = EZTEST.start;
finish = EZTEST.finish;
isok = EZTEST.isok;
