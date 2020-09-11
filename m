Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgIKUFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Sep 2020 16:05:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F59C061573
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2020 13:05:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y9so2312213ilq.2
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2020 13:05:14 -0700 (PDT)
Date: Fri, 11 Sep 2020 17:05:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200911200511.GC1221970@ziepe.ca>
References: <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
 <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
 <20200911194000.GB1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911194000.GB1221970@ziepe.ca>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Linus Torvalds <torvalds@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Fri, Sep 11, 2020 at 04:40:00PM -0300, Jason Gunthorpe wrote:
> These would probably be better as static inlines though, as only s390
> compiles will type check pudp like this.

Never mind, it must be a macro - still need brackets though

Jason
