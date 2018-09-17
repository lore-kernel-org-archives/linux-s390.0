Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
References: <20180915100036.20100-1-yuehaibing@huawei.com>
 <87zhwj6liz.fsf@igel.home>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <b598de63-f026-c3ff-3380-8b1814f90b82@huawei.com>
Date: Mon, 17 Sep 2018 11:57:40 +0800
MIME-Version: 1.0
In-Reply-To: <87zhwj6liz.fsf@igel.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: davem@davemloft.net, ubraun@linux.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2018/9/15 19:35, Andreas Schwab wrote:
> On Sep 15 2018, YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Comparing an int to a size, which is unsigned, causes the int to become
>> unsigned, giving the wrong result. kernel_sendmsg can return a negative
>> error code.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  net/smc/smc_clc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 83aba9a..fd0f5ce 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
>>  	vec[i++].iov_len = sizeof(trl);
>>  	/* due to the few bytes needed for clc-handshake this cannot block */
>>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
>> -	if (len < sizeof(pclc)) {
>> +	if (len < (int)sizeof(pclc)) {
>>  		if (len >= 0) {
>>  			reason_code = -ENETUNREACH;
>>  			smc->sk.sk_err = -reason_code;
> 
> It would perhaps be better to handle len < 0 first.

That need refactor the err hangding, is worth doing it?

> 
> Andreas.
> 
