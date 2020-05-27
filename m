Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390576AbgE0Pyc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 11:54:32 -0400
Subject: Re: [kvm-unit-tests PATCH v7 04/12] s390x: interrupt registration
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-5-git-send-email-pmorel@linux.ibm.com>
 <dcfa518e-ce93-fb71-3e70-b95c12b0b32e@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <6ebf59e6-4fd1-a85c-d0aa-cd64382f9a10@linux.ibm.com>
Date: Wed, 27 May 2020 17:54:26 +0200
MIME-Version: 1.0
In-Reply-To: <dcfa518e-ce93-fb71-3e70-b95c12b0b32e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-05-26 20:08, Thomas Huth wrote:
> On 18/05/2020 18.07, Pierre Morel wrote:
>> Let's make it possible to add and remove a custom io interrupt handler,
>> that can be used instead of the normal one.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>>   lib/s390x/interrupt.h |  8 ++++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/s390x/interrupt.h
> ...
>> diff --git a/lib/s390x/interrupt.h b/lib/s390x/interrupt.h
>> new file mode 100644
>> index 0000000..323258d
>> --- /dev/null
>> +++ b/lib/s390x/interrupt.h
>> @@ -0,0 +1,8 @@
>> +#ifndef __INTERRUPT_H
>> +#define __INTERRUPT_H
> 
> Looking at this patch again, I noticed another nit: No double
> underscores at the beginning of header guards, please! That's reserved
> namespace. Simply use INTERRUPT_H or S390X_INTERRUPT_H or something
> similar instead.
> 
>   Thanks,
>    Thomas
> 

OK, thanks
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
