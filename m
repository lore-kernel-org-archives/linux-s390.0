Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF68BE9;
	Thu,  9 Apr 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756910; cv=none; b=VyZyTtwzlPe3jpZTWgueFq0FSPo7mcn90R9hDMwPEq/BjMTAyX4zTHVFDxBuOH6RaB21ODjcXfLqiQQuhdf75juNrWJhuge7wyb1Ni/DdZ/UHckJHVXB3zjZAOMM7BDc2IrQJRMCcEFmRNmb+PvaNlpPTwhXqPnzdAvVK5vl4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756910; c=relaxed/simple;
	bh=vGoZFaoGRrLXYCDtADIljyfIPyV0RnZ8OE8aB0pA8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCoP7fY+JMqfW0xqAObDDSeteQyhGoS+u708bxsbY5v2BfJVwWVnyx1NAdrUa7wNcj/6Ge05GIu15PSpjEt7N4U1m5Hfq/Ifzjuy5g+v414+uBlNUus+MES3SA424w21wDR8E7Q3/ZYVSu+i3RFMt6wAznvrPhi6S+v4PxjwdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1zGiEmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1zGiEmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC2BC116C6;
	Thu,  9 Apr 2026 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775756909;
	bh=vGoZFaoGRrLXYCDtADIljyfIPyV0RnZ8OE8aB0pA8+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1zGiEmMhBqSiH+60bVKbbkQUqX4Gp0pX6jSnyWhQp+9ovAQjIxeXozANmChclyA1
	 5Wgn9SFxYOaUDF05H0SDQXFtvLIE1t/Wv82V0J9UaUzkoW7gmkqSQbXeWhYWrXvdeW
	 ES2lO/TJkvgD1SqWzMWWu1ff3zDmOSNTD9x9pbAMKvvJemDfNP7Y8PYjrwxOQmFmaV
	 uBbhosv85ClBs6ND1+lHDPFAks5DOdwqvQZOC3358TOPjvD/5Iqg8cxRXCry7yva4u
	 kC2tDuSuIHIUBUcJcyvc3KeMSzHWPw+dPYYEWdxjvswc75uzH1z1s0W9S35T0wGzBc
	 bwkaqVPjxHSjg==
Date: Thu, 9 Apr 2026 07:48:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <adfmbO1nxSwHvtHx@slm.duckdns.org>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfmHZfABu64Kv4D@slm.duckdns.org>

On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > 
> > > [Cc workqueue]
> > > 
> > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > unbound one hence there are still workers?
> > > 
> > 
> > Ah, as Paul replied in another email, the problem was because these CPUs
> > had never been onlined, so they don't even have unbound workers?
> 
> Hahaha, we do initialize worker pool for every possible CPU but the
> transition to unbound operation happens in the hot unplug callback. We
> probably need to do some of the hot unplug operation during init if the CPU
> is possible but not online. That said, what kind of machine is it? Is the
> firmware just reporting bogus possible mask? How come the CPUs weren't
> online during boot?

Just saw ibm on the cc list. Guess this was on s390?

-- 
tejun
