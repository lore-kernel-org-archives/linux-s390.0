Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgAHM13 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 07:27:29 -0500
Subject: Re: [PATCH v2 1/8] mm/memory_hotplug: Drop the flags field from
 struct mhp_restrictions
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-2-logang@deltatee.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c3c3c475-f828-13f7-b5c9-f691ef0fe1ff@redhat.com>
Date: Wed, 8 Jan 2020 13:27:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200107205959.7575-2-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>

On 07.01.20 21:59, Logan Gunthorpe wrote:
> This variable is not used anywhere and should therefore be removed
> from the structure.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/memory_hotplug.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index ba0dca6aac6e..e47a29761088 100644
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

We wanted to use that for the "vmemmap on added memory" config knob. But
that might still take some time and we might actually realize it using
the altmap instead (hopefully :) ).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
