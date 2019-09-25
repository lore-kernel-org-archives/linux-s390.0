Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406687AbfIYNjQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 09:39:16 -0400
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
From: David Hildenbrand <david@redhat.com>
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
 <b8b574a0-aa5d-7a10-ccd3-d901bf2e0655@redhat.com>
 <df219ca6-b772-cfcb-2c9b-e53fe5b2c8b8@redhat.com>
 <4afbfdca-e028-4bb8-0ed0-41f907e9acf3@redhat.com>
 <292dc9d3-c45c-8eb5-4f79-05572b84060d@redhat.com>
Message-ID: <25379a1e-5533-6d8c-9760-af239209db0a@redhat.com>
Date: Wed, 25 Sep 2019 15:39:14 +0200
MIME-Version: 1.0
In-Reply-To: <292dc9d3-c45c-8eb5-4f79-05572b84060d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

On 25.09.19 15:35, David Hildenbrand wrote:
> On 25.09.19 15:32, David Hildenbrand wrote:
>> On 25.09.19 15:30, Thomas Huth wrote:
>>> On 25/09/2019 15.27, David Hildenbrand wrote:
>>>> On 20.09.19 10:03, Janosch Frank wrote:
>>>>> Testing SIGP emulation for the following order codes:
>>>>> * start
>>>>> * stop
>>>>> * restart
>>>>> * set prefix
>>>>> * store status
>>>>> * stop and store status
>>>>> * reset
>>>>> * initial reset
>>>>> * external call
>>>>> * emegergency call
>>>>>
>>>>> restart and set prefix are part of the library and needed to start
>>>>> other cpus.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  s390x/Makefile      |   1 +
>>>>>  s390x/smp.c         | 242 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>  s390x/unittests.cfg |   4 +
>>>>>  3 files changed, 247 insertions(+)
>>>>>  create mode 100644 s390x/smp.c
>>>>>
>>>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>>>> index d83dd0b..3744372 100644
>>>>> --- a/s390x/Makefile
>>>>> +++ b/s390x/Makefile
>>>>> @@ -15,6 +15,7 @@ tests += $(TEST_DIR)/cpumodel.elf
>>>>>  tests += $(TEST_DIR)/diag288.elf
>>>>>  tests += $(TEST_DIR)/stsi.elf
>>>>>  tests += $(TEST_DIR)/skrf.elf
>>>>> +tests += $(TEST_DIR)/smp.elf
>>>>>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>>>>  
>>>>>  all: directories test_cases test_cases_binary
>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>> new file mode 100644
>>>>> index 0000000..7032494
>>>>> --- /dev/null
>>>>> +++ b/s390x/smp.c
>>>>> @@ -0,0 +1,242 @@
>>>>> +/*
>>>>> + * Tests sigp emulation
>>>>> + *
>>>>> + * Copyright 2019 IBM Corp.
>>>>> + *
>>>>> + * Authors:
>>>>> + *    Janosch Frank <frankja@linux.ibm.com>
>>>>> + *
>>>>> + * This code is free software; you can redistribute it and/or modify it
>>>>> + * under the terms of the GNU General Public License version 2.
>>>>> + */
>>>>> +#include <libcflat.h>
>>>>> +#include <asm/asm-offsets.h>
>>>>> +#include <asm/interrupt.h>
>>>>> +#include <asm/page.h>
>>>>> +#include <asm/facility.h>
>>>>> +#include <asm-generic/barrier.h>
>>>>> +#include <asm/sigp.h>
>>>>> +
>>>>> +#include <smp.h>
>>>>> +#include <alloc_page.h>
>>>>> +
>>>>> +static int testflag = 0;
>>>>> +
>>>>> +static void cpu_loop(void)
>>>>> +{
>>>>> +	for (;;) {}
>>>>
>>>> Won't that be optimized out completely?
>>>
>>> Why? AFAIK this is the standard way to write and endless loop ... how
>>> can a compiler optimize that away?
>>
>> Was messing it up with "just" an empty loop body, I think you're right.
>>
> 
> However
> 
> https://stackoverflow.com/questions/2178115/are-compilers-allowed-to-eliminate-infinite-loops
> 
> "This is intended to allow compiler transformations such as removal of
> empty loops even when termination cannot be proven."
> 
> I think this might get optimized out.
> 

... but then, everybody does it, so it is most probably fine with GCC.

-- 

Thanks,

David / dhildenb
