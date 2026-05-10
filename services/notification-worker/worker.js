const {
  SQSClient,
  ReceiveMessageCommand,
  DeleteMessageCommand
} = require("@aws-sdk/client-sqs");

const region = process.env.AWS_REGION || "us-east-1";
const queueUrl = process.env.ORDER_QUEUE_URL;

const sqs = new SQSClient({ region });

async function pollQueue() {
  if (!queueUrl) {
    console.log("ORDER_QUEUE_URL is not set. Worker waiting...");
    return;
  }

  try {
    const response = await sqs.send(
      new ReceiveMessageCommand({
        QueueUrl: queueUrl,
        MaxNumberOfMessages: 1,
        WaitTimeSeconds: 10
      })
    );

    if (!response.Messages || response.Messages.length === 0) {
      console.log("No messages received");
      return;
    }

    for (const message of response.Messages) {
      console.log("Processing order notification:", message.Body);

      await sqs.send(
        new DeleteMessageCommand({
          QueueUrl: queueUrl,
          ReceiptHandle: message.ReceiptHandle
        })
      );

      console.log("Message processed and deleted");
    }
  } catch (error) {
    console.error("Worker error:", error.message);
  }
}

console.log("Notification worker started");

setInterval(pollQueue, 5000);

