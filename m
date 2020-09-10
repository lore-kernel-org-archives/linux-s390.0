Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgIJTMB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 15:12:01 -0400
Date: Thu, 10 Sep 2020 21:10:10 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910211010.46d064a7@thinkpad>
In-Reply-To: <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
        <20200910181319.GO87483@ziepe.ca>
        <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, 10 Sep 2020 11:33:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Sep 10, 2020 at 11:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > So.. To change away from the stack option I think we'd have to pass
> > the READ_ONCE value to pXX_offset() as an extra argument instead of it
> > derefing the pointer internally.
> 
> Yeah, but I think that would actually be the better model than passing
> an address to a random stack location.
> 
> It's also effectively what we do in some other places, eg the whole
> logic with "orig" in the regular pte fault handling is basically doing
> unlocked loads of the pte, various decisions on that, and then doing a
> final "is this still the same pte" after it has gotten the page table
> lock.

That sounds a lot like the pXd_offset_orig() from Martins first approach
in this thread:
https://lore.kernel.org/linuxppc-dev/20190418100218.0a4afd51@mschwideX1/

It is also the "Patch 1" option from the start of this thread:
https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/

I guess I chose wrongly there, should have had more trust in Martins
approach, and not try so hard to do it like others...

So, maybe we can start over again, from that patch option. It would of
course also initially introduce some gup-specific helpers, like with
the other approach. It seemed harder to generalize when I thought
about it back then, but I guess it should not be a lot harder than
the _addr_end stuff.

Or, maybe this time, just not to risk Christian getting a heart attack,
we could go for the gup-specific helper first, so that we would at
least have a fix for the possible s390 data corruption. Jason, would
you agree that we send a new RFC, this time with pXd_offset_orig()
approach, and have that accepted as short-term fix?

Or would you rather also wait for some proper generic change? Have
lost that option from my radar, so cannot really judge how much more
effort it would be. I'm on vacation next week anyway, but Alexander
or Vasily (who did the option 1 patch) could look into this further.
