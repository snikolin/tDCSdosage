
MIXED rt BY period condition tertile
  /FIXED = period condition tertile condition*tertile period*condition period*tertile  
    period*condition*tertile | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

* Tried all combination of factors
Use RLL/AIC/BIC to determine which is best
Best combination of fixed effects used below:

MIXED rt BY period condition tertile
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

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UN).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UNR).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(VC).

MIXED rt BY period condition tertile
   /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TPH).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TP).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ID).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(HF).

*MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FAH1).

*MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(DIAG).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSR).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSH).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARMA11).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARH1).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1).

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AD1).

OMSEND TAG=ALL.

*Data inspection using best covar structure

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1)
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD).

*** Final model
      Best residual matrix chosen: First Order Ante-Dependence
      Estimated marginal means output
      Residuals saved for examination as RESIDs
      Contrasts to be conducted:

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV LMATRIX
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1)
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD)
  /SAVE RESID (RESIDs).

  /TEST = 'Pre-post Treatments vs Control' 
      cond*occas -1 1 0 0 0 0 0 0 1 -1 0 0;
					  cond*occas 0 0 0 0 -1 1 0 0 1 -1 0 0
.

OMSEND TAG=ALL.


