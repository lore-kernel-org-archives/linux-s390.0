Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbfKNQPU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:15:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEG45pb053574
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:15:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w99ck2umd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:15:19 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 16:15:17 -0000
Subject: Re: [PATCH v1 1/4] s390x: saving regs for interrupts
References: <6c84ade5-8a42-9c73-abff-47e019fc11bd@linux.ibm.com>
 <7C13E9AB-F26B-439B-A170-F187BC1E1136@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:15:14 +0100
MIME-Version: 1.0
In-Reply-To: <7C13E9AB-F26B-439B-A170-F187BC1E1136@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <e908c728-59ad-0a30-5721-e96500fd0f67@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <dhildenb@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com


On 2019-11-14 16:25, David Hildenbrand wrote:
>
>> Am 14.11.2019 um 16:21 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>>
>> ﻿
>>> On 2019-11-14 13:11, David Hildenbrand wrote:
>>>> On 14.11.19 12:57, Pierre Morel wrote:
>>>>
>>>> On 2019-11-14 11:28, David Hildenbrand wrote:
>>>>>> Am 14.11.2019 um 11:11 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>>>>>>
>>>>>> ﻿
>>>>>>> On 2019-11-13 17:12, Janosch Frank wrote:
>>>>>>>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>>>>>>> If we use multiple source of interrupts, for exemple, using SCLP console
>>>>>>>> to print information while using I/O interrupts or during exceptions, we
>>>>>>>> need to have a re-entrant register saving interruption handling.
>>>>>>>>
>>>>>>>> Instead of saving at a static place, let's save the base registers on
>>>>>>>> the stack.
>>>>>>>>
>>>>>>>> Note that we keep the static register saving that we need for the RESET
>>>>>>>> tests.
>>>>>>>>
>>>>>>>> We also care to give the handlers a pointer to the save registers in
>>>>>>>> case the handler needs it (fixup_pgm_int needs the old psw address).
>>>>>>> So you're still ignoring the FPRs...
>>>>>>> I disassembled a test and looked at all stds and it looks like printf
>>>>>>> and related functions use them. Wouldn't we overwrite test FPRs if
>>>>>>> printing in a handler?
>>>>>> If printf uses the FPRs in my opinion we should modify the compilation options for the library.
>>>>>>
>>>>>> What is the reason for printf and related functions to use floating point?
>>>>>>
>>>>> Register spilling. This can and will be done.
>>>>
>>>> Hum, can you please clarify?
>>>>
>>>> AFAIK register spilling is for a compiler, to use memory if it has not
>>>> enough registers.
>>> Not strictly memory. If the compiler needs more GPRS, it can save/restore GPRS to FPRS.
>>>
>>> Any function the compiler generates is free to use the FPRS..
>>>
>>>> So your answer is for the my first sentence, meaning yes register
>>>> spilling will be done
>>>> or
>>>> do you mean register spilling is the reason why the compiler use FPRs
>>>> and it must be done so?
>>> Confused by both options :D The compiler might generate code that uses the FPRS although no floating point instructions are in use. That's why we have to enable the AFP control and properly take care of FPRS being used.
>>>
>>>
>> The compiler has the -msoft-float switch to avoid using the floating point instructions and registers, so it is our decision.
> No, not registers AFAIK.


sorry, exact, it must be used in conjunction with -ffloat-store


>
>> Saving the FP registers on exceptions is not very efficient, we loose time on each interrupt, not sure that we win it back by using FPregs to as Regs backup.
> Who on earth cares about performance here?

I only care about simplicity and compiler optimizations are not my friends.


>> Usually a system at low level uses some enter_fpu, leave_fpu routine to enter critical sections using FPU instead of losing time on each interruptions.
>>
>> We can think about this, in between I do as you recomand and save the FPregs too.
>>
>> Best regards,
>>
>> Pierre
>>
>>
>> -- 
>> Pierre Morel
>> IBM Lab Boeblingen
>>
-- 
Pierre Morel
IBM Lab Boeblingen
