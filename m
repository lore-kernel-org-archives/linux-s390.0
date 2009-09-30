Return-Path: <linux-kernel-owner+w=401wt.eu-S1754222AbZI3Lhv@vger.kernel.org>
Date: Wed, 30 Sep 2009 13:37:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/2] nohz tweaking
Message-ID: <20090930133751.30633106@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <alpine.LFD.2.00.0909301204460.2756@nanos>
References: <20090929122514.693636761@de.ibm.com>
	<alpine.LFD.2.00.0909301204460.2756@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Sep 2009 12:06:42 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Martin,
> 
> On Tue, 29 Sep 2009, Martin Schwidefsky wrote:
> 
> > Greetings,
> > the two remainting patches of the nohz performance work I've been
> > doing. Both have been sent to the mailing lists before. Ingo had
> > a comment about patch #1, but no one but me seems to be interested
> > in patch #2. Neverless I would like to get both patches upstream.
> > I can create a branch for them on git390 but I feel that they should
> > go the path all the other nohz/time/clocksource patches went.
> 
> Sorry, that's my fault. I forgot them over the watchdog
> wreckage. Picking them up now.

Thats great, thanks. And yes the clocksource/watchdog problems have
been painful..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
