From: Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [PATCH net-next 0/4] net/smc: fixes 2018/04/30
Date: Wed, 2 May 2018 16:53:43 +0200
Message-ID: <221a8063-d526-16bf-05d2-12e6229b773b@linux.ibm.com>
References: <20180430145119.72479-1-ubraun@linux.ibm.com>
 <20180430.210351.716233311438621264.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180430.210351.716233311438621264.davem@davemloft.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 05/01/2018 03:03 AM, David Miller wrote:
> From: Ursula Braun <ubraun@linux.ibm.com>
> Date: Mon, 30 Apr 2018 16:51:15 +0200
> 
>> From: Ursula Braun <ursula.braun@linux.ibm.com>
>>
>> Dave,
>>
>> here are 4 smc patches for net-next covering different areas:
>>    * link health check
>>    * diagnostics for IPv6 smc sockets
>>    * ioctl
>>    * improvement for vlan determination
> 
> You say "fixes" in your Subject line but adding ipv6 smc
> socket diag support is a feature not a fix.

Sorry, I just reused my old subject pattern without reflecting it.
These 4 patches are new features for SMC, and thus the title
should have been "net/smc: features 2018/04/30".

I am going to send v2 with such a title.

> 
> Actually, generally speaking your patch submissions are
> confusing.
> 
> You do submit really pure bug fixes, but for some odd
> reason you target the net-next tree instead of net.
>

> Maybe you have a good reason for doing this and you can
> explain it to me?
> 

Currently we just have one patch queue for upstream posting and
do not separate smc bug fixes from smc features. It is easier to
keep this patch queue and send them for net-next. Thus in the past
I have submitted bug fixes regarded as minor for net-next as well.
But in future I will send pure bug fixes always for net.
