Return-Path: <linux-kernel-owner+w=401wt.eu-S1756584AbYCMRPT@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.64.0803131627450.17244@blonde.site>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 18:14:58 +0100
Message-Id: <1205428498.5920.30.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, zach@vmware.com, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-03-13 at 16:57 +0000, Hugh Dickins wrote:
> > The last versions of the patches do not differ much, I consider the code
> > to be stable. My question now is how to proceed with the code. I sure
> > would love to see the code going upstream some day but that depends on
> > the mm developers as the code adds complexity that needs to be supported.
> > If the general feeling is that the advantages of this approach do not
> > warrent for the added complexity this will likely be the last time you
> > will hear about guest page hinting. 
> 
> Oh, that would be such a shame.  Your guest page hinting patches remind
> me of that childhood thrill, when once a year the circus comes to town ;)
> 
> But seriously, I'm ashamed to see my name in the Cc list: it would
> be very unfair if your patches never made it in, just because I've
> failed to find the time to wrap my own puny brain around them.

It is an effort to get you head around it the first time. It gets
easiert the more you talk about it :-)

> It's very encouraging to see Jeremy and Rusty weighing in.  I hope
> Zach will too, and I've added Andrea: their support would count a lot.
> You have Nick on the list, good, I've added Christoph and Peter
> (if you do resend, linux-mm might prove more useful than linux-kernel).

Grr, did I really forgot to copy linux-mm?!? (..insert you favourite
four letter word here..). I absolutely intended to copy linux-mm but
somehow replaced it with linux-s390.

> With support from rival virtualizers,
> I do think you've a good chance of getting in.

Yes, it would be great if we can find another user for it.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
