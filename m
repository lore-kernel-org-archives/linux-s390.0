Return-Path: <linux-kernel-owner+w=401wt.eu-S932316AbYEFTt2@vger.kernel.org>
Date: Tue, 6 May 2008 15:46:12 -0400
From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Message-ID: <20080506154612.58cc3070@cuia.bos.redhat.com>
In-Reply-To: <1210087982.31803.32.camel@localhost>
References: <20080312132132.520833247@de.ibm.com>
	<Pine.LNX.4.64.0803131627450.17244@blonde.site>
	<1210087982.31803.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, zach@vmware.com, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl
List-ID: <linux-s390.vger.kernel.org>

On Tue, 06 May 2008 17:33:02 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> On Thu, 2008-03-13 at 16:57 +0000, Hugh Dickins wrote:
> > It's very encouraging to see Jeremy and Rusty weighing in.  I hope
> > Zach will too, and I've added Andrea: their support would count a lot.
> > You have Nick on the list, good, I've added Christoph and Peter
> > (if you do resend, linux-mm might prove more useful than linux-kernel).
> > 
> > With support from rival virtualizers,
> > I do think you've a good chance of getting in.
> 
> Traffic on the guest page hinting patches died down again. Until another
> user shows up I guess that's it for the full version. 

I suspect one of the problems is that there are too many state transitions
to have it implemented with a low overhead on anything but S390, and even
there you need milicoded instructions to handle things.

If the number of transitions can be reduced, page hinting could be useful
for KVM, too.

-- 
All Rights Reversed
