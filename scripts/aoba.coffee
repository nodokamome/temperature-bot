# Test.coffee
module.exports = (robot) ->

  robot.respond /何か飲む？/i, (msg) ->
    msg.reply msg.random ['コーヒー！ブラックで！', 'オレンジジュースで！', 'まだ未成年です！！']

  robot.respond /楽しい？/i, (msg) ->
    msg.reply msg.random ['今日も一日がんばるぞい！', '仕事楽しいですよ～、先輩も楽しんでます？']

  robot.respond /疲れた/i, (msg) ->
    msg.reply msg.random ['あと少しです！頑張りましょう！', '私も疲れました(＞＜) ちょっと休みましょうか。']
    
  robot.respond /open the pod bay doors/i, (res) ->
    res.reply "I'm afraid I can't let you do that."

  robot.respond /open the (.*) doors/i, (res) ->
    doorType = res.match[1]
    if doorType is "pod bay"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{doorType} doors"

  robot.hear /(.*)室温(.*)/i, (res) ->
    data = JSON.stringify({
      bot: 'aoba'
    })
    res.reply "はーい、今見てきますね！"
    url = "https://dev.nodokamome.com/outikansoku/api/v1/system/post/"
    res.http(url)
        .header('Content-Type', 'application/json')
        .post(data) (error, response, body) ->
          json = JSON.parse(body);
          res.send "#{json.result}\n\n日時：#{json.datetime}\n室温：#{json.temp} ℃\n湿度：#{json.hum} %"
