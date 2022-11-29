# Serial Modbus Spy - Publish captured data as Modbus TCP server

This addon spies on a serial Modbus RTU link
It publishes the captured information on a modbus TCP server port
So that integrations that connect to modbus/TCP can use the captured data

# Required hardware
Typically a low cost (<3 €) USB to RS485 can be connected in parallel to an existing Master-Slave connection.
![image](https://user-images.githubusercontent.com/11804014/204291048-0f7ec71e-9c80-4110-b74f-be5e0f8521e4.png)

Make sure not to swap the A and B leads:
- the A lead to the A lead 
- the B lead to the B lead.

This addon will only listen to the bus and will not write messages to the bus.
The addon captures both directions: Master->Slave and the response Slave->Master

# Installation

## As a HAOS addon (recommended)
Copy the ha-addon-modbusspy directory tree to your HomeAssistants /addons directory.
You may have to restart the host (not only the HA core) in order to make the addon visible.
After restart, go to settings->addons and to to the addon store.
The addon should be visible under de local addons.
Install it. This may take a while.



# Configuration

## As a HAOS addon (recommended)
Go back to the settings->addons page.
Select the ha-addon-modbusspy and go to the configuration tab.

<img width="458" alt="image" src="https://user-images.githubusercontent.com/11804014/204327933-e9ac0ef4-940d-4c2f-9c52-6f63163cfb20.png">

Select the proper serial port and baudrate.
By default, the addon will publish the data on tcp/502 externally (tcp/5020 internal)
Once the configuration is verified, go back to the main page and start the addon.
By default, the log level is warning, so it will not be very verbose

## Other configurations
The software can be run with the command python3 ha-addon-modbusspy.py
It will try to access a configuration file under /data/options.json or if that fails, it will try to load options.json simply in the working directory

> {
>  "loglevel": "warning",
>  "baud": "19200",
>  "device": "/dev/ttyUSB0",
>  "resync_gap": 0.1,
>  "tcpport": 5020,
>  "static_holdings_json": "{ \"0\": \"H34T0800000000\", \"7\": [18483, 13396, 13344, 12336 , 12336, 12336, 12336, 0] }"
> }


# Usage
Any system or integration that talks modbus to a tcp port (502 by default) can now read the captured registers.
This has been tested with the wills106/homeassistant-solax-modbus integration.

## Supported requests
The addon currently intercepts the calls:
- read_holding_registers
- read_input_registers

The response registers will be published as input or holding registers on the tcp modbus interface.

# Advanced use - static holding register declarations
Some applications may need registers that are not being polled by the master system.
Such registers can be declared in a static way in the configuration page by specifying the static_holding_json config entry:

static_holdings_json: '{ "0": "H34T0800000000", "7": [18483, 13396, 13344, 12336 , 12336, 12336, 12336, 0] }'

The declaration above declares a 14 character string (7 registers) at address 0, and 8 registers at address 7.
Typical use is to declare a serial number.
