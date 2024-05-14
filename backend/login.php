<?php
session_start();

$dbHost = '127.0.0.1';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'knight_runner'; 

$conn = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);
if ($conn->connect_error) {
    http_response_code(500); // Internal Server Error
    echo json_encode(array("error" => "Database connection failed"));
    exit();
}

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);

if (empty($data['username']) || empty($data['password'])) {
    http_response_code(400); 
    echo json_encode(array("error" => "Please provide both username and password"));
    exit();
}

$username = $data['username'];
$password = $data['password'];

$stmt = $conn->prepare("SELECT id, username, `password`, `coins` FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if ($user) {
    if (password_verify($password, $user['password'])) {
        // Generate a unique token
        $token = bin2hex(random_bytes(32));

        // Store the token in session
        $_SESSION['token'] = $token;

        // Update token in the database
        $updateStmt = $conn->prepare("UPDATE users SET token = ? WHERE id = ?");
        $updateStmt->bind_param("si", $token, $user['id']);
        $updateStmt->execute();

        $payload = array(
            "user_id" => $user['id'],
            "username" => $user['username'],
            "coins" => $user['coins']
        );
        http_response_code(200);
        echo json_encode(array("message" => "Login successful", "data" => $payload, "token" => $token));
        exit();
    } else {
        http_response_code(401); 
        echo json_encode(array("error" => "Invalid username or password"));
        exit();
    }
} else {
    http_response_code(401);
    echo json_encode(array("error" => "Invalid username or password"));
    exit();
}
?>
