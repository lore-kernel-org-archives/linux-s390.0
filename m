Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfICIwI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 04:52:08 -0400
Subject: Re: [kvm-unit-tests PATCH 1/6] s390x: Use interrupts in SCLP and add
 locking
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-2-frankja@linux.ibm.com>
 <74d31bb9-4941-01f3-571b-8a89a05402c8@redhat.com>
 <4309b6ea-e479-f25d-276a-6d8260d4f19f@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c5d5bc3f-dd32-fc6c-a709-b6bff9dd3ae1@redhat.com>
Date: Tue, 3 Sep 2019 10:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <4309b6ea-e479-f25d-276a-6d8260d4f19f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 03.09.19 09:53, Janosch Frank wrote:
> On 8/30/19 2:21 PM, David Hildenbrand wrote:
>> On 29.08.19 14:14, Janosch Frank wrote:
>>> We need to properly implement interrupt handling for SCLP, because on
>>> z/VM and LPAR SCLP calls are not synchronous!
>>>
>>> Also with smp CPUs have to compete for sclp. Let's add some locking,
>>> so they execute sclp calls in an orderly fashion and don't compete for
>>> the data buffer.
> 
> [...]
> 
>>> +
>>> +void sclp_mark_busy(void)
>>> +{
>>> +	/*
>>> +	 * With multiple CPUs we might need to wait for another CPU's
>>> +	 * request before grabbing the busy indication.
>>> +	 */
>>> +retry_wait:
>>> +	sclp_wait_busy();
>>> +	spin_lock(&sclp_lock);
>>> +	if (sclp_busy) {
>>> +		spin_unlock(&sclp_lock);
>>> +		goto retry_wait;
>>> +	}
>>> +	sclp_busy = true;
>>> +	spin_unlock(&sclp_lock);
>>
>> while (true) {
>> 	sclp_wait_busy();
>> 	spin_lock(&sclp_lock);
>> 	if (!sclp_busy) {
>> 		sclp_busy = true
>> 		spin_unlock(&sclp_lock);
>> 		break;
>> 	}
>> 	spin_unlock(&sclp_lock);
>> }
>>
>> Or can we simply switch to an atomic_t for sclp_busy and implement
>> cmpxchg using __sync_bool_compare_and_swap/ __sync_val_compare_and_swap ?
>>
>> I guess then we can drop the lock. But maybe I am missing something :)
> 
> If you want to add it and it works, I'm open for it :)
> Until then I'm taking your suggestion.
> 
>>
>>> +}
> [...]
>>>  extern char _sccb[];
>>> +void sclp_handle_ext(void);
>>> +void sclp_wait_busy(void);
>>> +void sclp_mark_busy(void);
>>
>> I wonder if we can find better names ...
>>
>> sclp_prepare()
>> sclp_finalize()
>>
>> or sth like that.
> 
> Hmm, IMHO my names are a bit better, since they clearly state, that we
> wait until the other user has finished.
> 
> 

I don't like "sclp_wait_busy()" as it is not clear from the name that we
are waiting until we can mark it busy :) It is rather a
"sclp_wait_not_busy()" + marking it busy.

I'm not able to come up with a better name right now :)

-- 

Thanks,

David / dhildenb
