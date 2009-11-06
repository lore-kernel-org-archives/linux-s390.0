Return-Path: <linux-kernel-owner+w=401wt.eu-S1756108AbZKFJeY@vger.kernel.org>
Date: Fri, 6 Nov 2009 10:34:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/2] nohz tweaking
Message-ID: <20091106103425.6ebf47f7@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20091106084138.GB22505@elte.hu>
References: <20090929122514.693636761@de.ibm.com>
	<alpine.LFD.2.00.0909301204460.2756@nanos>
	<20091104144052.0b4e99e1@mschwide.boeblingen.de.ibm.com>
	<20091106084138.GB22505@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Ingo,

On Fri, 6 Nov 2009 09:41:38 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> * Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > Moin Thomas,
> > 
> > On Wed, 30 Sep 2009 12:06:42 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > Martin,
> > > 
> > > On Tue, 29 Sep 2009, Martin Schwidefsky wrote:
> > > 
> > > > Greetings,
> > > > the two remainting patches of the nohz performance work I've been
> > > > doing. Both have been sent to the mailing lists before. Ingo had
> > > > a comment about patch #1, but no one but me seems to be interested
> > > > in patch #2. Neverless I would like to get both patches upstream.
> > > > I can create a branch for them on git390 but I feel that they should
> > > > go the path all the other nohz/time/clocksource patches went.
> > > 
> > > Sorry, that's my fault. I forgot them over the watchdog
> > > wreckage. Picking them up now.
> > 
> > I could not find the patches on tip timers/core. Where did you put them ?
> 
> these are the currently pending patches in tip:timers/core:
> 
> 3c5d92a: nohz: Introduce arch_needs_cpu
> eed3b9c: nohz: Reuse ktime in sub-functions of tick_check_idle.
> 7bc7d63: time: Remove xtime_cache
> a092ff0: time: Implement logarithmic time accumulation

Thanks for the list. Thomas added 3c5d92a and eed3b9c yesterday and
I am happy now. I have two more optimization patches for the clockevents
code, but I'm not don't quite content with them yet.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
