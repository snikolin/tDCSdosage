MIXED hits BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1)
  /EMMEANS = TABLES(condition*period) COMPARE (condition) ADJ(LSD)
  /TEST = 'off vs active' 
      condition -0.5 -0.5 0 0 1
					 condition*period -0.5 -0.5 0 0 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'off vs sham' 
      condition 0 0 -0.5 -0.5 1
					 condition*period 0 0 -0.5 -0.5 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'interaction: off vs active' 
					 condition*period 0.5 0.5 0 0 -1 0 0 0 0 0 -0.5 -0.5 0 0 1 
  /TEST = 'interaction: off vs sham' 
					 condition*period 0 0 0.5 0.5 -1 0 0 0 0 0 0 0 -0.5 -0.5 1
.

MIXED rt BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(AR1)
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD)
  /TEST = 'off vs active' 
      condition -0.5 -0.5 0 0 1
					 condition*period -0.5 -0.5 0 0 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'off vs sham' 
      condition 0 0 -0.5 -0.5 1
					 condition*period 0 0 -0.5 -0.5 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'interaction: off vs active' 
					 condition*period 0.5 0.5 0 0 -1 0 0 0 0 0 -0.5 -0.5 0 0 1 
  /TEST = 'interaction: off vs sham' 
					 condition*period 0 0 0.5 0.5 -1 0 0 0 0 0 0 0 -0.5 -0.5 1
.

MIXED dprime BY period condition tertile
  /FIXED = period condition tertile period*condition | SSTYPE(3)
  /METHOD=REML
  /PRINT = G R SOLUTION TESTCOV
  /REPEATED=period | SUBJECT(PID) COVTYPE(FA1)
  /EMMEANS = TABLES(condition*period) COMPARE(condition) ADJ(LSD)
  /TEST = 'off vs active' 
      condition -0.5 -0.5 0 0 1
					 condition*period -0.5 -0.5 0 0 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'off vs sham' 
      condition 0 0 -0.5 -0.5 1
					 condition*period 0 0 -0.5 -0.5 1 0 0 0 0 0 0 0 0 0 0 
  /TEST = 'interaction: off vs active' 
					 condition*period 0.5 0.5 0 0 -1 0 0 0 0 0 -0.5 -0.5 0 0 1 
  /TEST = 'interaction: off vs sham' 
					 condition*period 0 0 0.5 0.5 -1 0 0 0 0 0 0 0 -0.5 -0.5 1
.
