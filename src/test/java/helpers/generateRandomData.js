function fn() {
  return {
    generateRandomEmail: function () {
      let result = "";
      for (let i = 0; i < 5; i++) {
        const randNum = Math.floor(Math.random() * 10) + 97;
        const randChar = String.fromCharCode(randNum);
        result += randChar;
      }
      const finalResult = result + "@test.com";
      return finalResult;
    },

    generateRandomUserName: function () {
      let result = "";
      for (let i = 0; i < 8; i++) {
        const randNum = Math.floor(Math.random() * 10) + 97;
        const randChar = String.fromCharCode(randNum);
        result += randChar;
      }
      return result;
    },
  };
}
