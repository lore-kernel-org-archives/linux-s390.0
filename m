Return-Path: <linux-kernel-owner+w=401wt.eu-S1755253AbZKFIlp@vger.kernel.org>
Date: Fri, 6 Nov 2009 09:41:38 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/2] nohz tweaking
Message-ID: <20091106084138.GB22505@elte.hu>
References: <20090929122514.693636761@de.ibm.com> <alpine.LFD.2.00.0909301204460.2756@nanos> <20091104144052.0b4e99e1@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091104144052.0b4e99e1@mschwide.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Moin Thomas,
> 
> On Wed, 30 Sep 2009 12:06:42 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Martin,
> > 
> > On Tue, 29 Sep 2009, Martin Schwidefsky wrote:
> > 
> > > Greetings,
> > > the two remainting patches of the nohz performance work I've been
> > > doing. Both have been sent to the mailing lists before. Ingo had
> > > a comment about patch #1, but no one but me seems to be interested
> > > in patch #2. Neverless I would like to get both patches upstream.
> > > I can create a branch for them on git390 but I feel that they should
> > > go the path all the other nohz/time/clocksource patches went.
> > 
> > Sorry, that's my fault. I forgot them over the watchdog
> > wreckage. Picking them up now.
> 
> I could not find the patches on tip timers/core. Where did you put them ?

these are the currently pending patches in tip:timers/core:

3c5d92a: nohz: Introduce arch_needs_cpu
eed3b9c: nohz: Reuse ktime in sub-functions of tick_check_idle.
7bc7d63: time: Remove xtime_cache
a092ff0: time: Implement logarithmic time accumulation

	Ingo
