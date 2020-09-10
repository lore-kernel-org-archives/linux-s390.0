Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728207AbgIJJkm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 05:40:42 -0400
Date: Thu, 10 Sep 2020 11:39:25 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910093925.GB29166@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909180324.GI87483@ziepe.ca>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Wed, Sep 09, 2020 at 03:03:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 07:25:34PM +0200, Gerald Schaefer wrote:
> > I actually had to draw myself a picture to get some hold of
> > this, or rather a walk-through with a certain pud-crossing
> > range in a folded 3-level scenario. Not sure if I would have
> > understood my explanation above w/o that, but I hope you can
> > make some sense out of it. Or draw yourself a picture :-)
> 
> What I don't understand is how does anything work with S390 today?
> 
> If the fix is only to change pxx_addr_end() then than generic code
> like mm/pagewalk.c will iterate over a *different list* of page table
> entries. 
> 
> It's choice of entries to look at is entirely driven by pxx_addr_end().
> 
> Which suggest to me that mm/pagewalk.c also doesn't work properly
> today on S390 and this issue is not really about stack variables?
> 
> Fundamentally if pXX_offset() and pXX_addr_end() must be consistent
> together, if pXX_offset() is folded then pXX_addr_end() must cause a
> single iteration of that level.

Your observation is correct.

Another way to describe the problem is existing pXd_addr_end helpers
could be applied to mismatching levels on s390 (e.g p4d_addr_end
applied to pud or pgd_addr_end applied to p4d). As you noticed,
all *_pXd_range iterators could be called with address ranges that
exceed single pXd table.

However, when it happens with pointers to real page tables (passed to
*_pXd_range iterators) we still operate on valid tables, which just
(lucky for us) happened to be folded. Thus we still reference correct
table entries.

It is only gup_fast case that exposes the issue. It hits because
pointers to stack copies are passed to gup_pXd_range iterators, not
pointers to real page tables itself.

As Gerald mentioned, it is very difficult to explain in a clear way.
Hopefully, one could make sense ot of it.

> Jason
