const express = require("express");
const app = express();

const port = 3001;

app.get("/", (req, res) => {
  res.send("User Service is running and CI/CD working");
});

app.get("/users", (req, res) => {
  res.json([
    { id: 1, name: "Alice" },
    { id: 2, name: "Bob" }
  ]);
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(port, "0.0.0.0", () => {
  console.log(`User service listening on port ${port}`);
});

