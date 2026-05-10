const express = require("express");
const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");

const app = express();
app.use(express.json());

const port = 3002;

const sqs = new SQSClient({
  region: process.env.AWS_REGION || "us-east-1"
});

const queueUrl = process.env.ORDER_QUEUE_URL;

app.get("/", (req, res) => {
  res.send("Order Service is running");
});

app.post("/orders", async (req, res) => {
  const order = {
    id: Date.now(),
    item: req.body.item || "demo-item",
    quantity: req.body.quantity || 1
  };

  if (queueUrl) {
    await sqs.send(
      new SendMessageCommand({
        QueueUrl: queueUrl,
        MessageBody: JSON.stringify(order)
      })
    );
  }

  res.status(201).json({
    message: "Order created",
    order,
    queued: Boolean(queueUrl)
  });
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(port, "0.0.0.0", () => {
  console.log(`Order service listening on port ${port}`);
});

