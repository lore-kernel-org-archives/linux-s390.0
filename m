Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152C33D6C0;
	Tue,  3 Mar 2026 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538772; cv=none; b=sWLghIP6wCqIM6jNZGQbxJ2J1PkcRiWkFgVzeMdWOwvA679AnQRWax4KkPIZz/8OEsmD3p+JOUOpkhAP88dpA85vgkg5HWQnwFEoFl8xguQxHaYud2gZd9nVuyC1dIMTzdoghA/Sipy7YrkLiSNIcQKfUMyeyP+9PuUoOk8zgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538772; c=relaxed/simple;
	bh=lcgTS2m2iU2ZAvrZnBqU67dddTQdTulDja31I7aenTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0kvouKmbBvUIncyd9+gCjlt057pLHK0EaG8XvYAJGDdkT5fk1gS8GOfM2bPzD3kChqHyf0WzFY+6mVI17mSYfp2OUBjr0IYwovVM8yYtcVOF8zl0YH+Vy8s6/5Jjv4VICNzE3gUgHDwAfyc1EyPYT4RFu6rDTp0lI2+bTMIYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b366hglw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b366hglw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zlTdin2Y9sQiBK/gva0P7x3HPfeE/8T5PcT2B2s7izs=; b=b366hglwD8p9ia18dBn5KRUvGF
	O6/C0m8amE/bY1rzRU5+kpmbMMluQHE+YHXfqwSIAHu1U+WV7iyFwMHVHy3PCBDa1XjbrGdnXKABb
	xTNMGkwvn+hfkTihV7F8SrqbDgPvYOrM+PCVtwpCLDp0jpNgzVhas456yHTABU9xk49+jGHHY5oK8
	iAza+C8UpvbV9ySnWG7VbDr7xGrGLIabVCpaJodEqEb9rpvdtmQHFdcWClJx1KQsxeoDmXMCsPRRj
	c3DafdmsbFmwRaDofFWjLgkrfxri/l14gokDYQ8SMGogw76DCuX0LL3/v/GB2vF49I0QBotYmnSYJ
	c1DVK2/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxOIr-00000002Ixn-3V3Q;
	Tue, 03 Mar 2026 11:52:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8AA9300FB6; Tue, 03 Mar 2026 12:52:35 +0100 (CET)
Date: Tue, 3 Mar 2026 12:52:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260303115235.GQ1282955@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
 <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
 <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
 <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>

On Tue, Mar 03, 2026 at 09:15:55AM +0000, Ciunas Bennett wrote:
> A quick update on the issue.
> Introducing kvm_arch_set_irq_inatomic() appears to make the problem go away on my setup.
> That said, this still begs the question: why does irqfd_wakeup behave differently (or poorly) in this scenario compared to the in-atomic IRQ injection path?
> Is there a known interaction with workqueues, contexts, or locking that would explain the divergence here?
> 
> Observations:
> irqfd_wakeup: triggers the problematic behaviour.
> Forcing in-atomic IRQ injection (kvm_arch_set_irq_inatomic): issue not observed.
> 
> @Peter Zijlstra — Peter, do you have thoughts on how the workqueue scheduling context here could differ enough to cause this regression?
> Any pointers on what to trace specifically in irqfd_wakeup and the work item path would be appreciated.

So the thing that LAZY does different from FULL is that it delays
preemption a bit.

This has two ramifications:

1) some ping-pong workloads will turn into block+wakeup, adding
overhead.

 FULL: running your task A, an interrupt would come in, wake task B and
 set Need Resched and the interrupt return path calls schedule() and
 you're task B. B does its thing, 'wakes' A and blocks.

 LAZY: running your task A, an interrupt would come in, wake task B (no
 NR set), you continue running A, A blocks for it needs something of B,
 now you schedule() [*] B runs, does its thing, does an actual wakeup of
 A and blocks.

The distinct difference here is that LAZY does a block of A and
consequently B has to do a full wakeup of A, whereas FULL doesn't do a
block of A, and hence the wakeup of A is NOP as well.


2) Since the schedule() is delayed, it might happen that by the time it
does get around to it, your task B is no longer the most eligible
option.

Same as above, except now, C is also woken, and the schedule marked with
[*] picks C, this then results in a detour, delaying things further.


