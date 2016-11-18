console.log("oh yea");

function sum() {
  let sum = 0;
  let ary = Array.from(arguments);
  ary.forEach((e) => sum += e);

  console.log(sum);
}

function sum2(...args) {
  let sum = 0;

  args.forEach((e) => sum += e);

  console.log(sum);
}

Function.prototype.myBind = function (context) {
  let bindArgs = Array.from(arguments);
  return () =>  {
    return this.apply(context, bindArgs.concat(Array.from(arguments)));
  };
};

Function.prototype.myBind = function (context, ...bindArgs) {
   return (...callArgs) =>  {
     return this.apply(context, bindArgs.concat(callArgs));
   };
};

function curriedSum(num) {
  let i = 0;
  let sum = 0;
  return function adder(num) {
    sum += num;
    if (i < num) {
      i++;
      return adder;
    } else {
      return sum;
    }
  };
}

Function.prototype.curry = function (numArgs) {
  let args = [];
  let func = this;
  return function _args(...moreArgs) {
    args = args.concat(moreArgs);
    if (args.length < numArgs) {
      return _args;
    } else {
      return func.apply(func, args);
    }
  };
};
