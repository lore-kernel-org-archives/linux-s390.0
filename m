Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F22DC767;
	Thu, 11 Jun 2026 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176109; cv=none; b=P9PxeUKdvT4sxpRl+L9/Ij/AWue5Ycdo+NztkP3DhhcPkwpPKgfgG0DwElzysijO5yfKJoKtS0Vkq42hCiLcMB9SEk51cUr7Gdc9dEAnDu/2p3zv99XrfZS3nvjg1uySHtwOnHgha/9H9JlwXfheOBtR3KCpScbf9x/XCBR5Usw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176109; c=relaxed/simple;
	bh=wQ3WHe+W2v0d92Kplq8+Hn6T8icPXVzVqEyoe1yv1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIvlWHCpxY4dYSAnJESb3g7+yytB6JZDk4KCfsK1XvvegFP9TUfjlmcN645QK1ZIQfyhiS9ahhzvu7xHxrN4iqqVy1xvovOeTswi3OXjsEYdLK65sHimaGXeI0l4rPgdjKfboPmtO08PEeuqxGhBun6UA5N1zenGfzskp+o9aTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rmSxXHVh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rmSxXHVh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Be5rEciqOgJ7a/QFo0//CIZoBQIfhUkSPXRNBFzrHCc=; b=rmSxXHVhxwjZG6eIJJik0ch6ti
	5Hi6iyJuoT91JesXShCkA+1JQpjZV8FqbTODL8bD798uiBrUiHP6+OvPjUFtbrwhkDSt1xe6TMkX/
	+ZZNJxZaCvZiltASsZUnftEE3I7VEPE07tGQslh/9ZmHlsrc3JY33YNPavi5tUMZZH068JdtX/pNq
	hb0Z97N+MR5hvFTHdhsesPCu1s9Q6G9wDbTjACHPsKUHThqUDTX83U6agSE/Abs23vanIRg9G+GZQ
	XAFtWRJJ65zV6H7jasCZrC+WVPZUCBuF7xlRzDvYmvRRPZzGk2gCy2o9oOfjx880JgdyTfi0mskBV
	4W+jIVJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXdGc-00000001mBP-2jhl;
	Thu, 11 Jun 2026 11:08:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2490301A42; Thu, 11 Jun 2026 13:08:09 +0200 (CEST)
Date: Thu, 11 Jun 2026 13:08:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	John Stultz <jstultz@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Aaron Lu <ziqianlu@bytedance.com>
Subject: Re: linux-next crashes in scheduler on s390
Message-ID: <20260611110809.GF187714@noisy.programming.kicks-ass.net>
References: <17e75ff4-cf90-4772-9965-92a7235ca806-agordeev@linux.ibm.com>
 <yt9dmrx2wns1.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dmrx2wns1.fsf@linux.ibm.com>

On Wed, Jun 10, 2026 at 03:03:26PM +0200, Sven Schnelle wrote:
> Alexander Gordeev <agordeev@linux.ibm.com> writes:
> 
> > Hi All,
> >
> > Since about June 1st we're getting strace test suite (make -j$(nproc) check)
> > crashes on s390 in linux-next. Those are pretty easy to reproduce, but I
> > have not been able to nail it down to the particular commit/merge.
> >
> > I am going to bisect it, but since we are approaching v7.1 release, any
> > hint would be greatly appreciated!
> > [..]
> 
> I bisected it to
> https://lore.kernel.org/all/20260511120627.944705718@infradead.org/
> ("[PATCH v2 08/10] sched/fair: Add newidle balance to pick_task_fair()")
> 
> Adding the patch proposed in
> https://lore.kernel.org/all/20260603095108.GA1684319@bytedance.com/
> fixes the issue for me.
> 
> To reproduce, running the strace test suite seems enough. If required, I
> can try to figure out the exact test that crashes the kernel.

Oh sorry for the borkage and thanks for the pointer -- I clearly missed
that :-(.

I've just been staring at all this and while I think I prefer a slightly
different solution, I think I'm going to just apply that patch since its
fairly trivial and you've confirmed it works. And then I can go do the
alternative for the next cycle -- and hopefully not wreck it again :-).

