import 'dart:math';

String stringMethod(int die, counter, dieCount) {
  String str = '';
  str += '{$die}   ';
  return str;
}

List<String> rollDP(String dP, bool botchable, bool specialized, String d) {
  int diceAmount = int.parse(dP);
  int diff = int.parse(d);

  List<dynamic> dicePool = dicRoller(diceAmount);
  int rate = result(dicePool, botchable, specialized, diff);
  String resultStr;

  if ((rate < 0) && (botchable)) {
    resultStr = 'Botch';
  } else if (rate <= 0) {
    resultStr = 'No Successes!';
  } else {
    if (rate == 1) {
      resultStr = '$rate Success';
    } else {
      resultStr = '$rate Successes';
    }
  }

  int counter = 1;
  int dieCount = dicePool.length;
  String tenstr = '';
  String onestr = '';
  String succstr = '';
  String otherstr = '';
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

  String dPStr = '';

  if (botchable && specialized) {
    dPStr += '$onestr\n$otherstr\n$succstr\n$tenstr';
  } else if (botchable) {
    dPStr += '$onestr\n$otherstr\n$succstr$tenstr';
  } else if (specialized) {
    dPStr += '$onestr$otherstr\n$succstr\n$tenstr';
  } else {
    dPStr += '$onestr$otherstr\n$succstr$tenstr';
  }

  return [resultStr, dPStr];
}

List dicRoller(int diceAmount) {
  Random rng = Random();
  List<dynamic> resultList = [];

  for (var i = 1; i <= diceAmount; i++) {
    resultList.add(rng.nextInt(10) + 1);
  }
  resultList.sort();
  resultList = List.from(resultList.reversed);

  return resultList;
}

int result(dicePool, botchable, specialized, diff) {
  int res = numberOSuccs(dicePool, diff);
  int ones = countDie(dicePool, 1);
  int tens = countDie(dicePool, 10);

  if (botchable && specialized) {
    res -= ones;
    if (tens >= ones) {
      int leftTens = tens - ones;
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
  int counter = 0;
  for (var die in dicePool) {
    if (die == i) {
      counter++;
    }
  }
  return counter;
}

int numberOSuccs(dicePool, diff) {
  int numOS = 0;
  for (var die in dicePool) {
    if (die >= diff) {
      numOS += 1;
    }
  }
  return numOS;
}
