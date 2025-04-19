<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root";
$password = "";
$database = "student";

// Connect to MySQL
$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die(json_encode(["error" => "Database connection failed"]));
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    // Fetch all subject
    $sql = "SELECT * FROM subject";
    $result = $conn->query($sql);
    $subject = [];

    while ($row = $result->fetch_assoc()) {
        $subject[] = $row;
    }

    echo json_encode($subject);
}

$conn->close();
?>