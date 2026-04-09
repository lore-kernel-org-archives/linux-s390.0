Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEC1A682F;
	Thu,  9 Apr 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758188; cv=none; b=IwgPbIVoTsdvnZKIqjaLyD8MTHAWtdzjyqEDOdR3Or/fTfo2NFt8QWZJzOSrIfhJnzz1m0NhX0Z+3pOvfAeDA0fcUMl6Vo6MYD94DNiqs4mHswk9nJNb88dykQfVYKM/p8CVzS8j+J6z1aZMVSK3nWRYHSBs/7j1fnvEbWTInMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758188; c=relaxed/simple;
	bh=wxeCNoqSbEX9R8e51700D6SgtKoi9bLSOZzV58hSbU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqpCijNBaZbg95TNj0ayvVpKVs5FslUIazyJKJmEw0staBNZOqQ4z/WVDrCngb8pguk5/0cNA/CVnQToN2ulzaxU0pzOWRYVkJ4apBQOngpOckr6+rNGoKv8CyiaQOjwpBCiUoZa2Xu2pNmXD/qv3AqnJkVIGkFpW3beDqz4n38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYT3jT1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYT3jT1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F42C4CEF7;
	Thu,  9 Apr 2026 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775758187;
	bh=wxeCNoqSbEX9R8e51700D6SgtKoi9bLSOZzV58hSbU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYT3jT1c2VZVf8KS/YTh0COZy6uiBRcsW2IzSBk+W2Xk+0u1AHMBuXtocLLYgSCLe
	 VX0tpSIlQnxjUTGsUtSPXyxvsaWaR39tz+0iL0Lc+RsmKQf05wjBm0iGe83k+99Etk
	 VFtZlyhRGiHMl+O05mA1a7bfnYeE1kVDdbNXLayJdgOm3PBwhxb8clq9Zw9JGUMhQi
	 Z9o+41yGwauJPKFXpM82emcGmvhjV2fSdC1wSdy4y3i2kMEH/AkAFwxxPa6y8S3EiJ
	 apUEjjr3erOaLn2EO5D1ecw8Ws1bVTPSZdk+6OSTvN9s7m+TwCpDnnQohBN4jUMnKm
	 jSHTi5ZXO+QaA==
Date: Thu, 9 Apr 2026 08:09:46 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <adfraiVgNw4fvz81@slm.duckdns.org>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfmbO1nxSwHvtHx@slm.duckdns.org>
 <3e18247d-ef19-4963-8257-a0f4494f992a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e18247d-ef19-4963-8257-a0f4494f992a@paulmck-laptop>

On Thu, Apr 09, 2026 at 11:04:09AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 09, 2026 at 07:48:28AM -1000, Tejun Heo wrote:
> > On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> > > On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > > > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > > > 
> > > > > [Cc workqueue]
> > > > > 
> > > > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > > > unbound one hence there are still workers?
> > > > > 
> > > > 
> > > > Ah, as Paul replied in another email, the problem was because these CPUs
> > > > had never been onlined, so they don't even have unbound workers?
> > > 
> > > Hahaha, we do initialize worker pool for every possible CPU but the
> > > transition to unbound operation happens in the hot unplug callback. We
> > > probably need to do some of the hot unplug operation during init if the CPU
> > > is possible but not online. That said, what kind of machine is it? Is the
> > > firmware just reporting bogus possible mask? How come the CPUs weren't
> > > online during boot?
> > 
> > Just saw ibm on the cc list. Guess this was on s390?
> 
> It was indeed.  What workqueue tricks does s390 play?

They just come up with genuinely possible but offline CPUs. Most setups
don't do that. I'll spin up a patch later today.

Thanks.

-- 
tejun
