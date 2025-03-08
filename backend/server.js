const express = require("express");
const { Pool } = require("pg");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(express.json());
app.use(cors());

// PostgreSQL Database Connection
const pool = new Pool({
  user: "postgres",
  host: "localhost", // Use 'localhost' if PostgreSQL is running locally
  database: "petadoption",
  password: "123456",
  port: 5432, 
});

// Test Database Connection
pool.connect((err, client, release) => {
  if (err) {
    console.error("Database connection failed!", err);
  } else {
    console.log("✅ Connected to PostgreSQL successfully!");
  }
  release();
});

// Start the Server
app.listen(3000, () => console.log("🚀 Server running on port 3000"));
