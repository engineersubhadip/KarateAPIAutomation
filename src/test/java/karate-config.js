function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log("karate.env system property was:", env);
  if (!env) {
    env = "dev";
  }
  var config = {
    baseURL: "https://conduit-api.bondaracademy.com/api/",
  };
  if (env == "dev") {
    config.userEmail = "karate011@test.com";
    config.userPassword = "Karate011";
  }
  if (env == "qa") {
    config.userEmail = "karate0112@test.com";
    config.userPassword = "Karate0112";
  }
  return config;
}
