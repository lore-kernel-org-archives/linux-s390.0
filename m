Return-Path: <linux-kernel-owner+w=401wt.eu-S1754700AbXDZEZm@vger.kernel.org>
Date: Thu, 26 Apr 2007 00:24:50 -0400
From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-ID: <20070426042450.GB11278@redhat.com>
References: <20070423141123.GA21174@skybase> <20070423104534.51bac974.akpm@linux-foundation.org> <20070425112133.4ae86399.randy.dunlap@oracle.com> <20070425143011.57247c1d.akpm@linux-foundation.org> <20070425172447.1576c399.akpm@linux-foundation.org> <20070426003911.GA19383@redhat.com> <4630109F.6090002@oracle.com> <20070425200207.77a2721a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070425200207.77a2721a.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 25, 2007 at 08:02:07PM -0700, Andrew Morton wrote:
 > On Wed, 25 Apr 2007 19:38:23 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:
 > > > In fact, I should probably munge it together with a similar thing
 > > > I wrote at http://www.codemonkey.org.uk/projects/findbugs/
 > > > (Warning: scary regexps)
 > > I'll be glad to help maintain such animals if wanted.
 > 
 > wanted ;)
 > 
 > At least, it would be interesting to investigate the usefulness.  I suspect
 > it will prove to be very useful for the little things.

Yeah, the original script tried to do things like spinlock balancing checks,
(badly). This was long before had sparse, and it was partly a "lets learn some perl"
experience for myself. I'll toss that idea out now that we have better tools
for that, and keep it to simple checks.

 > Heck, someone could subscribe a robot to all the mailing lists which sends
 > nastygrams straight back at people who submit broken patches.  We already
 > need that for tab-replaced and word-wrapped patches.  (ok, we have it -
 > it's called akpm, but being robotic wearies one)

Ok, I've got a few different flavours of that script. I'll roll them
all into one tomorrow and throw out some of the noisy silly ones
(I don't think warning about strcpy->strncpy is really worthwhile for eg).

Additional regexps gratefully recieved.

	Dave

-- 
http://www.codemonkey.org.uk
