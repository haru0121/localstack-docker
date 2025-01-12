exports.handler = async (event) => {
    console.log("Event: ", event);
    const response = {
        statusCode: 200,
        body:
          "The product of call",
      };
    return response;
  }