function fn() {
  return {
    randomEmail: function () {
      let result = "";
      for (let i = 0; i < 8; i++) {
        const randomNum = Math.floor(Math.random() * 10) + 97;
        result += String.fromCharCode(randomNum);
      }
      return result + "@test.com";
    },
    randomUserName: function () {
      let firstHalf = "";
      for (let i = 0; i < 5; i++) {
        const randomNum = Math.floor(Math.random() * 10) + 97;
        firstHalf += String.fromCharCode(randomNum);
      }
      let secondHalf = "";
      for (let i = 0; i < 5; i++) {
        const randomNum = Math.floor(Math.random() * 10);
        secondHalf += randomNum;
      }
      return firstHalf + secondHalf;
    },
  };
}
