
MIXED hits BY period condition tertile
  /FIXED = period condition tertile condition*tertile period*condition period*tertile  
    period*condition*tertile | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

* Tried all combination of factors
Use RLL/AIC/BIC to determine which is best
Best combination of fixed effects used below:

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

DATASET DECLARE IC.
OMS
 /SELECT TABLES
 /IF COMMANDS = ["Mixed"]
     SUBTYPES = ["Information Criteria"]
 /DESTINATION FORMAT = SAV NUMBERED = TableNumber_
  OUTFILE = IC.

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UN).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UNR).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(VC).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TPH).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TP).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ID).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(HF).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FAH1).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(DIAG).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSR).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSH).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARMA11).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARH1).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1).

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AD1).

OMSEND TAG=ALL.

*Data inspection using best covar structure

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1)
  /EMMEANS = TABLES(condition*period) COMPARE (condition) ADJ(LSD).

*** Final model
      Best residual matrix chosen: First Order Ante-Dependence
      Estimated marginal means output
      Residuals saved for examination as RESIDs
      Contrasts to be conducted:

MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV LMATRIX
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1)
  /EMMEANS = TABLES(condition*period) COMPARE (condition) ADJ(LSD)
  /SAVE RESID (residuals).

OMSEND TAG=ALL.
