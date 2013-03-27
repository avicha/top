http = require 'yi-http'
_ = require 'underscore'
dateutil = require 'date-utils'
crypto = require 'crypto'
class TOP
    constructor:(config)->
        @init config if config
        @
    init : (config)->
        self = @
        if config&&config.appkey&&config.secret
            self._appkey = config.appkey
            self._secret = config.secret
            self._session = config.session if config.session
            self._init = true
        else
            throw new Error "please input the appkey and the secret"
        @
    api : (config, requestType, callback)->
        self = @
        if !self._init
            throw new Error "please init the appkey and the secret"
        if !callback&&_.isFunction requestType
            callback = requestType
            requestType = 'get'
        params = 
            method: config.method
            timestamp: new Date().toFormat('YYYY-MM-DD HH24:MI:SS')
            format: 'json'
            app_key: self._appkey
            v: '2.0'
            sign_method: 'md5'
        params.session = self._session if self._session
        _.extend params, config
        str = self._secret
        keys = _.keys(params).sort()
        for key in keys
            str+=(key+params[key])
        str += self._secret
        md5 = crypto.createHash 'md5'
        md5.update str, 'utf8'
        sign = md5.digest('hex').toUpperCase()
        _.extend params, 
            sign: sign
        http[requestType] {
            host: 'http://gw.api.taobao.com'
            path: '/router/rest'
            data: params
            format:'json'
            retry:5
        }, (err, res)-> 
            if err || res.error_response
                callback err || res.error_response.sub_msg || res.error_response.msg, res
            else 
                callback err, res
    widget : (config, requestType, callback)-> 
        self = @
        if !self._init
            throw new Error "please init the appkey and the secret"
        if !callback&&_.isFunction requestType
            callback = requestType
            requestType = 'get'
        params = 
            app_key: self._appkey
            timestamp: Date.now()
        params.session = self._session if self._session
        _.extend params, config
        s = self._secret + 'app_key' + self._appkey + 'timestamp' + params.timestamp + self._secret
        hmac = crypto.createHmac 'md5', self._secret
        hmac.update s, 'utf8'
        sign = hmac.digest('hex').toUpperCase()
        #生成签名
        _.extend params, {sign: sign}
        http[requestType] {
            host: 'http://gw.api.taobao.com'
            path: '/widget/rest'
            data: params
            headers:
                Referer:'http://www.lovejingyi.com'
                Cookie:"timestamp=#{params.timestamp}; sign=#{params.sign}"
            format:'json'
            retry:5
        }, (err, res)-> 
            if err || res.error_response
                callback err || res.error_response.sub_msg || res.error_response.msg, res
            else
                callback err, res
module.exports = TOP