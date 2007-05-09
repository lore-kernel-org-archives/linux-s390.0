Return-Path: <linux-kernel-owner+w=401wt.eu-S1757998AbXEIQh1@vger.kernel.org>
Date: Wed, 9 May 2007 09:35:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070509093547.55ca7f8c.akpm@linux-foundation.org>
In-Reply-To: <1178709710.30649.37.camel@localhost>
References: <20070423141123.GA21174@skybase>
	<20070423104534.51bac974.akpm@linux-foundation.org>
	<1178709710.30649.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, 09 May 2007 13:21:50 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 2007-04-23 at 10:45 -0700, Andrew Morton wrote: 
> > > Andrew: I plan to add patches 1-5 to the for-andrew branch of the
> > > git390 repository if that is fine with you. The only thing that will
> > > be missing in the tree is the patch that disables wireless for s390.
> > > The code does compile but without hardware it is mute to have the
> > > config options. I'll wait until the git-wireless.patch is upstream.
> > > Patches 7-9 depend on patches found in -mm.
> > > 
> > 
> > umm, OK.  If it's Ok I think I'll duck it for now: -mm is full.
> > 
> > Over-full, really: I've been working basically continuously since Friday
> > getting the current dungpile to compile and boot, and it's still miles away
> > from that.
> 
> Is -mm less full now? I've seen you dropped your third patch bomb, so
> maybe there is room now ..

Near 500 patches, which is the lowest it's been in years.  I do appear to
have a few hundred patch-bearing emails saved away though.

> I regenerated the kconfig patches. They fit on top of todays git but
> they do have some rejects on 2.6.21-mm1. The rejects are trivial to fix,
> but there are about 10 of them.
> 
> So when will be a good time to add the Kconfig patches to git390?

Go wild.

> And do you prefer to let them rot^H^H^Hmature in -mm for a while before
> they can go upstream?

Your call.  I'd be inclined to push them early personally - Kconfig
problems tend to be easy to spot and easy to fix and there's ample time to
fine tune it.
