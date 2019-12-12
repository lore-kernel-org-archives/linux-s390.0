Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60730 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729395AbfLLNeW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 08:34:22 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCDXF9x148566
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:34:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf70hum8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:34:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 13:32:19 -0000
Subject: Re: [kvm-unit-tests PATCH v4 1/9] s390x: saving regs for interrupts
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-2-git-send-email-pmorel@linux.ibm.com>
 <19f572f1-5855-154a-af2b-1273d485be51@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 12 Dec 2019 14:32:15 +0100
MIME-Version: 1.0
In-Reply-To: <19f572f1-5855-154a-af2b-1273d485be51@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <eada4a92-afab-c6fa-a125-fdcc254643dd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2019-12-12 10:24, Janosch Frank wrote:
> On 12/11/19 4:46 PM, Pierre Morel wrote:
>> If we use multiple source of interrupts, for exemple, using SCLP
> 
> s/exemple/example/

OK, thanks

> 
>> console to print information while using I/O interrupts, we need
>> to have a re-entrant register saving interruption handling.
>>
>> Instead of saving at a static memory address, let's save the base
>> registers and the floating point registers on the stack.
>>
>> Note that we keep the static register saving to recover from the
>> RESET tests.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   s390x/cstart64.S | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 86dd4c4..ff05f9b 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -118,6 +118,25 @@ memsetxc:
>>   	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>>   	.endm
>>> +	.macro SAVE_IRQ_REGS
> 
> Maybe add comments to the start of the macros like:
> "Save registers on the stack, so we can have stacked interrupts."

OK.

> 
>> +	slgfi   %r15, 15 * 8
>> +	stmg    %r0, %r14, 0(%r15)
>> +	slgfi   %r15, 16 * 8
>> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>> +	std	\i, \i * 8(%r15)
>> +	.endr
>> +	lgr     %r2, %r15
> 
> What's that doing?

Passing a parameter to the saved registers to the handler.
makes me think that since I reworked the interrupt handler to add 
registration the parameter disappeared...

I will remove this line and come back with a new series at the time we 
need to access the registers.

> 
>> +	.endm
>> +
>> +	.macro RESTORE_IRQ_REGS
>> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>> +	ld	\i, \i * 8(%r15)
>> +	.endr
>> +	algfi   %r15, 16 * 8
>> +	lmg     %r0, %r14, 0(%r15)
>> +	algfi   %r15, 15 * 8
>> +	.endm
>> +
>>   .section .text
>>   /*
>>    * load_reset calling convention:
>> @@ -154,6 +173,8 @@ diag308_load_reset:
>>   	lpswe	GEN_LC_SW_INT_PSW
>>   1:	br	%r14
>>   
>> +
>> +
> 
> Still not fixed

sorry I did not see this

Thanks for review,
Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
