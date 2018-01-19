Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Jan 2018 14:49:03 -0600
Message-ID: <20180119144903.Horde.tbajXZQzjH9kwd_yYPMI5mo@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] smc: return boolean instead of integer in using_ipsec
References: <20180118233323.GA22539@embeddedor.com>
 <0eadb528-9d82-3e0d-dc21-cd61244900e5@linux.vnet.ibm.com>
In-Reply-To: <0eadb528-9d82-3e0d-dc21-cd61244900e5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Ursula,

Quoting Ursula Braun <ubraun@linux.vnet.ibm.com>:

> On 01/19/2018 12:33 AM, Gustavo A. R. Silva wrote:
>> Return statements in functions returning bool should use
>> true/false instead of 1/0.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  net/smc/smc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 0bee9d1..ef13af4 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -258,7 +258,7 @@ static inline bool using_ipsec(struct smc_sock *smc)
>>  #else
>>  static inline bool using_ipsec(struct smc_sock *smc)
>>  {
>> -	return 0;
>> +	return false;
>>  }
>>  #endif
>>
>
> Gustavo,
> thanks for reporting, but your improvement seems to be incomplete.  
> Besides changing
> line 260 of net/smc/smc.h, line 255 should be adapted the same way. Will you
> come up with a second patch version here?
>

You are correct. I'll send a new patch shortly.

Thanks for the feedback.
--
Gustavo
