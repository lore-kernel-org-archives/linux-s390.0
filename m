Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D63909B4;
	Thu,  5 Mar 2026 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716051; cv=none; b=NYUGO/00I6auFbdaJyko8nC+0iJf9Ib8FOTOmh8rMWND6chld1ZHyxsb/wWTqpNqAcWoecnInyUwHv/BKukepCF7l3MgdEZX8F5HwhLuFlfwaT/D7HoYBP1Dsqoe1bKhFKOTt4xmvjpda1fJGFm4C3amWMFDGAkK7AeqeC6AITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716051; c=relaxed/simple;
	bh=r8tqbKy12I/WyVkqeZ4wboYJQhTagujmoj6loZq1318=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHjJftfHJ0+JwlfIZsW4kPJJOPqLiC10u8i/IOKFoZSNLXLZnWPZugbIFjTXqEWGaBqmwOlOf1TJIaIrD3/iEG5sFPFT3F7fx4H7mDQz2jBfUpjAzNmmAYieuL4/SMZWWJKa9qQfJuJ0O8as27hqkzjhFSJXjWQ09kh1jukU47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qCseaZ/J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qCseaZ/J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fusjg1dA45UTjdR15R0G/H/d9dukZeIFpl8KH+dV+uU=; b=qCseaZ/JIEeFa7WnzUvPuheik8
	XSGHoy5ziIngjXwaApW0CfmYr+cCpXz/NgVA/lgp0SfusxzSq17Q7tA2cNC6E9DFW2B7muWYu6UAb
	XW49kIeQlWBb8Lc4w+jeb1abzDdDkgmbUuzqMPByueDol5ahlHLRtEYn3LMkeIgwAMKKmxAv2KGBH
	vzJc6oflMKD/U3Z98qFDxUqQmtMGWJ3eKCNdcdVzCh8pjA14fHX2gWUIQv3+DfMzsWMV9pb3mttLd
	MuG0L9AEwWooDS6RvodXKzFXkziV5AyOw9q1iT/y43LRH2Kp/oSNFtAQ+/fhRl1TMHsino482tTzR
	60+mScOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy8QI-0000000F1i3-3O4q;
	Thu, 05 Mar 2026 13:07:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2226300CDE; Thu, 05 Mar 2026 14:07:25 +0100 (CET)
Date: Thu, 5 Mar 2026 14:07:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305130725.GB652779@noisy.programming.kicks-ass.net>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
 <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
 <20260305124501.GB1395416@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305124501.GB1395416@noisy.programming.kicks-ass.net>

On Thu, Mar 05, 2026 at 01:45:01PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 05, 2026 at 01:35:05PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 05, 2026 at 01:12:01PM +0100, Peter Zijlstra wrote:
> > 
> > > > Any idea?
> > > 
> > > Well, that all looks like timers are going missing. Which matches with
> > > Sven saying that disabling HRTIMER_REARM_DEFERRED makes it go again.
> > > 
> > > I'm just not sure I can see why things would break between
> > > sched/hrtick (GOOD) and 1b8b1bb2a2fa (BAD).
> > > 
> > > Looking at the diff (eg git diff d50da4b5915f..c50f05bd3c4e) show some
> > > idle time changes to s390 and various kernel/ changes, but nothing that
> > > stands out to me :/
> > 
> > That s390 idle time code..
> > 
> >   0d785e2c324c ("s390/idle: Fix cpu idle exit cpu time accounting")
> > 
> > That moves this_cpu_add() from inside irq_enter_rcu() / irq_exit_rcu()
> > to outside of it.
> > 
> > Your this_cpu_add() as preempt_enable(), which does a preemption check.
> > 
> > Moving that before irq_enter_rcu() means it doesn't see HARDIRQ_OFFSET
> > in preempt_count(). As such, it might actually call into schedule() from
> > hardirq context.
> > 
> > Or am I missing something?
> 
> N/m, it turns into __this_cpu_add() and that doesn't have
> preempt_enable().
> 
> 00d8b035eb71 ("s390/idle: Slightly optimize idle time accounting")
> 
> Is actually a correctness fix afaict.

Another change is that you clear I and E in the PSW bit before
irq_enter_rcu(), which, per:

  7e641e52cf5f ("softirq: Prepare for deferred hrtimer rearming")

can re-arm the timer.

So where previously it would re-arm and still have the I/E bits set, so
the timer could fire, they are now disabled.

I really don't know if this is a problem; I'm clutching at s390 straws
here that I really don't know much about.
