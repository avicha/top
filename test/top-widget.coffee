TOP = require '../index'
TopClient = new TOP appkey:'your_appkey',secret:'your_secret'
TopClient.widget
    method: 'taobao.taobaoke.widget.items.convert'
    fields: 'num_iid,click_url,commission,commission_rate,commission_num,commission_volume,shop_click_url,seller_credit_score,volume'
    num_iids: '16933971649,22817632561'
    outer_code: 'avicha'
,'post',(err,resp)->
    if err
        console.error err
    else
        console.log JSON.stringify resp