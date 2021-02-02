Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhBBHPK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 02:15:10 -0500
Date: Tue, 02 Feb 2021 17:14:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
References: <20210131001132.3368247-1-namit@vmware.com>
        <1612063149.2awdsvvmhj.astroid@bobo.none>
        <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
        <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
In-Reply-To: <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1612248111.g00kf5qxrp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

Excerpts from Peter Zijlstra's message of February 1, 2021 10:44 pm:
> On Sun, Jan 31, 2021 at 07:57:01AM +0000, Nadav Amit wrote:
>> > On Jan 30, 2021, at 7:30 PM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
>=20
>> > I'll go through the patches a bit more closely when they all come=20
>> > through. Sparc and powerpc of course need the arch lazy mode to get=20
>> > per-page/pte information for operations that are not freeing pages,=20
>> > which is what mmu gather is designed for.
>>=20
>> IIUC you mean any PTE change requires a TLB flush. Even setting up a new=
 PTE
>> where no previous PTE was set, right?

In cases of increasing permissiveness of access, yes it may want to=20
update the "TLB" (read hash table) to avoid taking hash table faults.

But whatever the reason for the flush, there may have to be more
data carried than just the virtual address range and/or physical
pages.

If you clear out the PTE then you have no guarantee of actually being
able to go back and address the the in-memory or in-hardware translation=20
structures to update them, depending on what exact scheme is used
(powerpc probably could if all page sizes were the same, but THP or=20
64k/4k sub pages would throw a spanner in those works).

> These are the HASH architectures. Their hardware doesn't walk the
> page-tables, but it consults a hash-table to resolve page translations.

Yeah, it's very cool in a masochistic way.

I actually don't know if it's worth doing a big rework of it, as much=20
as I'd like to. Rather than just keep it in place and eventually
dismantling some of the go-fast hooks from core code if we can one day
deprecate it in favour of the much easier radix mode.

The whole thing is like a big steam train, years ago Paul and Ben and=20
Anton and co got the boiler stoked up and set all the valves just right=20
so it runs unbelievably well for what it's actually doing but look at it
the wrong way and the whole thing could blow up. (at least that's what=20
it feels like to me probably because I don't know the code that well).

Sparc could probably do the same, not sure about Xen. I don't suppose
vmware is intending to add any kind of paravirt mode related to this stuff?

Thanks,
Nick
