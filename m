Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgGCMZy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 08:25:54 -0400
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
 <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
 <d8b2ed8c-3948-1cba-47af-ef2a8cdf27ed@redhat.com>
 <0aaab65b-7856-9be9-c6dc-4da8e8d529d4@linux.ibm.com>
 <75982e29-5df8-abf3-57aa-ff717a4868d6@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <b475ca1d-4c34-a58f-d632-1d167cf39dfb@linux.ibm.com>
Date: Fri, 3 Jul 2020 14:25:47 +0200
MIME-Version: 1.0
In-Reply-To: <75982e29-5df8-abf3-57aa-ff717a4868d6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com, drjones@redhat.com



On 2020-07-03 14:01, Janosch Frank wrote:
> On 7/3/20 11:05 AM, Pierre Morel wrote:
>>
>>
>> On 2020-07-03 10:41, Thomas Huth wrote:
>>> On 02/07/2020 18.31, Pierre Morel wrote:
>>>> After a channel is enabled we start a SENSE_ID command using
>>>> the SSCH instruction to recognize the control unit and device.
>>>>
>>>> This tests the success of SSCH, the I/O interruption and the TSCH
>>>> instructions.
>>>>
>>>> The SENSE_ID command response is tested to report 0xff inside
>>>> its reserved field and to report the same control unit type
>>>> as the cu_type kernel argument.
>>>>
>>>> Without the cu_type kernel argument, the test expects a device
>>>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>> [...]
>>>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>>>> index 0ddceb1..9c22644 100644
>>>> --- a/lib/s390x/css.h
>>>> +++ b/lib/s390x/css.h
>>>> @@ -11,6 +11,8 @@
>>>>    #ifndef CSS_H
>>>>    #define CSS_H
>>>>    
>>>> +#define lowcore_ptr ((struct lowcore *)0x0)
>>>
>>> I'd prefer if you could either put this into the css_lib.c file or in
>>> lib/s390x/asm/arch_def.h.
>>
>> I have a patch ready for this :)
>> But I did not want to add too much new things in this series that could
>> start a new discussion.
>>
>> I have 2 versions of the patch:
>> - The simple one with just the declaration in arch_def.h
>> - The complete one with update of all tests (but smp) using a pointer to
>> lowcore.
>>
> 
> I've seen that patch on your branch and like most maintainers I'm not
> incredibly happy with patches touching a single line in a lot of files.
> 
> Maybe we can achieve a compromise and only clean up our library. The
> tests can be changed when they need to be touched for other changes.
> 
> Anyway for now I think css_lib.c might be the right place. We can talk
> about a lowcore cleanup next week if you want.

css_lib.c is not a good solution because the pointer is also needed in 
css.c.
So the question is css.h or arch_def.h

I have set it in css.h because Ithink it is better to keep it local 
until the others tests need/want to use the same way of accessing lowcore.


-- 
Pierre Morel
IBM Lab Boeblingen
