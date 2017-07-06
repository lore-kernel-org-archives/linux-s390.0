Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 12/18] drivers: s390: Move static and inline before return
 type
References: <cover.1499284835.git.joe@perches.com>
 <3f980cd89084ae09716353aba3171e4b3815e690.1499284835.git.joe@perches.com>
 <20170706102940.GG3217@osiris> <1499338639.19466.25.camel@perches.com>
 <20170706122539.GJ3217@osiris>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Thu, 6 Jul 2017 20:04:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170706122539.GJ3217@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a61fa6d0-9e34-adc4-bc1b-5e5abf1f64cc@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Joe Perches <joe@perches.com>
Cc: Klaus-Dieter Wacker <kdwacker@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/06/2017 02:25 PM, Heiko Carstens wrote:
> On Thu, Jul 06, 2017 at 03:57:19AM -0700, Joe Perches wrote:
>> On Thu, 2017-07-06 at 12:29 +0200, Heiko Carstens wrote:
>>> On Wed, Jul 05, 2017 at 01:02:21PM -0700, Joe Perches wrote:
>>>> Make the code like the rest of the kernel.
>> []
>>>> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.cqq
>> []
>>>> @@ -2408,7 +2408,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>>>>  	return rc;
>>>>  }
>>>>
>>>> -int inline qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
>>>> +inline int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
>>>>  {
>>>
>>> Actually the function could be made static, and "inline" should be removed,
>>> considering the large function body.
>>
>> I agree to a certain extent.
>>
>> It's only used once and  it looks like Klaus-Dieter Wacker
>> just missed adding static to this function.
>>
>> $ git log --stat -p -1 ce73e10ee0cb6
>> commit ce73e10ee0cb6cde1c5075a2803da0f0eb5b2324
>> Author: Klaus-Dieter Wacker <kdwacker@de.ibm.com>
>>
>> But it also looks like inline is too often used in several
>> drivers/s390/net/*.c files, where most of those static inline
>> functions are only used once.
>>
>> $ git grep -w inline drivers/s390/net/*.c | wc -l
>> 42
>>
>> Maybe inline removals should be a separate pass for all those.
> 
> Yes, Ursula or Julian can address this if they care.
> 
true, no shortage of inline in s390/net. I'll see about spending a few
OCD cycles on it...
