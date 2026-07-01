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

    generateRandomTitle: function () {
      let result = "";
      for (let i = 0; i < 10; i++) {
        const randASCII = Math.floor(Math.random() * 26) + 97;
        const randChar = String.fromCharCode(randASCII);
        result += randChar;
      }
      return result;
    },

    generateRandomDescription: function () {
      let result = "";
      for (let i = 0; i < 22; i++) {
        const randASCII = Math.floor(Math.random() * 26) + 97;
        const randChar = String.fromCharCode(randASCII);
        result += randChar;
      }
      return result;
    },

    generateRandomBody: function () {
      let result = "";
      for (let i = 0; i < 50; i++) {
        const randASCII = Math.floor(Math.random() * 26) + 97;
        const randChar = String.fromCharCode(randASCII);
        result += randChar;
      }
      return result;
    },
  };
}
