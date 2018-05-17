% To generate input/output data for the water bath heater
n=0;%intitialize the counter
for a = 0:0.06:0.6,%increment the heat input at equal intervals
    %0.057 Kcal is equivalent to 250 watt
    for i=1:4, %index varaible
        Tp=45+rands(1,1)*20;%initialize the Tp between 25-65 C
        Ti=25+rands(1,1)*2;% initialize the Ti between 23-27 C
        F=1/60+rands(1,1)*0.008;% initialize tank fluid flow rate
        x0=[Tp];% initialize output rate
        %solving tank differential equations using runge kutta method
        options=[];
        %find response at different time instants 
        tspan=[0 30 120 150 240 270 390 420 540 570];
        %heaterwb defines the differential equation of waterbath system
        [t,x] = ode45('heaterWB',tspan,x0,options,Ti,a,F);
        %storing the differential input values in arrays to form input
        for i=1:2:9,
            n=n+1;
            rTp(n)=x(i,1);%store previous tank temperature
            rT(n)=x(i+1,1);%store output tank temperature
            rTi(n)=Ti;%store inlet tank temp
            rQ(n)=a;%store heat input
            rF(n)=F;%store tank fluid flow rate
        end;
    end;
end;
%store the training input data for the controller
trinC=[rF;rTi;rT;rTp];
%store the output training data for the controller
troutC=[rQ];
%save the training data set in MAT file traindataC1
save traindataC1 trinC troutC;

            