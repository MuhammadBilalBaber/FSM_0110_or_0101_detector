clear -all

analyze -sv12 FSM_0101_or_0110_detector.sv  

elaborate -top pattern_0110_or_0101_detector -create_related_covers {precondition witness}

clock clk
reset reset

##Deadlock, live_lock, and deadcode verification
check_superlint -init
config_rtlds -rule -enable -tag { FSM_IS_DLCK FSM_IS_LLCK }
check_superlint -extract

# command to run
# jg fsm.tcl
