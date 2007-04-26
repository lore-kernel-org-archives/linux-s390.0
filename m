Return-Path: <linux-kernel-owner+w=401wt.eu-S1754693AbXDZDDu@vger.kernel.org>
Date: Wed, 25 Apr 2007 20:02:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070425200207.77a2721a.akpm@linux-foundation.org>
In-Reply-To: <4630109F.6090002@oracle.com>
References: <20070423141123.GA21174@skybase>
	<20070423104534.51bac974.akpm@linux-foundation.org>
	<20070425112133.4ae86399.randy.dunlap@oracle.com>
	<20070425143011.57247c1d.akpm@linux-foundation.org>
	<20070425172447.1576c399.akpm@linux-foundation.org>
	<20070426003911.GA19383@redhat.com>
	<4630109F.6090002@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Dave Jones <davej@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, 25 Apr 2007 19:38:23 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:

> Dave Jones wrote:
> > On Wed, Apr 25, 2007 at 05:24:47PM -0700, Andrew Morton wrote:
> > 
> >  > It would be neat if someone could create and maintain a new
> >  > scripts/spot-common-mistakes.  Feed it a unified diff and it would complain
> >  > about newly-added code (and only newly-added code) which has busted
> >  > whitespace, adds new semaphores, adds new kernel_thread calls, etc, etc.
> > 
> > years and years ago, when the dinosaurs roamed the land, I hacked up..
> > http://janitor.kernelnewbies.org/scripts/  and then left it by the wayside.
> > Some of the checks it did are actually bogus, but I'm happy to pick that
> > up again if there's interest in it being a useful tool.
> > 
> > In fact, I should probably munge it together with a similar thing
> > I wrote at http://www.codemonkey.org.uk/projects/findbugs/
> > (Warning: scary regexps)
> > 
> >  > It would need to be fairly simple and easily-extensible, as I can
> >  > imagine quite a few things getting added to it.
> >  > 
> >  > (Imagines a procmail rule which just bounces the email if
> >  > spot-common-mistakes failed)
> > 
> > or a git checkin rule that refuses to commit if it fails ;-)
> 
> Yep, I was going to mention your scripts but you beat me to it.
> 
> I'll be glad to help maintain such animals if wanted.
> 

wanted ;)

At least, it would be interesting to investigate the usefulness.  I suspect
it will prove to be very useful for the little things.

Heck, someone could subscribe a robot to all the mailing lists which sends
nastygrams straight back at people who submit broken patches.  We already
need that for tab-replaced and word-wrapped patches.  (ok, we have it -
it's called akpm, but being robotic wearies one)
