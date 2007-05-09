Return-Path: <linux-kernel-owner+w=401wt.eu-S1756503AbXEILVh@vger.kernel.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070423104534.51bac974.akpm@linux-foundation.org>
References: <20070423141123.GA21174@skybase>
	 <20070423104534.51bac974.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 09 May 2007 13:21:50 +0200
Message-Id: <1178709710.30649.37.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2007-04-23 at 10:45 -0700, Andrew Morton wrote: 
> > Andrew: I plan to add patches 1-5 to the for-andrew branch of the
> > git390 repository if that is fine with you. The only thing that will
> > be missing in the tree is the patch that disables wireless for s390.
> > The code does compile but without hardware it is mute to have the
> > config options. I'll wait until the git-wireless.patch is upstream.
> > Patches 7-9 depend on patches found in -mm.
> > 
> 
> umm, OK.  If it's Ok I think I'll duck it for now: -mm is full.
> 
> Over-full, really: I've been working basically continuously since Friday
> getting the current dungpile to compile and boot, and it's still miles away
> from that.

Is -mm less full now? I've seen you dropped your third patch bomb, so
maybe there is room now ..
I regenerated the kconfig patches. They fit on top of todays git but
they do have some rejects on 2.6.21-mm1. The rejects are trivial to fix,
but there are about 10 of them.

So when will be a good time to add the Kconfig patches to git390?
And do you prefer to let them rot^H^H^Hmature in -mm for a while before
they can go upstream?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
