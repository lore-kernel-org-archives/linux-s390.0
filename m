Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Feb 2021 13:44:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Message-ID: <YBf3sl3M+j3hJRoM@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <1612063149.2awdsvvmhj.astroid@bobo.none>
 <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1589669-34AE-4E15-8358-79BAD7C72520@vmware.com>
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

On Sun, Jan 31, 2021 at 07:57:01AM +0000, Nadav Amit wrote:
> > On Jan 30, 2021, at 7:30 PM, Nicholas Piggin <npiggin@gmail.com> wrote:

> > I'll go through the patches a bit more closely when they all come 
> > through. Sparc and powerpc of course need the arch lazy mode to get 
> > per-page/pte information for operations that are not freeing pages, 
> > which is what mmu gather is designed for.
> 
> IIUC you mean any PTE change requires a TLB flush. Even setting up a new PTE
> where no previous PTE was set, right?

These are the HASH architectures. Their hardware doesn't walk the
page-tables, but it consults a hash-table to resolve page translations.

They _MUST_ flush the entries under the PTL to avoid ever seeing
conflicting information, which will make them really unhappy. They can
do this because they have TLBI broadcast.

There's a few more details I'm sure, but those seem to have slipped from
my mind.
