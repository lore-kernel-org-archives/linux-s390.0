Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37611 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgB0RRH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Feb 2020 12:17:07 -0500
Received: by mail-qv1-f65.google.com with SMTP id ci20so1912105qvb.4
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 09:17:06 -0800 (PST)
Date: Thu, 27 Feb 2020 13:17:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
Message-ID: <20200227171704.GK31668@ziepe.ca>
References: <20200221182503.28317-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221182503.28317-1-logang@deltatee.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>

On Fri, Feb 21, 2020 at 11:24:56AM -0700, Logan Gunthorpe wrote:
> Hi,
> 
> This is v3 of the patchset which cleans up a number of minor issues
> from the feedback of v2 and rebases onto v5.6-rc2. Additional feedback
> is welcome.
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Changes in v3:
>  * Rebased onto v5.6-rc2
>  * Rename mhp_modifiers to mhp_params per David with an updated kernel
>    doc per Dan
>  * Drop support for s390 per David seeing it does not support
>    ZONE_DEVICE yet and there was a potential problem with huge pages.
>  * Added WARN_ON_ONCE in cases where arches recieve non PAGE_KERNEL
>    parameters
>  * Collected David and Micheal's Reviewed-By and Acked-by Tags
> 
> Changes in v2:
>  * Rebased onto v5.5-rc5
>  * Renamed mhp_restrictions to mhp_modifiers and added the pgprot field
>    to that structure instead of using an argument for
>    arch_add_memory().
>  * Add patch to drop the unused flags field in mhp_restrictions
> 
> A git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem remap_pages_cache_v3
> 
> --
> 
> Currently, the page tables created using memremap_pages() are always
> created with the PAGE_KERNEL cacheing mode. However, the P2PDMA code
> is creating pages for PCI BAR memory which should never be accessed
> through the cache and instead use either WC or UC. This still works in
> most cases, on x86, because the MTRR registers typically override the
> caching settings in the page tables for all of the IO memory to be
> UC-. However, this tends not to work so well on other arches or
> some rare x86 machines that have firmware which does not setup the
> MTRR registers in this way.
> 
> Instead of this, this series proposes a change to arch_add_memory()
> to take the pgprot required by the mapping which allows us to
> explicitly set pagetable entries for P2PDMA memory to WC.

Is there a particular reason why WC was selected here? I thought for
the p2pdma cases there was no kernel user that touched the memory?

I definitely forsee devices where we want UC instead.

Even so, the whole idea looks like the right direction to me.

Jason
