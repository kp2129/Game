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

if (empty($data['token'])) {
    http_response_code(400); 
    echo json_encode(array("error" => "Please provide a token"));
    exit();
}

$token = $data['token'];

// Validate token
$userId = getUserIdFromToken($token);

if ($userId) {
    http_response_code(200);
    echo json_encode(array("message" => "Token is valid"));
    exit();
} else {
    http_response_code(401);
    echo json_encode(array("error" => "Invalid token"));
    exit();
}

function getUserIdFromToken($token) {
    global $conn;
    $stmt = $conn->prepare("SELECT id FROM users WHERE token = ?");
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    return $user ? $user['id'] : null;
}
?>
