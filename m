Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCCJuJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Mar 2020 04:50:09 -0500
Date: Tue, 3 Mar 2020 10:50:05 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 1/7] mm/memory_hotplug: Drop the flags field from
 struct mhp_restrictions
Message-ID: <20200303095005.GE4380@dhcp22.suse.cz>
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200221182503.28317-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221182503.28317-2-logang@deltatee.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>

On Fri 21-02-20 11:24:57, Logan Gunthorpe wrote:
> This variable is not used anywhere and should therefore be removed
> from the structure.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..69ff3037528d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -55,11 +55,9 @@ enum {
>  
>  /*
>   * Restrictions for the memory hotplug:
> - * flags:  MHP_ flags
>   * altmap: alternative allocator for memmap array
>   */
>  struct mhp_restrictions {
> -	unsigned long flags;
>  	struct vmem_altmap *altmap;
>  };
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
