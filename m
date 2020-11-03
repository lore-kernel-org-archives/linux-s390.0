Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgKCOjS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 09:39:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CF1C061A47
        for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2020 06:39:17 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p15so19328520ljj.8
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2020 06:39:17 -0800 (PST)
Date: Tue, 3 Nov 2020 17:39:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/4] PM: hibernate: make direct map manipulations more
 explicit
Message-ID: <20201103143916.otz2o4h2dlmewn3h@box>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <20201103110816.t6a3ebtgcm7mfogy@box>
 <20201103121350.GI4879@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121350.GI4879@kernel.org>
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Len Brown <len.brown@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 03, 2020 at 02:13:50PM +0200, Mike Rapoport wrote:
> On Tue, Nov 03, 2020 at 02:08:16PM +0300, Kirill A. Shutemov wrote:
> > On Sun, Nov 01, 2020 at 07:08:13PM +0200, Mike Rapoport wrote:
> > > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > > index 46b1804c1ddf..054c8cce4236 100644
> > > --- a/kernel/power/snapshot.c
> > > +++ b/kernel/power/snapshot.c
> > > @@ -76,6 +76,32 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
> > >  static inline void hibernate_restore_unprotect_page(void *page_address) {}
> > >  #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> > >  
> > > +static inline void hibernate_map_page(struct page *page, int enable)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > > +		unsigned long addr = (unsigned long)page_address(page);
> > > +		int ret;
> > > +
> > > +		/*
> > > +		 * This should not fail because remapping a page here means
> > > +		 * that we only update protection bits in an existing PTE.
> > > +		 * It is still worth to have WARN_ON() here if something
> > > +		 * changes and this will no longer be the case.
> > > +		 */
> > > +		if (enable)
> > > +			ret = set_direct_map_default_noflush(page);
> > > +		else
> > > +			ret = set_direct_map_invalid_noflush(page);
> > > +
> > > +		if (WARN_ON(ret))
> > 
> > _ONCE?
> 
> I've changed it to pr_warn() after David said people enable panic on
> warn in production kernels.

pr_warn_once()? :P

-- 
 Kirill A. Shutemov
