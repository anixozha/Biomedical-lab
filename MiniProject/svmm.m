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

% Train-test split
cv = cvpartition(size(data, 1), 'HoldOut', 0.2);
X_train = X(training(cv), :);
Y_train = Y(training(cv), :);
X_test = X(test(cv), :);
Y_test = Y(test(cv), :);

% Train the SVM model
SVMModel = fitcsvm(X_train, Y_train, 'KernelFunction', 'linear');

% Evaluate the model
Y_train_pred = predict(SVMModel, X_train);
Y_test_pred = predict(SVMModel, X_test);

train_accuracy = mean(Y_train_pred == Y_train);
test_accuracy = mean(Y_test_pred == Y_test);

fprintf('Training Accuracy: %.2f%%\n', train_accuracy * 100);
fprintf('Testing Accuracy: %.2f%%\n', test_accuracy * 100);

% Save the trained SVM model
% save('trained_SVM_model.mat', 'SVMModel');

% Predictive system
input_data = [10,115,0,0,0,35.3,0.134,29];
input_data = (input_data - mean(data{:, 1:end-1})) ./ std(data{:, 1:end-1});
prediction = predict(SVMModel, input_data);

if prediction == 0
    disp('The person is not diabetic');
else
    disp('The person is diabetic');
end
