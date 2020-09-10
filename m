Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgIJV7Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 17:59:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D681C061756
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 14:59:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so7708814qkn.11
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 14:59:24 -0700 (PDT)
Date: Thu, 10 Sep 2020 18:59:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910215921.GP87483@ziepe.ca>
References: <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
 <20200910211010.46d064a7@thinkpad>
 <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 12:32:05PM -0700, Linus Torvalds wrote:
> Yeah, I get hung up on naming sometimes. I don't tend to care much
> about private local variables ("i" is a perfectly fine variable name),
> but these kinds of somewhat subtle cross-architecture definitions I
> feel matter.

One of the first replys to this patch was to ask "when would I use
_orig vs normal", so you are not alone. The name should convey it..

So, I suggest pXX_offset_unlocked()

Since it is safe to call without the page table lock, while pXX_offset()
requires the page table lock to be held as the internal *pXX is a data
race otherwise.

Patch 1 might be OK for a stable backport, but to get to a clear
pXX_offset_unlocked() all the arches would want to be changed to
implement that API and the generic code would provide the wrapper:

#define pXX_offset(pXXp, address) pXX_offset_unlocked(pXXp, *(pXXp), address)

Arches would not have a *pXX inside their code.

Then we can talk about auditing call sites of pXX_offset and think
about using the _unlocked version in places where the page table lock
is not held.

For instance mm/pagewalk.c should be changed. So should
huge_pte_offset() and probably other places. These places might
already be exsting data-race bugs.

It is code-as-documentation indicating an unlocked page table walk.

Now it is not just a S390 story but a change that makes the data
concurrency much clearer, so I think I prefer this version to the
addr_end one too.

Regards,
Jason
