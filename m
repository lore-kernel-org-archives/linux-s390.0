Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3BC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 24 May 2022 02:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiEXC7x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiEXC7w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 22:59:52 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E859CF12;
        Mon, 23 May 2022 19:59:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEG.hal_1653361186;
Received: from 30.43.105.196(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VEG.hal_1653361186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 10:59:47 +0800
Message-ID: <45a19f8b-1b64-3459-c28c-aebab4fd8f1e@linux.alibaba.com>
Date:   Tue, 24 May 2022 10:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH net-next v2] net/smc: align the connect behaviour with TCP
Content-Language: en-US
To:     Karsten Graul <kgraul@linux.ibm.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220513022453.7256-1-guangguan.wang@linux.alibaba.com>
 <3f0405e7-d92b-e8d0-cc61-b25a11644264@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <3f0405e7-d92b-e8d0-cc61-b25a11644264@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2022/5/23 20:24, Karsten Graul wrote:
> On 13/05/2022 04:24, Guangguan Wang wrote:
>> Connect with O_NONBLOCK will not be completed immediately
>> and returns -EINPROGRESS. It is possible to use selector/poll
>> for completion by selecting the socket for writing. After select
>> indicates writability, a second connect function call will return
>> 0 to indicate connected successfully as TCP does, but smc returns
>> -EISCONN. Use socket state for smc to indicate connect state, which
>> can help smc aligning the connect behaviour with TCP.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Acked-by: Karsten Graul <kgraul@linux.ibm.com>
>> ---
>>  net/smc/af_smc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index fce16b9d6e1a..5f70642a8044 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1544,9 +1544,29 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>>  		goto out_err;
>>  
>>  	lock_sock(sk);
>> +	switch (sock->state) {
>> +	default:
>> +		rc = -EINVAL;
>> +		goto out;
>> +	case SS_CONNECTED:
>> +		rc = sk->sk_state == SMC_ACTIVE ? -EISCONN : -EINVAL;
>> +		goto out;
>> +	case SS_CONNECTING:
>> +		if (sk->sk_state == SMC_ACTIVE)
>> +			goto connected;
> 
> I stumbled over this when thinking about the fallback processing. If for whatever reason
> fallback==true during smc_connect(), the "if (smc->use_fallback)" below would set sock->state
> to e.g. SS_CONNECTED. But in the fallback case sk_state keeps SMC_INIT. So during the next call
> the SS_CONNECTING case above would break because sk_state in NOT SMC_ACTIVE, and we would end
> up calling kernel_connect() again. Which seems to be no problem when kernel_connect() returns 
> -EISCONN and we return this to the caller. But is this how it should work, or does it work by chance?
> 

Since the sk_state keeps SMC_INIT and does not correctly indicate the state of clcsock, it should end
up calling kernel_connect() again to get the actual connection state of clcsock.

And I'm sorry there is a problem that if sock->state==SS_CONNECTED and sk_state==SMC_INIT, further call
of smc_connect will return -EINVAL where -EISCONN is preferred. 
The steps to reproduce:
1）switch fallback before connect, such as setsockopt TCP_FASTOPEN
2）connect with noblocking and returns -EINPROGRESS. (sock->state changes to SS_CONNECTING)
3) end up calling connect with noblocking again and returns 0. (kernel_connect() returns 0 and sock->state changes to
   SS_CONNECTED but sk->sk_state stays SMC_INIT)
4) call connect again, maybe by mistake, will return -EINVAL, but -EISCONN is preferred.

What do you think about if we synchronize the sk_state to SMC_ACTIVE instead of keeping SMC_INIT when clcsock
connected successfully in fallback case described above.

...
if (smc->use_fallback) {
	sock->state = rc ? SS_CONNECTING : SS_CONNECTED;
	if (!rc)
		sk->sk_state = SMC_ACTIVE;    /* synchronize sk_state from SMC_INIT to SMC_ACTIVE */
	goto out;
}
...

>> +		break;
>> +	case SS_UNCONNECTED:
>> +		sock->state = SS_CONNECTING;
>> +		break;
>> +	}
>> +
>>  	switch (sk->sk_state) {
>>  	default:
>>  		goto out;
>> +	case SMC_CLOSED:
>> +		rc = sock_error(sk) ? : -ECONNABORTED;
>> +		sock->state = SS_UNCONNECTED;
>> +		goto out;
>>  	case SMC_ACTIVE:
>>  		rc = -EISCONN;
>>  		goto out;
>> @@ -1565,20 +1585,24 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>>  		goto out;
>>  
>>  	sock_hold(&smc->sk); /* sock put in passive closing */
>> -	if (smc->use_fallback)
>> +	if (smc->use_fallback) {
>> +		sock->state = rc ? SS_CONNECTING : SS_CONNECTED;
>>  		goto out;
>> +	}
>>  	if (flags & O_NONBLOCK) {
>>  		if (queue_work(smc_hs_wq, &smc->connect_work))
>>  			smc->connect_nonblock = 1;
>>  		rc = -EINPROGRESS;
>> +		goto out;
>>  	} else {
>>  		rc = __smc_connect(smc);
>>  		if (rc < 0)
>>  			goto out;
>> -		else
>> -			rc = 0; /* success cases including fallback */
>>  	}
>>  
>> +connected:
>> +	rc = 0;
>> +	sock->state = SS_CONNECTED;
>>  out:
>>  	release_sock(sk);
>>  out_err:
