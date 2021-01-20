Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728260AbhATM1e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 07:27:34 -0500
Date: Wed, 20 Jan 2021 13:25:39 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/3] s390x: define UV compatible I/O
 allocation
Message-ID: <20210120132539.236dd224@ibm-vm>
In-Reply-To: <1611085944-21609-3-git-send-email-pmorel@linux.ibm.com>
References: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
        <1611085944-21609-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com, pbonzini@redhat.com

On Tue, 19 Jan 2021 20:52:23 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To centralize the memory allocation for I/O we define
> the alloc_io_page/free_io_page functions which share the I/O
> memory with the host in case the guest runs with
> protected virtualization.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/malloc_io.c | 50
> +++++++++++++++++++++++++++++++++++++++++++ lib/s390x/malloc_io.h |
> 18 ++++++++++++++++ s390x/Makefile        |  1 +
>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/s390x/malloc_io.c
>  create mode 100644 lib/s390x/malloc_io.h
> 
> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
> new file mode 100644
> index 0000000..2a946e0
> --- /dev/null
> +++ b/lib/s390x/malloc_io.c
> @@ -0,0 +1,50 @@
> +/*
> + * I/O page allocation
> + *
> + * Copyright (c) 2021 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify
> it
> + * under the terms of the GNU General Public License version 2.
> + *
> + * Using this interface provide host access to the allocated pages in
> + * case the guest is a secure guest.
> + * This is needed for I/O buffers.
> + *
> + */
> +#include <libcflat.h>
> +#include <asm/page.h>
> +#include <asm/uv.h>
> +#include <malloc_io.h>
> +#include <alloc_page.h>
> +#include <asm/facility.h>
> +
> +void *alloc_io_page(int size)
> +{
> +	void *p;
> +
> +	assert(size <= PAGE_SIZE);

I agree with Thomas here, remove size, or use it as a page count or
page order.

> +	p = alloc_pages_flags(1, AREA_DMA31);

you are allocating 2 pages here...

> +	if (!p)
> +		return NULL;
> +	memset(p, 0, PAGE_SIZE);

...and then clearing only one

but since you did not specify FLAG_DONTZERO, the page has been cleared
already by the allocator

> +
> +	if (!test_facility(158))
> +		return p;
> +
> +	if (uv_set_shared((unsigned long)p) == 0)
> +		return p;
> +
> +	free_pages(p);
> +	return NULL;
> +}
> +
> +void free_io_page(void *p)
> +{
> +	if (test_facility(158))
> +		uv_remove_shared((unsigned long)p);
> +	free_pages(p);
> +}
> diff --git a/lib/s390x/malloc_io.h b/lib/s390x/malloc_io.h
> new file mode 100644
> index 0000000..f780191
> --- /dev/null
> +++ b/lib/s390x/malloc_io.h
> @@ -0,0 +1,18 @@
> +/*
> + * I/O allocations
> + *
> + * Copyright (c) 2021 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify
> it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#ifndef _S390X_MALLOC_IO_H_
> +#define _S390X_MALLOC_IO_H_
> +
> +void *alloc_io_page(int size);
> +void free_io_page(void *p);
> +
> +#endif /* _S390X_MALLOC_IO_H_ */
> diff --git a/s390x/Makefile b/s390x/Makefile
> index b079a26..4b6301c 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -63,6 +63,7 @@ cflatobjs += lib/s390x/smp.o
>  cflatobjs += lib/s390x/vm.o
>  cflatobjs += lib/s390x/css_dump.o
>  cflatobjs += lib/s390x/css_lib.o
> +cflatobjs += lib/s390x/malloc_io.o
>  
>  OBJDIRS += lib/s390x
>  
