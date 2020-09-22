testthat::expect_that(check_dates('01-12-2017', '20-01-2018'),
                      testthat::throws_error())

testthat::expect_that(check_dates('2017-12-31', '20-01-2018'),
                      testthat::throws_error())

testthat::expect_that(check_dates('2018-01-20', '2017-03-15'),
                      testthat::throws_error())

testthat::expect_that(check_dates('2017-01-01', '2018-12-31'),
                      testthat::is_true())

testthat::expect_that(check_dates('2017-01-01', '2017-01-01'),
                      testthat::is_true())

testthat::expect_that(check_dates('2017/01/01', '2018/12/31'),
                      testthat::is_true())

testthat::expect_that(check_dates('2017 01 01', '2018 12 31'),
                      testthat::is_true())

testthat::expect_that(check_dates('2016-01-01', '2019-01-02'),
                      testthat::is_true())
