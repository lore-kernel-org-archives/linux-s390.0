Return-Path: <linux-kernel-owner+w=401wt.eu-S2993111AbXDYVcV@vger.kernel.org>
Date: Wed, 25 Apr 2007 14:30:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070425143011.57247c1d.akpm@linux-foundation.org>
In-Reply-To: <20070425112133.4ae86399.randy.dunlap@oracle.com>
References: <20070423141123.GA21174@skybase>
	<20070423104534.51bac974.akpm@linux-foundation.org>
	<20070425112133.4ae86399.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, 25 Apr 2007 11:21:33 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Mon, 23 Apr 2007 10:45:34 -0700 Andrew Morton wrote:
> 
> > On Mon, 23 Apr 2007 16:11:23 +0200
> > Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > 
> > > Greetings,
> > > I've added the results of the review to the Kconfig cleanup patches
> > > for s390. Patch #2 has been split, one half has all the HAS_IOMEM
> > > depends lines the other the remaining !S390 depends lines.
> > > 
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
> and I continue to be concerned about the amount of patch reviews
> compared to new patch material overall (not just s390).
> 

yes.  I'm increasingly reluctant to merge things which have had no visible
review from any third party.  Nowadays I'll shove such patches into a
pending folder and will wait a day or three to see if anyone has any
feedback.  If they don't I have to either ignore the patches or review them
myself.

I expect (and hope) that more formal processes will come about here.  Perhaps
up to it-won't-be-merged-without-a-Reviewed-by:.


But that only applies to things which I merge.  There's heaps of stuff
coming in via the git trees which is obviously inadequately reviewed - look
at all the instances of open-coded kernel_thread() which were merged after
the kthread() API was introduced, for example.


And other basic stuff like "use mutexes, not semaphores":

box:/usr/src/25> grep '^+.*[    ]down[  ]*[(]' patches/git-*.patch | wc -l
32



Ever wonder where all those whitespace bugs are coming from?

box:/usr/src/25> grep '^+.*[    ]if[(]' patches/git-*.patch | wc -l
265
box:/usr/src/25> grep '^+.*[    ]while[(]' patches/git-*.patch | wc -l  
35


Code which use spaces where it should be using tabs?

box:/usr/src/25> grep '^+        ' patches/git-*.patch | wc -l
1346


Heaven knows how many more serious problems are being snuck into the tree
via this route.

What do we do?
