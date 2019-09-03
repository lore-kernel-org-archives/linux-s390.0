Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICK5D (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 06:57:03 -0400
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
 <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
 <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <012248ee-cd32-6ee4-7a47-21cb4e3dcc3e@redhat.com>
Date: Tue, 3 Sep 2019 12:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 03.09.19 12:53, Janosch Frank wrote:
> On 8/30/19 2:07 PM, David Hildenbrand wrote:
>> On 26.08.19 18:35, Janosch Frank wrote:
>>> For now let's concentrate on the error conditions.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
> [...]
>>> +static inline unsigned long stsi_get_fc(void *addr)
>>> +{
>>> +	register unsigned long r0 asm("0") = 0;
>>> +	register unsigned long r1 asm("1") = 0;
>>> +	int cc;
>>> +
>>> +	asm volatile("stsi	0(%3)\n"
>>> +		     "ipm	%[cc]\n"
>>> +		     "srl	%[cc],28\n"
>>> +		     : "+d" (r0), [cc] "=d" (cc)
>>> +		     : "d" (r1), "a" (addr)
>>
>> maybe [addr], so you can avoid the %3 above
> 
> Sure, maybe Thomas can also fix that on picking for the previous patch?
> 
>>
>>> +		     : "cc", "memory");
>>> +	assert(!cc);
>>> +	return r0 >> 28;
>>
>> I think I'd prefer "get_configuration_level()" and move it to an header
>> - because the fc actually allows more values (0, 15 ...) - however the
>> level can be used as an fc.
> 
> The rename works for me, but that's currently used only once, so why
> should it go to a header file?

No strong opinion about that, I would have moved it out of the test to
make the test itself more compact .

> 
> I though about starting lib/s390x/asm/misc-instr.h if we have enough (>=
> 2) instruction definitions which are shared.

-- 

Thanks,

David / dhildenb
