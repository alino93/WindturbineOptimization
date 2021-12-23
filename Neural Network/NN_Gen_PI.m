inputs = PI_in;
targets = PI_out;
 
% Create a Fitting Network
hiddenLayerSize = 30;
net = feedforwardnet(hiddenLayerSize,'trainbr');

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
 
% Train the Network
[net,tr] = train(net,inputs,targets);
 
% Test the Network
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
 
% View the Network
view(net)