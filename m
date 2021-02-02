Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBBLFD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 06:05:03 -0500
Date: Tue, 2 Feb 2021 12:04:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Message-ID: <YBkxqVrNnWFWmqTo@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
 <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
 <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
 <9100B8AE-129A-4E13-8F01-7B9C14C98B4C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9100B8AE-129A-4E13-8F01-7B9C14C98B4C@vmware.com>
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>, Yu Zhao <yuzhao@google.com>

On Tue, Feb 02, 2021 at 09:54:36AM +0000, Nadav Amit wrote:
> > On Feb 2, 2021, at 1:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Feb 02, 2021 at 07:20:55AM +0000, Nadav Amit wrote:
> >> Arm does not define tlb_end_vma, and consequently it flushes the TLB after
> >> each VMA. I suspect it is not intentional.
> > 
> > ARM is one of those that look at the VM_EXEC bit to explicitly flush
> > ITLB IIRC, so it has to.
> 
> Hmm… I don’t think Arm is doing that. At least arm64 does not use the
> default tlb_flush(), and it does not seem to consider VM_EXEC (at least in
> this path):
> 

ARM != ARM64. ARM certainly does, but you're right, I don't think ARM64
does this.
