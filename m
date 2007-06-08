Return-Path: <linux-kernel-owner+w=401wt.eu-S970421AbXFHRvo@vger.kernel.org>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <466993CF.4050804@de.ibm.com>
References: <1181165656.7133.23.camel@dix> <1181202258.7348.217.camel@twins>
	 <46698B1D.3000806@de.ibm.com> <1181322460.5728.2.camel@lappy>
	 <46698F7F.4090407@de.ibm.com> <1181323622.5728.6.camel@lappy>
	 <466993CF.4050804@de.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 19:50:30 +0200
Message-Id: <1181325030.5728.14.camel@lappy>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-06-08 at 19:37 +0200, Martin Peschke wrote:
> Peter Zijlstra wrote:
> > On Fri, 2007-06-08 at 19:18 +0200, Martin Peschke wrote:
> >> Peter Zijlstra wrote:
> >>> On Fri, 2007-06-08 at 19:00 +0200, Martin Peschke wrote:
> >>>> Peter Zijlstra wrote:
> >>>>> I'm confused as to where the class->stat objects are initialised? Is
> >>>>> that done in lock_stat_init()? If so, then you have a bug.
> >>>> static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
> >>>>
> >>>> I assume this gets us class structures containing all zeros, doesn't it?
> >>>> Then class->stat is zeros as well, which is handled by lib/statistics.
> >>>> (In this case, data gathering hasn't been turned on yet, and statistic_inc()
> >>>> and similar functions don't access other areas of struct statistic.)
> >>> Who eventually calls percpu_alloc?
> >> There is a small state machine calling percpu_alloc when users do
> >>
> >>     echo state=on > /debug/statistics/lockdep/definition
> >>
> >> So data gathering is off by default.
> >>
> >> It might make sense to allow "state=on" as a default. Then allocation would
> >> be done in the context of statistic_attach().
> > 
> > Right, the problem here is that you iterate over all_lock_classes once
> > at init.
> > 
> > Contrary to what the name might suggest, it are not all possible
> > classes, just all active ones. So you'll only attach the classes which
> > have been used up until the init point. All other classes used later
> > will never be initialized.
> 
> Ah..
> 
> Do you know where a class is setup for first use?

Somewhere down the line of lock_acquire()->register_lock_class().
It is then stuck onto the all_lock_classes list in mark_lock(). However
this would be a very bad place to run init code, since percpu_alloc()
can schedule and we're in the middle of a locking primitive :-)

> I guess it is feasible to move statistic initialisation to that place.
> 
> Is there a place where a class becomes unused again?

Yes, it is possible to clear the task list, however that part of lockdep
is a tag fragile - look for the call-chain leading to zap_class().
