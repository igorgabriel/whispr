import express from 'express';
import axios from 'axios';
import dotenv from 'dotenv'; 

dotenv.config();
const app = express();
app.use(express.json());

app.get('/hello', async (req, res) => {
  const response = await axios.get('https://jsonplaceholder.typicode.com/posts/1');
  res.json({ message: 'Hello World', externalData: response.data });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Whispr ZK API running on port ${PORT}`);
});