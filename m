Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgD1J1a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 05:27:30 -0400
Subject: Re: [kvm-unit-tests PATCH v6 08/10] s390x: define wfi: wait for
 interrupt
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-9-git-send-email-pmorel@linux.ibm.com>
 <4cc33b1c-7fa2-0775-f176-08bb31b7e68e@linux.ibm.com>
 <60b951c7-2fa2-2284-db04-33e422974626@linux.ibm.com>
 <84cf8f4f-4d29-8ff5-0d84-5c9b0b52ff34@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <f13ba67e-7b36-f184-f585-ec198be6f40b@linux.ibm.com>
Date: Tue, 28 Apr 2020 11:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <84cf8f4f-4d29-8ff5-0d84-5c9b0b52ff34@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-28 11:20, Janosch Frank wrote:
> On 4/28/20 10:44 AM, Pierre Morel wrote:
>>
>>
>> On 2020-04-27 14:59, Janosch Frank wrote:
>>> On 4/24/20 12:45 PM, Pierre Morel wrote:
>>>> wfi(irq_mask) allows the programm to wait for an interrupt.
>>>
>>> s/programm/program/
>>
>> Thx,
>>
>>>
>>>> The interrupt handler is in charge to remove the WAIT bit
>>>> when it finished handling interrupt.
>>>
>>> ...finished handling the interrupt.
>>
>> OK, thx
>>
>>>
>>
>>>>    }
>>>>    
>>>> +static inline void wfi(uint64_t irq_mask)
>>>
>>> enabled_wait()
>>
>>
>> I do not like enabled_wait(), we do not know what is enabled and we do
>> not know what we are waiting for.
>>
>> What about wait_for_interrupt()
> 
> As long as it's not called wfi...
> 
>>
>>>
>>>> +{
>>>> +	uint64_t psw_mask;
>>>
>>> You can directly initialize this variable.
>>>
>>>> +
>>>> +	psw_mask = extract_psw_mask();
>>>> +	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);
>>>
>>> Maybe add a comment here:
>>>
>>> /*
>>>    * After being woken and having processed the interrupt, let's restore
>>> the PSW mask.
>>> */
>>>
>>>> +	load_psw_mask(psw_mask);
>>>> +}
>>>> +
>>
>> I can do this, but wasn't it obvious?
> 
> It took me a minute, so it will take even longer for developers that are
> not yet familiar with s390 kernel development.
> 
>>
>>
>> Regards,
>> Pierre
>>
> 
> 

OK, will do
Thx

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
