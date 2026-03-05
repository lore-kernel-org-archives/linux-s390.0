Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C3388395;
	Thu,  5 Mar 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712729; cv=none; b=fEblv12kwL1TzplmbIcvszE5DqmASffCUozK09ruvO/sp5ojSTYKcT0cNU8GN8V0UA3o7f4OUtbnd0zAddOpuM1ZJxEX3RDd0TNX5UKggR37sGFy01W0nI791eGKQJZ9JNB1JV9hA7Lc49IKv/G0ds1kOsACE0yceepZeykZmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712729; c=relaxed/simple;
	bh=jufTR+wsSv20xCKkueVYMUxTMcy8ryKGH9G3IwXceGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOEa/dJGCfw5MPIoMtoJEC79vErBj3sv9qeiaWfrJVTVEj50xKjbpp9/tfERQvSxcK92HCDHqaQw7Q/xjoLNKvZbjHg3i/u32JL8HSLzyglkl1g1EvLa0gtrd+9s0pLRIrn4ww6gi3tInwU3VO49eduitatbxhOfbG9CyxRdrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q8x9oOZ3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q8x9oOZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lPl0Ddg40RuxAiAaGnelXqkhyiYmrws2VQQjQXmIGHQ=; b=Q8x9oOZ3PfZTmdo8vLGOWFe8hM
	9basKySZSyta/CPhH6QmivwQFavc8E5+J+NNkopsGgbLYTO8tlhpGf1v5+5UfUgmpU55cn3VfJ5CZ
	Bn59+4ExVsMfH+tOmA93RxTxwIH1FAg64qw89pLa0PHIVpmKxN02RMtMlHPxd1URSagTypieew6fP
	nDX0S6M34kRCYs8Gtzq2doqxy/bB/ZgkNWPaA6ouJELInkXHXbncskx6X68ci5uUlZVEnj2+su7Cx
	rkJzAPDwFeBEgLzH2DvGKweI9zX8M/bl8vVZvkBLndhwe5tVUAb13a1BmSnfZbieYoKMgH5h2iL6S
	ae/yqILQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy7Yh-0000000ExN9-1ap9;
	Thu, 05 Mar 2026 12:12:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E031300CDE; Thu, 05 Mar 2026 13:12:01 +0100 (CET)
Date: Thu, 5 Mar 2026 13:12:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305121201.GB596554@noisy.programming.kicks-ass.net>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305074922.7170Ad3-hca@linux.ibm.com>

On Thu, Mar 05, 2026 at 08:49:22AM +0100, Heiko Carstens wrote:
> On Wed, Mar 04, 2026 at 05:13:56PM +0100, Mikhail Zaslonko wrote:
> > Sorry, forgot to Cc a few people.
> > Adding scheduler maintainers.
> > 
> > Thanks,
> > Mikhail Zaslonko
> > 
> > On 03-Mar-26 19:31, Mikhail Zaslonko wrote:
> > > Hello,
> > > 
> > > we have kernel-next boot hang on s390 starting next-20260302.
> > > 
> > > I bisected it in linux-next to:
> > > 
> > > c50f05bd3c4e ("Merge branch into tip/master: 'sched/hrtick'")
> > > 
> > > Good:
> > >   72a2ab46f045  
> > >   d50da4b5915f  (2nd parent: sched/hrtick branch)
> > > 
> > > Bad:
> > >   c50f05bd3c4e  (merge commit)
> > > 
> > > Environment:
> > >  - s390 under z/VM
> > >  - many CPUs defined (32+)
> > >  - boot hangs early with RCU stall (see boot log excerpt below)
> 
> linux-next is currently completely broken because of this.

Turns out, that aside from something weird with ACPI PCI routing, these
two patches:

https://lkml.kernel.org/r/87bjh4zies.ffs@tglx
https://lkml.kernel.org/r/87cy1jsa4m.ffs@tglx

Make tip/sched/core, which includes:

1b8b1bb2a2fa (tip/sched/core) Merge branch 'linus' into sched/core, to resolve conflicts
c1455a120f7e Merge branch 'sched/hrtick'

work reliably on my SPR. But since you don't have
CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT (yet) this should not affect you.

> Any idea?

Well, that all looks like timers are going missing. Which matches with
Sven saying that disabling HRTIMER_REARM_DEFERRED makes it go again.

I'm just not sure I can see why things would break between
sched/hrtick (GOOD) and 1b8b1bb2a2fa (BAD).

Looking at the diff (eg git diff d50da4b5915f..c50f05bd3c4e) show some
idle time changes to s390 and various kernel/ changes, but nothing that
stands out to me :/
