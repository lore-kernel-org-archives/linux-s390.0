Return-Path: <linux-kernel-owner+w=401wt.eu-S1423365AbXDYSU1@vger.kernel.org>
Date: Wed, 25 Apr 2007 11:21:33 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070425112133.4ae86399.randy.dunlap@oracle.com>
In-Reply-To: <20070423104534.51bac974.akpm@linux-foundation.org>
References: <20070423141123.GA21174@skybase>
	<20070423104534.51bac974.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 Apr 2007 10:45:34 -0700 Andrew Morton wrote:

> On Mon, 23 Apr 2007 16:11:23 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > Greetings,
> > I've added the results of the review to the Kconfig cleanup patches
> > for s390. Patch #2 has been split, one half has all the HAS_IOMEM
> > depends lines the other the remaining !S390 depends lines.
> > 
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

and I continue to be concerned about the amount of patch reviews
compared to new patch material overall (not just s390).

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
