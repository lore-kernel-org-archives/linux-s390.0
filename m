Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] smc: return booleans instead of integers
References: <20180119205450.GA10785@embeddedgus>
 <e8d5d07e-a784-b9b8-4fea-5826a3d42698@linux.vnet.ibm.com>
 <1516667515.8378.24.camel@perches.com>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 12:44:01 +0100
MIME-Version: 1.0
In-Reply-To: <1516667515.8378.24.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <032c06a8-e9ce-9c06-d142-70bfeae2117a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/23/2018 01:31 AM, Joe Perches wrote:
> On Mon, 2018-01-22 at 12:58 +0100, Ursula Braun wrote:
>>
>> On 01/19/2018 09:54 PM, Gustavo A. R. Silva wrote:
>>> Return statements in functions returning bool should use
>>> true/false instead of 1/0.
>>>
>>> This issue was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>> Changes in v2:
>>>  - Fix function using_ipsec as suggested by Ursula Braun.
>>>  - Update subject line.
>>>
>>>  net/smc/smc.h | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/smc/smc.h b/net/smc/smc.h
> []
>>> @@ -253,12 +253,12 @@ static inline int smc_uncompress_bufsize(u8 compressed)
>>>  static inline bool using_ipsec(struct smc_sock *smc)
>>>  {
>>>  	return (smc->clcsock->sk->sk_policy[0] ||
>>> -		smc->clcsock->sk->sk_policy[1]) ? 1 : 0;
>>> +		smc->clcsock->sk->sk_policy[1]) ? true : false;
> 
> Generally, any bool return like
> 
> 	return condition ? true : false;
> 
> could be written
> 
> 	return condition;
> 
This would be shorter, but is it really better readable/understandable?
Do you have a reference for us confirming your proposed style is the way to go?
