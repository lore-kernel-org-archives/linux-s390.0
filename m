Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728108AbgFJPKP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jun 2020 11:10:15 -0400
Subject: Re: [kvm-unit-tests PATCH v8 09/12] s390x: Library resources for CSS
 tests
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-10-git-send-email-pmorel@linux.ibm.com>
 <ef5e71b6-9c4d-ac3f-7946-f67db73d740b@redhat.com>
 <17e5ccdd-f2b2-00bd-4ee2-c0a0b78a669a@linux.ibm.com>
 <e2b1ac8d-f2cb-d913-a64d-a8237633d804@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <fc730d3f-20b0-37b8-cda9-c738315c4f85@linux.ibm.com>
Date: Wed, 10 Jun 2020 17:10:09 +0200
MIME-Version: 1.0
In-Reply-To: <e2b1ac8d-f2cb-d913-a64d-a8237633d804@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-10 16:51, Thomas Huth wrote:
> On 09/06/2020 17.01, Pierre Morel wrote:
>>
>>
>> On 2020-06-09 09:09, Thomas Huth wrote:
>>> On 08/06/2020 10.12, Pierre Morel wrote:
>>>> Provide some definitions and library routines that can be used by
>>
>> ...snip...
>>
>>>> +static inline int ssch(unsigned long schid, struct orb *addr)
>>>> +{
>>>> +    register long long reg1 asm("1") = schid;
>>>> +    int cc;
>>>> +
>>>> +    asm volatile(
>>>> +        "    ssch    0(%2)\n"
>>>> +        "    ipm    %0\n"
>>>> +        "    srl    %0,28\n"
>>>> +        : "=d" (cc)
>>>> +        : "d" (reg1), "a" (addr), "m" (*addr)
>>>
>>> Hmm... What's the "m" (*addr) here good for? %3 is not used in the
>>> assembly code?
>>
>> addr is %2
>> "m" (*addr) means memory pointed by addr is read
>>
>>>
>>>> +        : "cc", "memory");
>>>
>>> Why "memory" ? Can this instruction also change the orb?
>>
>> The orb not but this instruction modifies memory as follow:
>> orb -> ccw -> data
>>
>> The CCW can be a READ or a WRITE instruction and the data my be anywhere
>> in memory (<2G)
>>
>> A compiler memory barrier is need to avoid write instructions started
>> before the SSCH instruction to occur after for a write
>> and memory read made after the instruction to be executed before for a
>> read.
> 
> Ok, makes sense now, thanks!
> 
>>>> +static inline int msch(unsigned long schid, struct schib *addr)
>>>> +{
>>>> +    register unsigned long reg1 asm ("1") = schid;
>>>> +    int cc;
>>>> +
>>>> +    asm volatile(
>>>> +        "    msch    0(%3)\n"
>>>> +        "    ipm    %0\n"
>>>> +        "    srl    %0,28"
>>>> +        : "=d" (cc), "=m" (*addr)
>>>> +        : "d" (reg1), "a" (addr)
>>>
>>> I'm not an expert with these IO instructions, but this looks wrong to me
>>> ... Is MSCH reading or writing the SCHIB data?
>>
>> MSCH is reading the SCHIB data in memory.
> 
> So if it is reading, you don't need the  "=m" (*addr) in the output
> list, do you? You should rather use "m" (*addr) in the input list instead?

Yes, absolutely, it should be the oposite of stsch(), not the same!

I change it to:

         asm volatile(
                 "       msch    0(%3)\n"
                 "       ipm     %0\n"
                 "       srl     %0,28"
                 : "=d" (cc)
                 : "d" (reg1), "m" (*addr), "a" (addr)
                 : "cc");

Thanks,

Pierre

> 
>   Thomas
> 

-- 
Pierre Morel
IBM Lab Boeblingen
