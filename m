Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbgGPL1n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 07:27:43 -0400
Subject: Re: [kvm-unit-tests PATCH v13 6/9] s390x: Library resources for CSS
 tests
References: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
 <1594887809-10521-7-git-send-email-pmorel@linux.ibm.com>
 <9d6f0445-9c13-c23b-6095-0699ad09be87@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <196f3522-1880-c178-6ddd-56dd2d0b5256@linux.ibm.com>
Date: Thu, 16 Jul 2020 13:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <9d6f0445-9c13-c23b-6095-0699ad09be87@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com



On 2020-07-16 13:15, Janosch Frank wrote:
> On 7/16/20 10:23 AM, Pierre Morel wrote:
>> Provide some definitions and library routines that can be used by
>> tests targeting the channel subsystem.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Janosch Frank <frankja@de.ibm.com>
>> ---
> [...]
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index ddb4b48..050c40b 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -51,6 +51,7 @@ cflatobjs += lib/s390x/sclp-console.o
>>   cflatobjs += lib/s390x/interrupt.o
>>   cflatobjs += lib/s390x/mmu.o
>>   cflatobjs += lib/s390x/smp.o
>> +cflatobjs += lib/s390x/css_dump.o
>>   
>>   OBJDIRS += lib/s390x
>>   
> 
> I need to fix this up when picking because Thomas added vm.o after smp.o.
> Can I do that or do you want to rebase on my next branch?
> 
> 

I can do it and respin, that will give me the occasion to suppress the 
goto as demanded by Thomas.

Is it OK?


-- 
Pierre Morel
IBM Lab Boeblingen
