Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKBPPi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Nov 2020 10:15:38 -0500
Date: Mon, 2 Nov 2020 17:15:24 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 3/4] arch, mm: restore dependency of
 __kernel_map_pages() of DEBUG_PAGEALLOC
Message-ID: <20201102151524.GB4879@kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-4-rppt@kernel.org>
 <8eac2aa4-114e-f981-c8f8-ad8523175cf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eac2aa4-114e-f981-c8f8-ad8523175cf8@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Rientjes <rientjes@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Len Brown <len.brown@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org

On Mon, Nov 02, 2020 at 10:23:20AM +0100, David Hildenbrand wrote:
> 
> >   int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
> >   				   unsigned numpages, unsigned long page_flags)
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 14e397f3752c..ab0ef6bd351d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2924,7 +2924,11 @@ static inline bool debug_pagealloc_enabled_static(void)
> >   	return static_branch_unlikely(&_debug_pagealloc_enabled);
> >   }
> > -#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> > +#ifdef CONFIG_DEBUG_PAGEALLOC
> > +/*
> > + * To support DEBUG_PAGEALLOC architecture must ensure that
> > + * __kernel_map_pages() never fails
> 
> Maybe add here, that this implies mapping everything via PTEs during boot.

This is more of an implementation detail, while assumption that
__kernel_map_pages() does not fail is somewhat a requirement :)

> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
