
MIXED dprime BY period condition tertile
  /FIXED = period condition tertile condition*tertile period*condition period*tertile  
    period*condition*tertile | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

* Tried all combination of factors
Use RLL/AIC/BIC to determine which is best
Best combination of fixed effects used below:

MIXED dprime BY period condition tertile
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

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UN).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(UNR).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(VC).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TPH).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(TP).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ID).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(HF).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FAH1).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(DIAG).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSR).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CSH).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(CS).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARMA11).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(ARH1).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1).

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /REPEATED=period | SUBJECT(PID) COVTYPE(AD1).

OMSEND TAG=ALL.

*Data inspection using best covar structure

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1) 
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD).

*** Final model
      Best residual matrix chosen: First Order Ante-Dependence
      Estimated marginal means output
      Residuals saved for examination as RESIDs
      Contrasts to be conducted:

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV LMATRIX
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1)
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD)
  /SAVE RESID (RESIDs).

  /TEST = 'Pre-post Treatments vs Control' 
      cond*occas -1 1 0 0 0 0 0 0 1 -1 0 0;
					  cond*occas 0 0 0 0 -1 1 0 0 1 -1 0 0
.

OMSEND TAG=ALL.


