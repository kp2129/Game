<?php
session_start();

$dbHost = '127.0.0.1';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'knight_runner'; 

$conn = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(array("error" => "Database connection failed"));
    exit();
}

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);

if (empty($data['username']) || empty($data['password']) || empty($data['rpassword'])) { // Changed the condition to check for emptiness instead of non-emptiness
    http_response_code(400);
    echo json_encode(array("error" => "Please provide both username and password"));
    exit();
}

if (empty($data['rpassword'])) { 
    http_response_code(400);
    echo json_encode(array("error" => "Please confirm your password"));
    exit();
}

$password = $data['password'];
$rpassword = $data['rpassword'];
if ($password !== $rpassword) {
    http_response_code(400); // Bad Request
    echo json_encode(array("error" => "Passwords do not match"));
    exit();
}

$username = $data['username'];

$stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    http_response_code(409); 
    echo json_encode(array("error" => "Username already exists"));
    exit();
}

$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
$stmt->bind_param("ss", $username, $hashedPassword);
if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Registration successful"));
} else {
    http_response_code(500);
    echo json_encode(array("error" => "Registration failed"));
}
?>
