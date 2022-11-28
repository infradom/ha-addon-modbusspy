# ha-addon-modbusspy

This addon spies on a serial Modbus RTU link
It publishes the captured information on a modbus TCP server port
So that integrations that connect to modbus/TCP can use the captured data

# required hardware
Typically a low cost (<3 €) USB to RS485 can be connected in parallel to an existing Master-Slave connection.
Make sure to connect not to swap the A and B leads:
- the A lead to the A lead 
- the B lead to the B lead.

This addon will only listen to the bus and will not write messages to the bus.
The addon captures both directions: Master->Slave and the response Slave->Master

# installation
Copy the ha-addon-modbusspy directory tree to your HomeAssistants /addons directory.
You may have to restart the host (not only the HA core) in order to make the addon visible.
After restart, go to settings->addons and to to the addon store.
The addon should be visible under de local addons.
Install it. This may take a while.

# configuration
Go back to the settings->addons page.
Select the ha-addon-modbusspy and go to the configuration tab.
Select the proper serial port and baudrate.
By default, the addon will publish the data on tcp/502 externally (tcp/5020 internal)
Once the configuration is verified, go back to the main page and start the addon.
By default, the log level is warning, so it will not be very verbose

# use
Any system or integration that talks modbus to a tcp port (502 by default) can now read the captured registers.
This has been tested with the wills106/homeassistant-solax-modbus integration.

# advanced use - static holding register declarations
Some applications may need registers that are not being polled by the master system.
Such registers can be declared in a static way in the configuration page by specifying the static_holding_json config entry:

static_holdings_json: '{ "0": "H34T0800000000", "7": [18483, 13396, 13344, 12336 , 12336, 12336, 12336, 0] }'

The declaration above declares a 14 character string (7 registers) at address 0, and 8 registers at address 7.
Typical use is to declare a serial number.
