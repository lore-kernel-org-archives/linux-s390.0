Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbhAVPja (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 10:39:30 -0500
Subject: Re: [kvm-unit-tests PATCH v5 2/3] s390x: define UV compatible I/O
 allocation
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <1611322060-1972-3-git-send-email-pmorel@linux.ibm.com>
 <fcb7e165-d1a6-9d0b-a8e8-e91f39e2e0f7@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a692e401-874a-5d20-7f78-d0024ca57583@linux.ibm.com>
Date: Fri, 22 Jan 2021 16:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <fcb7e165-d1a6-9d0b-a8e8-e91f39e2e0f7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/22/21 2:57 PM, Janosch Frank wrote:
> On 1/22/21 2:27 PM, Pierre Morel wrote:
>> To centralize the memory allocation for I/O we define
>> the alloc_io_mem/free_io_mem functions which share the I/O
>> memory with the host in case the guest runs with
>> protected virtualization.
>>
>> These functions allocate on a page integral granularity to
>> ensure a dedicated sharing of the allocated objects.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Acked-by: Janosch Frank <frankja@de.ibm.com>
> 
>> ---
>>   lib/s390x/malloc_io.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/malloc_io.h | 45 +++++++++++++++++++++++++++
>>   s390x/Makefile        |  1 +
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 lib/s390x/malloc_io.c
>>   create mode 100644 lib/s390x/malloc_io.h
>>
>> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
>> new file mode 100644
>> index 0000000..b01222e
>> --- /dev/null
>> +++ b/lib/s390x/malloc_io.c
>> @@ -0,0 +1,71 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * I/O page allocation
>> + *
>> + * Copyright (c) 2021 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * Using this interface provide host access to the allocated pages in
>> + * case the guest is a secure guest.
> 
> s/secure/protected/

OK

> 
>> + * This is needed for I/O buffers.
>> + *
>> + */
>> +#include <libcflat.h>
>> +#include <asm/page.h>
>> +#include <asm/uv.h>
>> +#include <malloc_io.h>
>> +#include <alloc_page.h>
>> +#include <asm/facility.h>
>> +#include <bitops.h>
>> +
>> +static int share_pages(void *p, int count)
>> +{
>> +	int i = 0;
>> +
>> +	for (i = 0; i < count; i++, p += PAGE_SIZE)
>> +		if (uv_set_shared((unsigned long)p))
>> +			break;
>> +	return i;
>> +}
>> +
>> +static void unshare_pages(void *p, int count)
>> +{
>> +	int i;
>> +
>> +	for (i = count; i > 0; i--, p += PAGE_SIZE)
>> +		uv_remove_shared((unsigned long)p);
>> +}
>> +
>> +void *alloc_io_mem(int size, int flags)
>> +{
>> +	int order = get_order(size >> PAGE_SHIFT);
>> +	void *p;
>> +	int n;
>> +
>> +	assert(size);
>> +
>> +	p = alloc_pages_flags(order, AREA_DMA31 | flags);
> 
> Pardon my lack of IO knowledge but do we also need to restrict the data
> to below 2g or only the IO control structures?
> 
> Not that it currently matters much for a unit test with 256mb of memory...

it depends, if you know how work most scatter-gather it is easy:

INSTR-> ORB -> CCW -> DATA

first level metadata: yes
- Intruction point with 31bit to ORB
- ORB point with 31b to CCW
- CCW point with 31b to data

first level of data, the one pointed by the CCW: yes

This is all what is used in this patch.

To be developed in the future:

INSTR-> ORB -> CCW -> [M]IDA -> DATA

second level metadata:
they are pointed to by CCW...
- IDA : yes
- MIDA: yes

second level data (indirect buffering)
- IDA format 1: 31b address: yes
- IDA format 2: 64b address: no
- MIDA        : 64b address: no

Or to sum up only data accessed with indirect addressing by IDA format 2 
and MIDA can be anywhere.

> 
>> +	if (!p || !test_facility(158))
>> +		return p;
>> +
>> +	n = share_pages(p, 1 << order);
>> +	if (n == 1 << order)
>> +		return p;
>> +
>> +	unshare_pages(p, n);
>> +	free_pages(p);
>> +	return NULL;
>> +}
>> +
>> +void free_io_mem(void *p, int size)
>> +{
>> +	int order = get_order(size >> PAGE_SHIFT);
>> +
>> +	assert(IS_ALIGNED((uintptr_t)p, PAGE_SIZE));
>> +
>> +	if (test_facility(158))
>> +		unshare_pages(p, 1 << order);
>> +	free_pages(p);
>> +}
>> diff --git a/lib/s390x/malloc_io.h b/lib/s390x/malloc_io.h
>> new file mode 100644
>> index 0000000..cc5fad7
>> --- /dev/null
>> +++ b/lib/s390x/malloc_io.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * I/O allocations
>> + *
>> + * Copyright (c) 2021 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + */
>> +#ifndef _S390X_MALLOC_IO_H_
>> +#define _S390X_MALLOC_IO_H_
>> +
>> +/*
>> + * Allocates a page aligned page bound range of contiguous real or
>> + * absolute memory in the DMA31 region large enough to contain size
>> + * bytes.
>> + * If Protected Virtualisation facility is present, shares the pages
> 
> s/Virtualisation/Virtualization/
> 
> But I can fix this and the nitpick above up when picking.

:) Thomas made me change this in the last round.

As far as I know "z" is used in the uS ans "s" in England (and France).

regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
