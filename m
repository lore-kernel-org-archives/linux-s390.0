Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgFIPBJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 11:01:09 -0400
Subject: Re: [kvm-unit-tests PATCH v8 09/12] s390x: Library resources for CSS
 tests
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-10-git-send-email-pmorel@linux.ibm.com>
 <ef5e71b6-9c4d-ac3f-7946-f67db73d740b@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <17e5ccdd-f2b2-00bd-4ee2-c0a0b78a669a@linux.ibm.com>
Date: Tue, 9 Jun 2020 17:01:01 +0200
MIME-Version: 1.0
In-Reply-To: <ef5e71b6-9c4d-ac3f-7946-f67db73d740b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-09 09:09, Thomas Huth wrote:
> On 08/06/2020 10.12, Pierre Morel wrote:
>> Provide some definitions and library routines that can be used by

...snip...

>> +static inline int ssch(unsigned long schid, struct orb *addr)
>> +{
>> +	register long long reg1 asm("1") = schid;
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"	ssch	0(%2)\n"
>> +		"	ipm	%0\n"
>> +		"	srl	%0,28\n"
>> +		: "=d" (cc)
>> +		: "d" (reg1), "a" (addr), "m" (*addr)
> 
> Hmm... What's the "m" (*addr) here good for? %3 is not used in the
> assembly code?

addr is %2
"m" (*addr) means memory pointed by addr is read

> 
>> +		: "cc", "memory");
> 
> Why "memory" ? Can this instruction also change the orb?

The orb not but this instruction modifies memory as follow:
orb -> ccw -> data

The CCW can be a READ or a WRITE instruction and the data my be anywhere 
in memory (<2G)

A compiler memory barrier is need to avoid write instructions started 
before the SSCH instruction to occur after for a write
and memory read made after the instruction to be executed before for a read.


> 
>> +	return cc;
>> +}
>> +
>> +static inline int stsch(unsigned long schid, struct schib *addr)
>> +{
>> +	register unsigned long reg1 asm ("1") = schid;
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"	stsch	0(%3)\n"
>> +		"	ipm	%0\n"
>> +		"	srl	%0,28"
>> +		: "=d" (cc), "=m" (*addr)
>> +		: "d" (reg1), "a" (addr)
>> +		: "cc");
> 
> I'm surprised that this does not use "memory" in the clobber list ... I
> guess that's what the "=m" (*addr) is good for?

Yes the "=m" (*addr) is there to specify that the SCHIB pointed to by 
addr will be modified.


> 
>> +	return cc;
>> +}
>> +
>> +static inline int msch(unsigned long schid, struct schib *addr)
>> +{
>> +	register unsigned long reg1 asm ("1") = schid;
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"	msch	0(%3)\n"
>> +		"	ipm	%0\n"
>> +		"	srl	%0,28"
>> +		: "=d" (cc), "=m" (*addr)
>> +		: "d" (reg1), "a" (addr)
> 
> I'm not an expert with these IO instructions, but this looks wrong to me
> ... Is MSCH reading or writing the SCHIB data?

MSCH is reading the SCHIB data in memory.


> 

...snip...

>> +/* Debug functions */
>> +char *dump_pmcw_flags(uint16_t f);
>> +char *dump_scsw_flags(uint32_t f);
>> +
>> +void dump_scsw(struct scsw *);
>> +void dump_irb(struct irb *irbp);
>> +void dump_schib(struct schib *sch);
>> +struct ccw1 *dump_ccw(struct ccw1 *cp);
>> +void dump_irb(struct irb *irbp);
>> +void dump_pmcw(struct pmcw *p);
>> +void dump_orb(struct orb *op);
> 
> In the patch description, you said that DEBUG_CSS needs to be defined
> for these - but now DEBUG_CSS is not used in this header... does the
> patch description need to be changed?

Yes, thanks, will do.
I removed it because it seems not useful to me.

> 
>> +int css_enumerate(void);
>> +#define MAX_ENABLE_RETRIES      5
>> +int css_enable(int schid);
>> +
>> +#endif
>> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
>> new file mode 100644
>> index 0000000..0c2b64e
>> --- /dev/null
>> +++ b/lib/s390x/css_dump.c
>> @@ -0,0 +1,153 @@
>> +/*
>> + * Channel subsystem structures dumping
>> + *
>> + * Copyright (c) 2020 IBM Corp.
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2.
> 
> In the header you used "or any later version" - here it's version 2
> only. Maybe you want to standardize one one of the two flavors?

Yes, I will choose the shortest one, v2 only, as it seems to be the most 
used in kvm-unit-test.

Thanks for the review.
Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
