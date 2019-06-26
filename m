Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZGLi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 02:11:38 -0400
Date: Wed, 26 Jun 2019 08:11:34 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default
 for NUMA
Message-ID: <20190626061134.GD17798@dhcp22.suse.cz>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <1561501810-25163-2-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561501810-25163-2-git-send-email-Hoan@os.amperecomputing.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hoan Tran OS <hoan@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

On Tue 25-06-19 22:30:24, Hoan Tran OS wrote:
> This patch enables CONFIG_NODES_SPAN_OTHER_NODES by default
> for NUMA. As some NUMA nodes have memory ranges that span other
> nodes. Even though a pfn is valid and between a node's start and
> end pfns, it may not reside on that node.

Please describe the problem more thoroughly. What is the layout, what
doesn't work with the default configuration and why do we need this
particular fix rather than enabling of the config option for the
specific HW.

> 
> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8a..6335505 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1413,7 +1413,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  }
>  #endif
>  
> -#ifdef CONFIG_NODES_SPAN_OTHER_NODES
> +#ifdef CONFIG_NUMA
>  /* Only safe to use early in boot when initialisation is single-threaded */
>  static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
>  {
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
