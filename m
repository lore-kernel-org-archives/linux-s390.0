Return-Path: <linux-kernel-owner+w=401wt.eu-S1755458AbYCLXgL@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 4/6] Guest page hinting: writable page table entries.
Date: Thu, 13 Mar 2008 10:35:11 +1100
References: <20080312132132.520833247@de.ibm.com> <20080312132703.979194690@de.ibm.com>
In-Reply-To: <20080312132703.979194690@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803131035.11943.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: virtualization@lists.linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Thursday 13 March 2008 00:21:36 Martin Schwidefsky wrote:
> Index: linux-2.6/fs/exec.c
> ===================================================================
> --- linux-2.6.orig/fs/exec.c
> +++ linux-2.6/fs/exec.c
> @@ -51,6 +51,7 @@
>  #include <linux/tsacct_kern.h>
>  #include <linux/cn_proc.h>
>  #include <linux/audit.h>
> +#include <linux/page-states.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/mmu_context.h>

I haven't compile-tested, but this seems unnecessary; it's the only change to 
this file.

> +/**
> + * __page_reset_writable() - clear the PageWritable bit
> + *
> + * @page: the page
> + */
> +void __page_reset_writable(struct page *page)
> +{
> +	preempt_disable();
> +	if (!page_test_set_state_change(page)) {
> +		ClearPageWritable(page);
> +		page_clear_state_change(page);
> +	}
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(__page_reset_writable);

If I understand correctly, you don't bother resetting the writable bit if you 
don't get the state_change lock.  Is this best effort, or is there some 
correctness issue here?

Cheers,
Rusty.
