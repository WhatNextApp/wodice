import 'dart:math';

String stringMethod(int die, counter, dieCount) {
  var str = '';
  str += '{' + die.toString() + '}' + '   ';
  return str;
}

List<String> rollDP(String dP, bool botchable, bool specialized, String d) {
  var diceAmount = int.parse(dP);
  var diff = int.parse(d);

  var dicePool = dicRoller(diceAmount);
  var rate = result(dicePool, botchable, specialized, diff);
  var resultStr;

  if ((rate < 0) && (botchable)) {
    resultStr = 'Botch';
  } else if (rate <= 0) {
    resultStr = 'No Successes!';
  } else {
    if (rate == 1) {
      resultStr = rate.toString() + ' Success';
    } else {
      resultStr = rate.toString() + ' Successes';
    }
  }

  var counter = 1;
  var dieCount = dicePool.length;
  var tenstr = '';
  var onestr = '';
  var succstr = '';
  var otherstr = '';
  for (var die in dicePool) {
    if (die == 1) {
      onestr += stringMethod(die, counter, dieCount);
    } else if (die == 10) {
      tenstr += stringMethod(die, counter, dieCount);
    } else if (die >= diff) {
      succstr += stringMethod(die, counter, dieCount);
    } else {
      otherstr += stringMethod(die, counter, dieCount);
    }
    counter++;
  }

  var dPStr = '';

  if (botchable && specialized) {
    dPStr += onestr + '\n' + otherstr + '\n' + succstr + '\n' + tenstr;
  } else if (botchable) {
    dPStr += onestr + '\n' + otherstr + '\n' + succstr + tenstr;
  } else if (specialized) {
    dPStr += onestr + otherstr + '\n' + succstr + '\n' + tenstr;
  } else {
    dPStr += onestr + otherstr + '\n' + succstr + tenstr;
  }

  return [resultStr, dPStr];
}

List dicRoller(int diceAmount) {
  var rng = Random();
  var resultList = [];

  for (var i = 1; i <= diceAmount; i++) {
    resultList.add(rng.nextInt(10) + 1);
  }
  resultList.sort();
  resultList = List.from(resultList.reversed);

  return resultList;
}

int result(dicePool, botchable, specialized, diff) {
  var res = numberOSuccs(dicePool, diff);
  var ones = countDie(dicePool, 1);
  var tens = countDie(dicePool, 10);

  if (botchable && specialized) {
    res -= ones;
    if (tens >= ones) {
      var leftTens = tens - ones;
      res += leftTens;
    }
  } else {
    if (botchable) {
      res -= ones;
    }
    if (specialized) {
      res += tens;
    }
  }
  return res;
}

int countDie(dicePool, int i) {
  var counter = 0;
  for (var die in dicePool) {
    if (die == i) {
      counter++;
    }
  }
  return counter;
}

int numberOSuccs(dicePool, diff) {
  var numOS = 0;
  for (var die in dicePool) {
    if (die >= diff) {
      numOS += 1;
    }
  }
  return numOS;
}
