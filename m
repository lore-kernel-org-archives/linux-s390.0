Return-Path: <linux-kernel-owner+w=401wt.eu-S1757798AbYCMVhj@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Zachary Amsden <zach@vmware.com>
In-Reply-To: <20080313194507.GJ7365@v2.random>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site>
	 <1205430307.18433.20.camel@bodhitayantram.eng.vmware.com>
	 <20080313194507.GJ7365@v2.random>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 14:41:57 -0700
Message-Id: <1205444517.14987.14.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, clameter@sgi.com, a.p.zijlstra@chello.nl
List-ID: <linux-s390.vger.kernel.org>


On Thu, 2008-03-13 at 20:45 +0100, Andrea Arcangeli wrote:
> On Thu, Mar 13, 2008 at 10:45:07AM -0700, Zachary Amsden wrote:
> > What doesn't appear to be useful however, is support for this under
> > VMware.  It can be done, even without the writable pte support (yes,
> > really).  But due to us exploiting optimizations at lower layers, it
> > doesn't appear that it will gain us any performance - and we must
> > already have the complex working set algorithms to support
> > non-paravirtualized guests.
> 
> With non-paravirt all you can do is to swap the guest physical memory
> (mmu notifiers allows linux to do that) or share memory (mmu notifiers
> + ksm allows linux to do that too). We also have complex working set
> algorithms that we use to finds which parts of the guest physical
> address space are best to swap first: the core linux VM.

We can tap into those algorithms just as effectively using ballooning, and we've optimized the sharing and working set models from outside of the guest.  So while CMM gives slightly better information for a random forced page eviction, the complexity doesn't appear to justify the savings for a VMware implementation.

Things would change quite a bit if we had hardware supported per-page dirty bits.

> than avoiding a few swapouts sometime (without mmu notifiers
> everything else is irrelevant, including guest page hinting and
> including ballooning too cause madvise(don't need) won't clear sptes
> and invalidate guest tlbs).

Ballooning still works if you use a kernel based balloon driver.  Using
madvise wouldn't be a reliable way to balloon anyway.  Are you talking
about an API to manage working sets and such from userspace?

Cheers,

Zach
