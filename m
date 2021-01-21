Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAUJI0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:08:26 -0500
Subject: Re: [kvm-unit-tests PATCH v3 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
 <1611085944-21609-4-git-send-email-pmorel@linux.ibm.com>
 <b4656e81-1492-d902-73cf-5a08a0a6247d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <b08a9fa2-6b08-d616-ba3d-a04140490f75@linux.ibm.com>
Date: Thu, 21 Jan 2021 10:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <b4656e81-1492-d902-73cf-5a08a0a6247d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/20/21 1:03 PM, Thomas Huth wrote:
> On 19/01/2021 20.52, Pierre Morel wrote:
>> We want the tests to automatically work with or without protected
>> virtualisation.
>> To do this we need to share the I/O memory with the host.
>>
>> Let's replace all static allocations with dynamic allocations
>> to clearly separate shared and private memory.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> [...]
>> diff --git a/s390x/css.c b/s390x/css.c
>> index ee3bc83..4b0b6b1 100644
>> --- a/s390x/css.c
>> +++ b/s390x/css.c
>> @@ -17,13 +17,15 @@
>>   #include <interrupt.h>
>>   #include <asm/arch_def.h>
>> +#include <malloc_io.h>
>>   #include <css.h>
>> +#include <asm/barrier.h>
>>   #define DEFAULT_CU_TYPE        0x3832 /* virtio-ccw */
>>   static unsigned long cu_type = DEFAULT_CU_TYPE;
>>   static int test_device_sid;
>> -static struct senseid senseid;
>> +static struct senseid *senseid;
>>   static void test_enumerate(void)
>>   {
>> @@ -57,6 +59,7 @@ static void test_enable(void)
>>    */
>>   static void test_sense(void)
>>   {
>> +    struct ccw1 *ccw;
>>       int ret;
>>       int len;
>> @@ -80,9 +83,15 @@ static void test_sense(void)
>>       lowcore_ptr->io_int_param = 0;
>> -    memset(&senseid, 0, sizeof(senseid));
>> -    ret = start_single_ccw(test_device_sid, CCW_CMD_SENSE_ID,
>> -                   &senseid, sizeof(senseid), CCW_F_SLI);
>> +    senseid = alloc_io_page(sizeof(*senseid));
> 
> Would it make sense to move the above alloc_io_page into the ccw_alloc() 
> function, too?

If the goal is to have all allocations inside the ccw_alloc(),
I don't think so, we may have an already allocated buffer for which we 
want to pass the address without any allocation inside ccw_alloc() to 
reuse the same buffer.


> 
>> +    if (!senseid)
>> +        goto error_senseid;
>> +
>> +    ccw = ccw_alloc(CCW_CMD_SENSE_ID, senseid, sizeof(*senseid), 
>> CCW_F_SLI);
>> +    if (!ccw)
>> +        goto error_ccw;
>> +
>> +    ret = start_ccw1_chain(test_device_sid, ccw);
>>       if (ret)
>>           goto error;
> 
> I think you should add a "report(0, ...)" or report_abort() in front of 
> all three gotos above - otherwise the problems might go unnoticed.

Yes, right, I will do this,
Thanks.

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
