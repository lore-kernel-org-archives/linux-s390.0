Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbgLQP0C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:26:02 -0500
Subject: Re: [kvm-unit-tests PATCH v3 3/8] s390x: SCLP feature checking
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-4-frankja@linux.ibm.com>
 <20201217131837.5946c853@ibm-vm>
 <14a2d6ab-7f9b-86cd-26ca-0c83385f62ca@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <646efe10-2f5b-a354-65a3-6358fd0dc6c6@redhat.com>
Date: Thu, 17 Dec 2020 16:24:24 +0100
MIME-Version: 1.0
In-Reply-To: <14a2d6ab-7f9b-86cd-26ca-0c83385f62ca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 17/12/2020 16.21, Janosch Frank wrote:
> On 12/17/20 1:18 PM, Claudio Imbrenda wrote:
>> On Fri, 11 Dec 2020 05:00:34 -0500
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> Availability of SIE is announced via a feature bit in a SCLP info CPU
>>> entry. Let's add a framework that allows us to easily check for such
>>> facilities.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  lib/s390x/io.c   |  1 +
>>>  lib/s390x/sclp.c | 19 +++++++++++++++++++
>>>  lib/s390x/sclp.h | 13 ++++++++++++-
>>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
>>> index 6a1da63..ef9f59e 100644
>>> --- a/lib/s390x/io.c
>>> +++ b/lib/s390x/io.c
>>> @@ -35,6 +35,7 @@ void setup(void)
>>>  	setup_args_progname(ipl_args);
>>>  	setup_facilities();
>>>  	sclp_read_info();
>>> +	sclp_facilities_setup();
>>>  	sclp_console_setup();
>>>  	sclp_memory_setup();
>>>  	smp_setup();
>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>> index bf1d9c0..cf6ea7c 100644
>>> --- a/lib/s390x/sclp.c
>>> +++ b/lib/s390x/sclp.c
>>> @@ -9,6 +9,7 @@
>>>   */
>>>  
>>>  #include <libcflat.h>
>>> +#include <bitops.h>
>>
>> you add this include, but it seems you are not actually using it?
> 
> Leftover from last version
> 
>>
>>>  #include <asm/page.h>
>>>  #include <asm/arch_def.h>
>>>  #include <asm/interrupt.h>
>>> @@ -25,6 +26,7 @@ static uint64_t max_ram_size;
>>>  static uint64_t ram_size;
>>>  char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));
>>>  static ReadInfo *read_info;
>>> +struct sclp_facilities sclp_facilities;
>>>  
>>>  char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>>>  static volatile bool sclp_busy;
>>> @@ -128,6 +130,23 @@ CPUEntry *sclp_get_cpu_entries(void)
>>>  	return (void *)read_info + read_info->offset_cpu;
>>>  }
>>>  
>>> +void sclp_facilities_setup(void)
>>> +{
>>> +	unsigned short cpu0_addr = stap();
>>> +	CPUEntry *cpu;
>>> +	int i;
>>> +
>>> +	assert(read_info);
>>> +
>>> +	cpu = (void *)read_info + read_info->offset_cpu;
>>
>> another void* arithmetic. consider using well-defined constructs, like
>>
>> cpu = (CPUEntry *)(_read_info + read_info->offset_cpu);
>>
>>> +	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
>>> +		if (cpu->address == cpu0_addr) {
>>> +			sclp_facilities.has_sief2 = cpu->feat_sief2;
>>> +			break;
>>
>> this only checks CPU 0. I wonder if you shouldn't check all CPUs? Or if
>> we assume that all CPUs have the same facilities, isn't it enough to
>> check the first CPU in the list? (i.e. avoid the loop)
> 
> This is the way.
> 
> Thomas already asked me that. I had a look what the kernel does and
> that's what they are doing. QEMU writes the same feature bits to all
> cpus and I haven't found an explanation for that code yet but I figured
> there might (have) be(en) one.

Well, if two people are asking, that's maybe a good indication that a
comment in the code would be a good idea? (even if it just references to the
kernel way of doing it?)

 Thomas
