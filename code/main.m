% Main Project for LE-EECS 1011
% Vaughn Chan @ 2023-12-05

%{ 
    Possible states.
        "initialized"   Temporary state to indicate program is starting
        "rest"          In rest state, pump is always off
        "active"        In active state, pump is always on

        "exit"          Program has exited normally

        "failure"      Turn off pump immediately and exit program with
                       errors. What a terrible failure!
%}
% dht20Sensor.readTemperature
if ~exist("mc", "var")
    mc = arduino("/dev/ttyUSB0", "Nano3");
    dht20Sensor = dht20(mc);
end

wps = WaterPlantSystem(mc, dht20Sensor, "A0", "D2", "D4", "D3");

while 1
    moisture = wps.getMoisture();
    tmpF = wps.getTemperatureF();
    wps.updateGraph()
    dlog("info", string(wps.getTemperatureF()));
    
    % Check if moisture is less than 55%
    if wps.getMoisture() < 55
        wps.turnOnPump(0.01, 2);
        wps.updateGraph()
    end

    % Check its temperature
    if tmpF <= 50
        wps.turnOnLight();
        wps.playSound();
    elseif tmpF <= 60
        wps.turnOnLight();
    elseif tmpF >= 65 && tmpF <= 75
        wps.turnOffLight();
    elseif tmpF > 80
        wps.playSound();
    end
end
