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

if (empty($data['score']) || empty($data['token'])) {
    http_response_code(400);
    echo json_encode(array("error" => "Please provide both score and token"));
    exit();
}

$score = $data['score'];
$token = $data['token'];
$coins = $data['coins'];
// Get user ID from token
$userId = getUserIdFromToken($token);

if (!$userId) {
    http_response_code(401);
    echo json_encode(array("error" => "Invalid token"));
    exit();
}

$insertStmt = $conn->prepare("UPDATE users SET coins = ? WHERE id = ?");
$insertStmt->bind_param("ii", $coins, $userId);
$insertStmt->execute();

// Insert score, timestamp, and user ID into history table
$insertStmt = $conn->prepare("INSERT INTO history (user_id, score, `date`) VALUES (?, ?, CURRENT_TIMESTAMP)");
$insertStmt->bind_param("ii", $userId, $score);
$insertStmt->execute();

if ($insertStmt->affected_rows > 0) {
    http_response_code(201); // Created
    echo json_encode(array("message" => "Score added to history"));
    exit();
} else {
    http_response_code(500); // Internal Server Error
    echo json_encode(array("error" => "Failed to add score to history"));
    exit();
}

function getUserIdFromToken($token)
{
    global $conn;
    $stmt = $conn->prepare("SELECT id FROM users WHERE token = ?");
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    return $user ? $user['id'] : null;
}
?>
