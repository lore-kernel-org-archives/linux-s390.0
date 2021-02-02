Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Feb 2021 10:31:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Message-ID: <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
 <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

On Tue, Feb 02, 2021 at 07:20:55AM +0000, Nadav Amit wrote:
> Arm does not define tlb_end_vma, and consequently it flushes the TLB after
> each VMA. I suspect it is not intentional.

ARM is one of those that look at the VM_EXEC bit to explicitly flush
ITLB IIRC, so it has to.
