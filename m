Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfKKNeO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 08:34:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABDXS5P053679
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 08:34:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w78fx8etd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 08:34:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 11 Nov 2019 13:34:10 -0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Use loop to save and restore fprs
References: <20191104085533.2892-1-frankja@linux.ibm.com>
 <5dfe4c62-5178-3e9c-b1bb-6814e020078e@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 11 Nov 2019 14:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <5dfe4c62-5178-3e9c-b1bb-6814e020078e@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <49b6daa6-f5fd-9ca6-7ffb-ec7c23c5cf92@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com


On 11/8/19 10:15 AM, Thomas Huth wrote:
> On 04/11/2019 09.55, Janosch Frank wrote:
>> Let's save some lines in the assembly by using a loop to save and
>> restore the fprs.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   s390x/cstart64.S | 38 ++++++--------------------------------
>>   1 file changed, 6 insertions(+), 32 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 5dc1577..8e2b21e 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -99,44 +99,18 @@ memsetxc:
>>       lctlg    %c0, %c0, 0(%r1)
>>       /* save fprs 0-15 + fpc */
>>       la    %r1, GEN_LC_SW_INT_FPRS
>> -    std    %f0, 0(%r1)
>> -    std    %f1, 8(%r1)
>> -    std    %f2, 16(%r1)
>> -    std    %f3, 24(%r1)
>> -    std    %f4, 32(%r1)
>> -    std    %f5, 40(%r1)
>> -    std    %f6, 48(%r1)
>> -    std    %f7, 56(%r1)
>> -    std    %f8, 64(%r1)
>> -    std    %f9, 72(%r1)
>> -    std    %f10, 80(%r1)
>> -    std    %f11, 88(%r1)
>> -    std    %f12, 96(%r1)
>> -    std    %f13, 104(%r1)
>> -    std    %f14, 112(%r1)
>> -    std    %f15, 120(%r1)
>> +    .irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>> +    std    \i, \i * 8(%r1)
>> +    .endr
>>       stfpc    GEN_LC_SW_INT_FPC
>>       .endm
>>         .macro RESTORE_REGS
>>       /* restore fprs 0-15 + fpc */
>>       la    %r1, GEN_LC_SW_INT_FPRS
>> -    ld    %f0, 0(%r1)
>> -    ld    %f1, 8(%r1)
>> -    ld    %f2, 16(%r1)
>> -    ld    %f3, 24(%r1)
>> -    ld    %f4, 32(%r1)
>> -    ld    %f5, 40(%r1)
>> -    ld    %f6, 48(%r1)
>> -    ld    %f7, 56(%r1)
>> -    ld    %f8, 64(%r1)
>> -    ld    %f9, 72(%r1)
>> -    ld    %f10, 80(%r1)
>> -    ld    %f11, 88(%r1)
>> -    ld    %f12, 96(%r1)
>> -    ld    %f13, 104(%r1)
>> -    ld    %f14, 112(%r1)
>> -    ld    %f15, 120(%r1)
>> +    .irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>> +    ld    \i, \i * 8(%r1)
>> +    .endr
>>       lfpc    GEN_LC_SW_INT_FPC
>>       /* restore cr0 */
>>       lctlg    %c0, %c0, GEN_LC_SW_INT_CR0
>>
>
> Produces exactly the same code as before.
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
Good for me, makes the code smaller ... is better

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>



-- 
Pierre Morel
IBM Lab Boeblingen
