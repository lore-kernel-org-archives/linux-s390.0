Return-Path: <linux-kernel-owner+w=401wt.eu-S1755234AbYCQIWE@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1205530358.14987.32.camel@bodhitayantram.eng.vmware.com>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site> <47D9754B.1030509@goop.org>
	 <1205530358.14987.32.camel@bodhitayantram.eng.vmware.com>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 10:21:40 +0100
Message-Id: <1205745700.16137.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl, Keir Fraser <keir@xensource.com>, Ian Pratt <ian.pratt@xensource.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2008-03-14 at 14:32 -0700, Zachary Amsden wrote:
> On Fri, 2008-03-14 at 11:30 -0700, Jeremy Fitzhardinge wrote:
> > Zachary Amsden wrote:
> > > How about a fake hypervisor, which is really just a random page evictor,
> > > following the rules of CMM?
> > >   
> > 
> > Probably simpler to just have variants of the page_set_* functions which 
> > simulate the worst-possible host action immediately (ie, stealing pages, 
> > logically swapping them, etc).  That wouldn't give you full coverage, 
> > but it would go some way.  An async variant which schedules a change in 
> > a few milliseconds would help too.
> > 
> > I guess that's equivalent to having a special-purpose hypervisor built 
> > into the kernel (hm, sounds familiar...).
> 
> It needn't be that hard on s390, I believe you don't need to worry about
> PTEs becoming asynchronous when stealing a page, since if I understand
> the hypervisor architecture, there is a per-page mapping level
> available, allowing you to generate discard faults on access.  It might
> be possible to use this mapping layer without implementing a full blown
> hypervisor.  Martin?

Yes, on s390 the PTEs cannot be asynchronous because there is no need to
synchronize them in the first place. A mapping layer with all primitives
without using the SIE instruction will be difficult. For one we cannot
use the ESSA instruction which isolates the state changes and host page
table is tied to the SIE. The page state is stored in the page table
extension and the discard state is basically a specially marked invalid
pte in the host table. A mapping layer with some restrictions is
certainly possible.

> For x86, at discard time, you would have to manually walk and invalidate
> any PTEs potentially mapping the discarded page, but there is already
> this great thing called Xen paravirt-ops which actually does that for
> completely different reasons (PT page protection).

If you have to walk the guest page tables you call into the guest, no ?
I would characterize this more as a ballooner since you need guest
activity to do the page stealing. The trick with guest page hinting is
that you do NOT call into the guest to do the discard. You'll a nested
page table for that I'm afraid.

> I think a random exponential distribution for discard would be needed to
> catch all the racey failure modes.

We had quite a few of these racy failures. Nasty. Hard to find.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
