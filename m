Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52728 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbhAVH4g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 02:56:36 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/3] s390x: define UV compatible I/O
 allocation
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-3-git-send-email-pmorel@linux.ibm.com>
 <a50c9d35-4a67-4adc-4647-98df14300ada@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ff1f7e69-6962-5d1d-d7be-51089c735993@linux.ibm.com>
Date: Fri, 22 Jan 2021 08:55:48 +0100
MIME-Version: 1.0
In-Reply-To: <a50c9d35-4a67-4adc-4647-98df14300ada@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 10:32 AM, Thomas Huth wrote:

...snip...

>> +#include <asm/facility.h>
>> +
>> +static int share_pages(void *p, int count)
>> +{
>> +    int i = 0;
>> +
>> +    for (i = 0; i < count; i++, p += PAGE_SIZE)
>> +        if (uv_set_shared((unsigned long)p))
>> +            return i;
> 
> Just a matter of taste, but you could replace the "return i" here also 
> with a "break" since you're returning i below anyway.

right a single out point is always better.

> 
>> +    return i;
>> +}
>> +
>> +static void unshare_pages(void *p, int count)
>> +{
>> +    int i;
>> +
>> +    for (i = count; i > 0; i--, p += PAGE_SIZE)
>> +        uv_remove_shared((unsigned long)p);
>> +}
>> +
>> +void *alloc_io_pages(int size, int flags)
> 
> I still think the naming or size parameter is confusing here. If I read 
> something like alloc_io_pages(), I'd expect a "num_pages" parameter. So 
> if you want to keep the "size" in bytes, I'd suggest to rename the 
> function to "alloc_io_mem" instead.

OK, I rename the function, allowing the user to keep a simple interface
without having to calculate the page order.

> 
>> +{
>> +    int order = (size >> PAGE_SHIFT);
> 
> I think this is wrong. According to the description of alloc_pages_flag, 
> it allocates "1ull << order" pages.
> So you likely want to do this instead here:
> 
>          int order = get_order(size >> PAGE_SHIFT);

you are absolutely right.

> 
>> +    void *p;
>> +    int n;
>> +
>> +    assert(size);
>> +
>> +    p = alloc_pages_flags(order, AREA_DMA31 | flags);
>> +    if (!p || !test_facility(158))
>> +        return p;
>> +
>> +    n = share_pages(p, 1 << order);
>> +    if (n == 1 << order)
>> +        return p;
>> +
>> +    unshare_pages(p, n);
>> +    free_pages(p);
>> +    return NULL;
>> +}
>> +
>> +void free_io_pages(void *p, int size)
>> +{
>> +    int order = size >> PAGE_SHIFT;
> 
> dito?

yes :(

> 
>> +    assert(IS_ALIGNED((uintptr_t)p, PAGE_SIZE));
>> +
>> +    if (test_facility(158))
>> +        unshare_pages(p, 1 << order);
>> +    free_pages(p);
>> +}
>> diff --git a/lib/s390x/malloc_io.h b/lib/s390x/malloc_io.h
>> new file mode 100644
>> index 0000000..494dfe9
>> --- /dev/null
>> +++ b/lib/s390x/malloc_io.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> GPL-2.0-only please.

almmost... I use:
/* SPDX-License-Identifier: GPL-2.0-or-later */

as in other files updated by janosch if this is not a problem.

> 
>> +/*
>> + * I/O allocations
>> + *
>> + * Copyright (c) 2021 IBM Corp
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + */
>> +#ifndef _S390X_MALLOC_IO_H_
>> +#define _S390X_MALLOC_IO_H_
>> +
>> +/*
>> + * Allocates a page aligned page bound range of contiguous real or
>> + * absolute memory in the DMA31 region large enough to contain size
>> + * bytes.
>> + * If Protected Virtualization facility is present, shares the pages
>> + * with the host.
>> + * If all the pages for the specified size cannot be reserved,
>> + * the function rewinds the partial allocation and a NULL pointer
>> + * is returned.
>> + *
>> + * @size: the minimal size allocated in byte.
>> + * @flags: the flags used for the underlying page allocator.
>> + *
>> + * Errors:
>> + *   The allocation will assert the size parameter, will fail if the
>> + *   underlying page allocator fail or in the case of protected
>> + *   virtualisation if the sharing of the pages fails.
> 
> I think "virtualization" (with an z) is more common than "virtualisation".

OK


Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
