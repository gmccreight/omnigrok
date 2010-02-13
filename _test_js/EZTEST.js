var EZTEST = {};

(function() {
    var undefined;

    var failures = [];

    EZTEST.start = function () {
        failures = [];
    }

    EZTEST.is = function (expected, actual, message) {
        if (expected == actual) {
            assertion_result(1, message);
        }
        else {
            assertion_result(0, message);
        }
    }

    function assertion_result (ok, message) {
        if (ok == 0) {
            print("not ok: " + message);
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
is = EZTEST.is;
