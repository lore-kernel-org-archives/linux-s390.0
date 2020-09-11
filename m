Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgIKMlZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Sep 2020 08:41:25 -0400
Date: Fri, 11 Sep 2020 14:40:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 2/3] s390: define UV compatible I/O allocation
Message-ID: <20200911144058.5fe82f26.cohuck@redhat.com>
In-Reply-To: <1598875533-19947-3-git-send-email-pmorel@linux.ibm.com>
References: <1598875533-19947-1-git-send-email-pmorel@linux.ibm.com>
        <1598875533-19947-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 31 Aug 2020 14:05:32 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To centralize the memory allocation for I/O we define
> the alloc/free_io_page() functions which share the I/O
> memory with the host in case the guest runs with
> protected virtualization.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/malloc_io.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/malloc_io.h | 14 ++++++++++++
>  s390x/Makefile        |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100644 lib/s390x/malloc_io.c
>  create mode 100644 lib/s390x/malloc_io.h
> 
> diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
> new file mode 100644
> index 0000000..0e67aab
> --- /dev/null
> +++ b/lib/s390x/malloc_io.c
> @@ -0,0 +1,53 @@
> +/*
> + * I/O page allocation
> + *
> + * Copyright (c) 2020 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + *
> + * Using this interface provide host access to the allocated pages in
> + * case the guest is a secure guest.
> + * This is needed for I/O buffers.
> + *
> + */
> +
> +#include <libcflat.h>
> +#include <alloc_page.h>
> +#include <asm/page.h>
> +#include <asm/uv.h>
> +#include <malloc_io.h>
> +#include <asm/facility.h>
> +
> +
> +void *alloc_io_page(int size)
> +{
> +	void *p;
> +
> +	assert(size <= PAGE_SIZE);
> +	p = alloc_page();

I see that you use this for some I/O structures in the next patch. Is
this guaranteed to be under 2G all the time?
