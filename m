Return-Path: <linux-kernel-owner+w=401wt.eu-S1761086AbYEGDsd@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Zachary Amsden <zach@vmware.com>
In-Reply-To: <20080506154612.58cc3070@cuia.bos.redhat.com>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site>
	 <1210087982.31803.32.camel@localhost>
	 <20080506154612.58cc3070@cuia.bos.redhat.com>
Content-Type: text/plain
Date: Tue, 06 May 2008 20:49:47 -0700
Message-Id: <1210132187.17107.40.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rik van Riel <riel@redhat.com>
Cc: schwidefsky@de.ibm.com, Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl
List-ID: <linux-s390.vger.kernel.org>


On Tue, 2008-05-06 at 15:46 -0400, Rik van Riel wrote:
> On Tue, 06 May 2008 17:33:02 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > On Thu, 2008-03-13 at 16:57 +0000, Hugh Dickins wrote:
> > > It's very encouraging to see Jeremy and Rusty weighing in.  I hope
> > > Zach will too, and I've added Andrea: their support would count a lot.
> > > You have Nick on the list, good, I've added Christoph and Peter
> > > (if you do resend, linux-mm might prove more useful than linux-kernel).
> > > 
> > > With support from rival virtualizers,
> > > I do think you've a good chance of getting in.
> > 
> > Traffic on the guest page hinting patches died down again. Until another
> > user shows up I guess that's it for the full version. 
> 
> I suspect one of the problems is that there are too many state transitions
> to have it implemented with a low overhead on anything but S390, and even
> there you need milicoded instructions to handle things.
> 
> If the number of transitions can be reduced, page hinting could be useful
> for KVM, too.

Spot on Rik, if every transition becomes a hypercall (and a synchronous
one at that), it isn't workable for us.  If, on the other hand, you
share the state bits between the guest and hypervisor, you need a giant
(standalone) bit array for per-page state, which is neither convenient
for Linux nor the hypervisor.  I believe s390 has an 'instruction' to
migrate the state bits into the hypervisor per-physical-page data
without requiring a hypercall.

Zach
