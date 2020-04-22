Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgDVJKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 05:10:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M94GRl137908
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:10:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gfech6ue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:10:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Apr 2020 10:09:13 +0100
Subject: Re: [kvm-unit-tests PATCH v5 01/10] s390x: saving regs for interrupts
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-2-git-send-email-pmorel@linux.ibm.com>
 <8c999975-bd94-67f1-98cc-3821f02a99c2@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 22 Apr 2020 11:09:56 +0200
MIME-Version: 1.0
In-Reply-To: <8c999975-bd94-67f1-98cc-3821f02a99c2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e3727413-5f73-636d-ba68-2665e639b42c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-22 09:47, Janosch Frank wrote:
> On 2/20/20 1:00 PM, Pierre Morel wrote:
>> If we use multiple source of interrupts, for example, using SCLP
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
>>   s390x/cstart64.S | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 9af6bb3..45da523 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -118,6 +118,25 @@ memsetxc:
>>   	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>>   	.endm
>>   
>> +/* Save registers on the stack, so we can have stacked interrupts. */
>> +	.macro SAVE_IRQ_REGS
>> +	slgfi   %r15, 15 * 8
>> +	stmg    %r0, %r14, 0(%r15)
> 
> So this is just making some space on the stack and storing r0 - r14, right?
> 
> Same is done for the floating point registers below.
> 
> Could you add a comment above slgfi and stmg and explain what they do?
> A few words are enough.
OK, thanks

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
