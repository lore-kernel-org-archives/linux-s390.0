Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgI1PcF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 11:32:05 -0400
Date: Mon, 28 Sep 2020 17:31:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
Message-ID: <20200928173147.750e7358.cohuck@redhat.com>
In-Reply-To: <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
        <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com

On Mon, 28 Sep 2020 16:23:34 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Some architectures need allocations to be done under a
> specific address limit to allow DMA from I/O.
> 
> We propose here a very simple page allocator to get
> pages allocated under this specific limit.
> 
> The DMA page allocator will only use part of the available memory
> under the DMA address limit to let room for the standard allocator.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/alloc_dma_page.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/alloc_dma_page.h | 24 +++++++++++++++++++
>  lib/s390x/sclp.c     |  2 ++
>  s390x/Makefile       |  1 +
>  4 files changed, 84 insertions(+)
>  create mode 100644 lib/alloc_dma_page.c
>  create mode 100644 lib/alloc_dma_page.h

(...)

> diff --git a/lib/alloc_dma_page.h b/lib/alloc_dma_page.h
> new file mode 100644
> index 0000000..85e1d2f
> --- /dev/null
> +++ b/lib/alloc_dma_page.h
> @@ -0,0 +1,24 @@
> +/*
> + * Page allocator for DMA definitions
> + *
> + * Copyright (c) IBM, Corp. 2020
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU Library General Public License version 2.
> + */
> +#ifndef _ALLOC_DMA_PAGE_H_
> +#define _ALLOC_DMA_PAGE_H_
> +
> +#include <asm/page.h>
> +
> +void put_dma_page(void *dma_page);
> +void *get_dma_page(void);
> +phys_addr_t dma_page_alloc_init(phys_addr_t start_pfn, phys_addr_t nb_pages);
> +
> +#define DMA_MAX_PFN	(0x80000000 >> PAGE_SHIFT)
> +#define DMA_ALLOC_RATIO	8

Hm, shouldn't the architecture be able to decide where a dma page can
be located? Or am I misunderstanding?

> +
> +#endif /* _ALLOC_DMA_PAGE_H_ */
(...)
