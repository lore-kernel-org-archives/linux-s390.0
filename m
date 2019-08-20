Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHTMza (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 08:55:30 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-3-frankja@linux.ibm.com>
 <6f25a51e-136e-1afb-215d-a2639fbd5510@redhat.com>
 <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
Date: Tue, 20 Aug 2019 14:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/20/19 2:25 PM, Janosch Frank wrote:
> On 8/20/19 1:59 PM, Thomas Huth wrote:
>> On 8/20/19 12:55 PM, Janosch Frank wrote:
>>> A small test for the watchdog via diag288.
>>>
>>> Minimum timer value is 15 (seconds) and the only supported action with
>>> QEMU is restart.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  s390x/Makefile      |   1 +
>>>  s390x/diag288.c     | 111 ++++++++++++++++++++++++++++++++++++++++++++
>>>  s390x/unittests.cfg |   4 ++
>>>  3 files changed, 116 insertions(+)
>>>  create mode 100644 s390x/diag288.c
>>>
>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>> index 1f21ddb..b654c56 100644
>>> --- a/s390x/Makefile
>>> +++ b/s390x/Makefile
>>> @@ -11,6 +11,7 @@ tests += $(TEST_DIR)/cmm.elf
>>>  tests += $(TEST_DIR)/vector.elf
>>>  tests += $(TEST_DIR)/gs.elf
>>>  tests += $(TEST_DIR)/iep.elf
>>> +tests += $(TEST_DIR)/diag288.elf
>>>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>>  
>>>  all: directories test_cases test_cases_binary
>>> diff --git a/s390x/diag288.c b/s390x/diag288.c
>>> new file mode 100644
>>> index 0000000..5abcec4
>>> --- /dev/null
>>> +++ b/s390x/diag288.c
>>> @@ -0,0 +1,111 @@
>>> +/*
>>> + * Timer Event DIAG288 test
>>> + *
>>> + * Copyright (c) 2019 IBM Corp
>>> + *
>>> + * Authors:
>>> + *  Janosch Frank <frankja@linux.ibm.com>
>>> + *
>>> + * This code is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU Library General Public License version 2.
>>> + */
>>> +
>>> +#include <libcflat.h>
>>> +#include <asm/asm-offsets.h>
>>> +#include <asm/interrupt.h>
>>> +
>>> +struct lowcore *lc = (void *)0x0;
>>
>> Maybe use "NULL" instead of "(void *)0x0" ?
> 
> Well I'd rather have:
> struct lowcore *lc = (struct lowcore *)0x0;

Fine for me, too.

>> ... maybe we could also introduce such a variable as a global variable
>> in lib/s390x/ since this is already the third or fourth time that we use
>> it in the kvm-unit-tests...
> 
> Sure I also thought about that, any particular place?

No clue. Maybe lib/s390x/mmu.c ? Or a new file called lowcore.c ?

>>> +static inline void diag288_uneven(void)
>>> +{
>>> +	register unsigned long fc asm("1") = 0;
>>> +	register unsigned long time asm("1") = 15;
>>
>> So you're setting register 1 twice? And "time" is not really used in the
>> inline assembly below? How's that supposed to work? Looks like a bug to
>> me... if not, please explain with a comment in the code here.
> 
> Well I'm waiting for a spec exception here, so it doesn't have to work.> I'll probably just remove the register variables and do a:
> 
> "diag %r1,%r2,0x288"

Yes, I think that's easier to understand.

BTW, is there another documentation of diag 288 beside the "CP
programming services" manual? At least my version of that specification
does not say that the fc register has to be even...

>>> +static void test_bite(void)
>>> +{
>>> +	if (lc->restart_old_psw.addr) {
>>> +		report("restart", true);
>>> +		return;
>>> +	}
>>> +	lc->restart_new_psw.addr = (uint64_t)test_bite;
>>> +	diag288(CODE_INIT, 15, ACTION_RESTART);
>>> +	while(1) {};
>>
>> Should this maybe timeout after a minute or so?
> 
> Well run_tests.sh does timeout externally.
> Do you need it backed into the test?

I sometimes also run the tests without the wrapper script, so in that
case it would be convenient ... but I can also quit QEMU manually in
that case, so it's not a big issue.

 Thomas
