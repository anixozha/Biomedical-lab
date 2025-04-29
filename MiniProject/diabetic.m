% Load the dataset
data = readtable('diabetes.csv');

% Display first few rows
disp(head(data));

% Dataset size and statistics
disp(size(data));
disp(summary(data));

% Separate features and labels
X = data{:, 1:end-1};
Y = data{:, end};

% Standardize the data
X = (X - mean(X)) ./ std(X);

% Train the SVM model
SVMModel = fitcsvm(X, Y, 'KernelFunction', 'linear');

% Sample input data
input_data = [2, 138, 62, 35, 135, 33.6, 0.127, 47;
              0, 84, 82, 31, 125, 38.2, 0.233, 23;
              5, 166, 72, 19, 175, 25.8, 0.587, 51;
              7, 100, 70, 25, 79, 31.6, 0.949, 53];

% Preprocess the input data
input_data = (input_data - mean(data{:, 1:end-1})) ./ std(data{:, 1:end-1});

% Predict using the trained model
predictions = predict(SVMModel, input_data);

% Display predictions
for i = 1:numel(predictions)
    if predictions(i) == 0
        disp(['Sample ', num2str(i), ': The person is not diabetic']);
    else
        disp(['Sample ', num2str(i), ': The person is diabetic']);
    end
end
