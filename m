Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbgGCJGA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 05:06:00 -0400
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
 <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
 <d8b2ed8c-3948-1cba-47af-ef2a8cdf27ed@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <0aaab65b-7856-9be9-c6dc-4da8e8d529d4@linux.ibm.com>
Date: Fri, 3 Jul 2020 11:05:53 +0200
MIME-Version: 1.0
In-Reply-To: <d8b2ed8c-3948-1cba-47af-ef2a8cdf27ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, drjones@redhat.com



On 2020-07-03 10:41, Thomas Huth wrote:
> On 02/07/2020 18.31, Pierre Morel wrote:
>> After a channel is enabled we start a SENSE_ID command using
>> the SSCH instruction to recognize the control unit and device.
>>
>> This tests the success of SSCH, the I/O interruption and the TSCH
>> instructions.
>>
>> The SENSE_ID command response is tested to report 0xff inside
>> its reserved field and to report the same control unit type
>> as the cu_type kernel argument.
>>
>> Without the cu_type kernel argument, the test expects a device
>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> [...]
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> index 0ddceb1..9c22644 100644
>> --- a/lib/s390x/css.h
>> +++ b/lib/s390x/css.h
>> @@ -11,6 +11,8 @@
>>   #ifndef CSS_H
>>   #define CSS_H
>>   
>> +#define lowcore_ptr ((struct lowcore *)0x0)
> 
> I'd prefer if you could either put this into the css_lib.c file or in
> lib/s390x/asm/arch_def.h.

I have a patch ready for this :)
But I did not want to add too much new things in this series that could 
start a new discussion.

I have 2 versions of the patch:
- The simple one with just the declaration in arch_def.h
- The complete one with update of all tests (but smp) using a pointer to 
lowcore.


> 
...snip...

>>   static inline int ssch(unsigned long schid, struct orb *addr)
>> @@ -251,6 +271,16 @@ void dump_orb(struct orb *op);
>>   
>>   int css_enumerate(void);
>>   #define MAX_ENABLE_RETRIES      5
>> -int css_enable(int schid);
>> +int css_enable(int schid, int isc);
>> +
>> +
> 
> In case you respin: Remove one empty line?

yes

> 
>> +/* Library functions */
>> +int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw);

...snip...

>> +	lowcore_ptr->io_int_param = 0;
>> +
>> +	memset(&senseid, 0, sizeof(senseid));
>> +	ret = start_single_ccw(test_device_sid, CCW_CMD_SENSE_ID,
>> +			       &senseid, sizeof(senseid), CCW_F_SLI);
>> +	if (ret) {
>> +		report(0, "ssch failed for SENSE ID on sch %08x with cc %d",
>> +		       test_device_sid, ret);
>> +		goto unreg_cb;
>> +	}
> 
> I'd maybe rather do something like:
> 
> 	report(ret == 0, "SENSE ID on sch %08x has good CC (%d)", ...)
> 	if (ret)
> 		goto unreg_cb;
> 
> and avoid report(0, ...) statements. Also for the other tests below. But
> maybe that's really just a matter of taste.

I prefer to use report(0,....) when an unexpected error occurs: This 
keep the test silent when what is expected occurs.

And use report(ret == xxx, ....) as the last report to report overall 
success or failure of the test.

Other opinions?

> 
>> +	wait_for_interrupt(PSW_MASK_IO);

...snip...

> 
> Apart from the nits, I'm fine with the patch.
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
