# -*- coding: utf-8 -*-

class TheCthulhuHack < DiceBot
  RESOURCE_DICE = [4, 6, 8, 10, 12, 20]

  setPrefixes(['RD\d+'])

  def gameName
    'The Cthulhu Hack'
  end

  def gameType
    'TheCthulhuHack'
  end

  def getHelpMessage
    return <<MESSAGETEXT
・リソースダイス　RD(x)
　x：ダイス：4, 6, 8, 10, 12, 20のいずれか。
例）RD12
MESSAGETEXT
  end

  def rollDiceCommand(command)
    debug('RollDiceCommand Begin')

    case command
    when /^RD(\d+)$/
      return roll_resource_die($1)
    else
      return ''
    end

    debug('RollDiceCommand End')
  end

  def roll_resource_die(t)
    unless RESOURCE_DICE.include?(t.to_i)
      return "(RD#{t}) ＞ 有効なリソースダイスではありません"
    end

    r, = roll(1, t)
    s =
      if r == 1 || r == 2
        "失敗！　#{get_text_of_one_stepdown_from(t)}"
      else
        "成功！"
      end
    "(RD#{t}) ＞ #{r} ＞ #{s}"
  end

  def get_text_of_one_stepdown_from(t)
    i = RESOURCE_DICE.index(t.to_i)
    r =
      if i == 0
        "リソースダイスはなくなりました"
      else
        "リソースダイスはD#{RESOURCE_DICE[i-1]}にステップダウンしました"
      end
    r
  end
end
