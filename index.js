const express = require('express');
const { exec } = require('child_process');

const app = express();
const port = 3000; // Adjust the port as needed

app.get('/', (req, res) => {
  // Run your shell script using child_process
  exec('./index.sh', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error executing script: ${error}`);
      return res.status(500).send('Internal Server Error');
    }

    console.log(`Script output: ${stdout}`);
    console.error(`Script errors: ${stderr}`);

    res.send('Script executed successfully.');
  });
});

app.listen(port, () => {
  console.log(`Express server is running on port ${port}`);
});

