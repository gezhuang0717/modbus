# sim4.cmd

<envPaths

dbLoadDatabase("../../dbd/modbus.dbd")
modbus_registerRecordDeviceDriver(pdbbase)

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName,
#                       const char *hostInfo,
#                       unsigned int priority,
#                       int noAutoConnect,
#                       int noProcessEos);
drvAsynIPPortConfigure("sim1","164.54.160.31:502",0,0,1)
#modbusInterposeConfig(const char *portName,
#                      modbusLinkType linkType,
#                      int timeoutMsec, 
#                      int writeDelayMsec)
modbusInterposeConfig("sim1",0,2000,0)

# Word access at Modbus address 0
# Access 1 words as inputs.  
# Function code=23, which is 123 for EPICS modbus driver
# default data type unsigned integer.
# drvModbusAsynConfigure("portName", "tcpPortName", slaveAddress, modbusFunction, modbusStartAddress, modbusLength, dataType, pollMsec, "plcType")
drvModbusAsynConfigure("A0_In_Word", "sim1", 0, 123, 0, 4, 0, 1000, "Simulator")

# Access 1 words as outputs.  
# Function code=23, which is 223 for EPICS modbus driver
# drvModbusAsynConfigure("portName", "tcpPortName", slaveAddress, modbusFunction, modbusStartAddress, modbusLength, dataType, pollMsec, "plcType")
drvModbusAsynConfigure("A0_Out_Word", "sim1", 0,223, 0, 4, 0, 1, "Simulator")

# Enable ASYN_TRACEIO_HEX on octet server
asynSetTraceIOMask("sim1",0,4)
# Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("sim1",0,9)

dbLoadTemplate("sim4.substitutions")

iocInit

