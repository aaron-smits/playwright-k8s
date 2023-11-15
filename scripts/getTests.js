// Script that runs "npx playwright test --list"
// and returns a valid json array of tests
// Sample input:
// ➜  playwright-k8s git:(main) ✗ npx playwright test --list
// Listing tests:
//   [chromium] › example.spec.ts:3:5 › has title
//   [chromium] › example.spec.ts:10:5 › get started link
// Total: 2 tests in 1 file
// Sample output:
// [
//   {"example.spec.ts:3"},
//   {"example.spec.ts:10"}
// ]

const { exec } = require("child_process");

const getTests = () => {
    return new Promise((resolve, reject) => {
        exec("npx playwright test --list", (error, stdout, stderr) => {
        if (error) {
            reject(error);
            return;
        }
        if (stderr) {
            reject(stderr);
            return;
        }
        const tests = stdout
            .split("\n")
            .filter((line) => line.includes("›"))
            .map((line, index) => {
                const test = line.split("›")[1].trim();
                return { index: `${index + 1}`, test: test };
            });
        resolve(tests);
        });
    });
}

const writeTests = async () => {
    const tests = await getTests();
    // Put the tests into the stdout
    console.log(JSON.stringify(tests));
    // const testsPath = path.join(__dirname, "../tests.json");
    // fs.writeFileSync(testsPath, JSON.stringify(tests));
}

writeTests();

