context("test_phe_quantiles")

# test grouped df field
df1 <- test_quantiles_g %>% filter(GroupSet == "IndSexReg")

# test grouped df logical
df2 <- test_quantiles_g %>% filter(IndSexRef == "90366Female"& GroupSet == "IndSexReg")

# test ungrouped df field
df3 <- test_quantiles_g %>% filter(GroupSet == "IndSex")

# test ungrouped df logical
df4 <- test_quantiles_ug %>% filter(GroupSet == "None")



#test calculations
test_that("quantiles calculate correctly",{
  expect_equal(data.frame(phe_quantile(df1,Value, ParentCode,
                            invert = Polarity, inverttype = "field")[15]),
               rename(df1,quantile = QuantileInGrp)[14],
               check.attributes=FALSE, check.names=FALSE,info="test grouped df field")

  expect_equal(phe_quantile(df2,Value, ParentCode,
                            invert = FALSE)[15:18],
               data.frame(tibble(quantile = df2$QuantileInGrp,
                      nquantiles = 10L,
                      highergeog_column = "ParentCode",
                      qinverted = "lowest quantile represents lowest values")),
               check.attributes=FALSE, check.names=FALSE,info="test grouped df logical")

  expect_equal(phe_quantile(df3, Value, IndSexRef,
                            invert = Polarity, inverttype = "field", nquantiles = 7L)[15],
               rename(df3,quantile = QuantileInGrp)[14],check.attributes=FALSE,
               check.names=FALSE,info="test ungrouped df field")

  expect_equal(phe_quantile(df4, Value, GroupSet, nquantiles = 4L)[15],
               rename(df4,quantile = QuantileInGrp)[14],
               check.attributes=FALSE, check.names=FALSE,info="test ungrouped df logical")

  expect_equal(phe_quantile(df4, Value, nquantiles = 4L)[15],
               rename(df4,quantile = QuantileInGrp)[14],
               check.attributes=FALSE, check.names=FALSE,info="test ungrouped df logical nohighergeog")

  expect_equal(phe_quantile(df4, Value, nquantiles = 4L, type="standard")[15],
               rename(df4,quantile = QuantileInGrp)[14],
               check.attributes=FALSE, check.names=FALSE,info="test ungrouped df logical nohighergeog")

})


#test error handling
test_that("quantiles - errors are generated when invalid arguments are used",{
  expect_error(phe_quantile(test_quantiles_g),
               "function phe_quantile requires at least 2 arguments: data and values",
               info="error invalid number of arguments")
  expect_error(phe_quantile(test_quantiles_g, Value, AreaCode, ParentCode,
                            invert = Polarity, inverttype = "vector"),
               "valid values for inverttype are logical and field",info="error inverttype is invalid")
  expect_error(phe_quantile(test_quantiles_g, Value, AreaCode, ParentCode,
                            invert = 6, inverttype = "logical"),
               "invert expressed as a logical must equal TRUE or FALSE",info="error logical invert is invalid")
  expect_error(phe_quantile(test_quantiles_g, AreaName, AreaCode, ParentCode,
                            invert = Polarity, inverttype = "field"),
               "values argument must be a numeric field from data",info="error value is invalid")
  expect_error(phe_quantile(test_quantiles_fail, Value, AreaCode, Ref_ug,
                            invert = Polarity, inverttype = "field"),
               "invert field values must take the same logical value for each data grouping set and highergeog",info="error invert varies")
  expect_error(phe_quantile(test_quantiles_fail, Value, AreaCode, Ref_ug,
                            invert = Pol, inverttype = "field"),
               "invert is not a field name from data",info="error invert not valid field name")
})
