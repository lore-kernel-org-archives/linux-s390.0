Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732414AbhAUNei (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 08:34:38 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/3] s390x: define UV compatible I/O
 allocation
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-3-git-send-email-pmorel@linux.ibm.com>
 <6c232520-dbd1-80e4-e3a3-949964df7403@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <835c66a3-b25e-c4d3-7ae2-dc075091e5b4@linux.ibm.com>
Date: Thu, 21 Jan 2021 14:33:50 +0100
MIME-Version: 1.0
In-Reply-To: <6c232520-dbd1-80e4-e3a3-949964df7403@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 10:46 AM, Janosch Frank wrote:
> On 1/21/21 10:13 AM, Pierre Morel wrote:
>> To centralize the memory allocation for I/O we define
>> the alloc_io_page/free_io_page functions which share the I/O
>> memory with the host in case the guest runs with
>> protected virtualization.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   MAINTAINERS           |  1 +
>>   lib/s390x/malloc_io.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/malloc_io.h | 45 ++++++++++++++++++++++++++++
>>   s390x/Makefile        |  1 +
>>   4 files changed, 117 insertions(+)
>>   create mode 100644 lib/s390x/malloc_io.c
>>   create mode 100644 lib/s390x/malloc_io.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 54124f6..89cb01e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -82,6 +82,7 @@ M: Thomas Huth <thuth@redhat.com>
>>   M: David Hildenbrand <david@redhat.com>
>>   M: Janosch Frank <frankja@linux.ibm.com>
>>   R: Cornelia Huck <cohuck@redhat.com>
>> +R: Pierre Morel <pmorel@linux.ibm.com>
> 
> If you're ok with the amount of mails you'll get then go ahead.
> But I think maintainer file changes should always be in a separate patch.
> 
>>   L: kvm@vger.kernel.org
>>   L: linux-s390@vger.kernel.org
>>   F: s390x/*
>> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
>> new file mode 100644
>> index 0000000..bfe8c6a
>> --- /dev/null
>> +++ b/lib/s390x/malloc_io.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> I think we wanted to use:
> /* SPDX-License-Identifier: GPL-2.0-or-later */
> 
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
>> + * This is needed for I/O buffers.
>> + *
>> + */
>> +#include <libcflat.h>
>> +#include <asm/page.h>
>> +#include <asm/uv.h>
>> +#include <malloc_io.h>
>> +#include <alloc_page.h>
>> +#include <asm/facility.h>
>> +
>> +static int share_pages(void *p, int count)
>> +{
>> +	int i = 0;
>> +
>> +	for (i = 0; i < count; i++, p += PAGE_SIZE)
>> +		if (uv_set_shared((unsigned long)p))
>> +			return i;
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
>> +void *alloc_io_pages(int size, int flags)
>> +{
>> +	int order = (size >> PAGE_SHIFT);
>> +	void *p;
>> +	int n;
>> +
>> +	assert(size);
>> +
>> +	p = alloc_pages_flags(order, AREA_DMA31 | flags);
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
>> +void free_io_pages(void *p, int size)
>> +{
>> +	int order = size >> PAGE_SHIFT;
>> +
>> +	assert(IS_ALIGNED((uintptr_t)p, PAGE_SIZE));
>> +
>> +	if (test_facility(158))
>> +		unshare_pages(p, 1 << order);
> 
> I have a lib file in the making that will let you check UV features like
> test_facility(). When that's ready I'm gonna check for unshare here.

OK.
On share_pages the rc is enough I suppose.


-- 
Pierre Morel
IBM Lab Boeblingen
