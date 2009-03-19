Return-Path: <linux-kernel-owner+w=401wt.eu-S1760109AbZCSRuw@vger.kernel.org>
Subject: Re: PROBLEM: relay - stale data copied to user space
From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
In-Reply-To: <1237436347.7834.13.camel@charm-linux>
References: <1237388848.4084.64.camel@kitka.ibm.com>
	 <1237436347.7834.13.camel@charm-linux>
Content-Type: text/plain
Date: Thu, 19 Mar 2009 18:50:40 +0100
Message-Id: <1237485040.4752.16.camel@kitka.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tom Zanussi <tzanussi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On Wed, 2009-03-18 at 23:19 -0500, Tom Zanussi wrote:
> On Wed, 2009-03-18 at 16:07 +0100, Martin Peschke wrote
> > This is my theory:
> > Timing matters. It's a race caused by improper protection of critical
> > sections in a producer-consumer scenario. A bug in the bookkeeping
> > allows a reader to read at a position that is just being written to.
> > 
> 
> It does look consistent with a reader reading an event that's been
> reserved but not yet written, or partially written e.g. if an event
> being written on one cpu was read by another before the first one
> finished.

So this is part of relay's design, and it's up to user space to make
sure that reader and writer are on the same CPU?

> Can you see if the below patch to blktrace userspace helps?

It appears to fix it. I will give it more testing in a larger
environment.

> Or failing that, explicitly using gettid() in place of getpid() in
> sched_setaffinity().  Or, failing that, you had mentioned previously
> that you would try to reproduce the problem on your laptop - were you
> able to do that?  If so, it would help in debugging it further...

This didn't work out. But then, it's a single-CPU machine.

Thanks,
Martin
