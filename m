Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9BE2DCBFA;
	Fri, 10 Apr 2026 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848642; cv=none; b=A7T/EsaqNH+nD7kwvt7fBIIYilZCr3FJcQgjeZVvJl9C/dimqKrsgDXRJLd1TGcNjMIDZIhZogPJzLFbJP6KQdjCgUHYZB93XXVvvYT9cK9GY0BYaEav/aqtiFRTsDAnjIKV7n3QGS7bluM0SsqGQVqmna6JJm0HqeQKK4bqYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848642; c=relaxed/simple;
	bh=+l4slRYBXMZdSlFbbXLnPYGyI1USLl2/bj456CIhqdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOE4FxEfeuxqeyRn5w4F6ajBwJTeV0tMizIJIu/W1enulc+wwL8FWYeAGXeR0q8pX0ddMq4Cb+ptZ+Qv3zoKMa9La0SJEzTTB2TaecVoZtQxKhoYuQUmnLsNBMDPw9M6SGsySUNUtrU5wbAv6FWiheVQ83Pza1yIp6ds4XHcZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i74RuxSk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i74RuxSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F299C19421;
	Fri, 10 Apr 2026 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775848642;
	bh=+l4slRYBXMZdSlFbbXLnPYGyI1USLl2/bj456CIhqdM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i74RuxSkDNDcysE+cRb6CUdohG1pNKqSCsxER4WfyDUhVO8N4po/ldYRyWb8zrpLn
	 rqrR3Y9NaVqnwj0b8yX6+bR8R4if+dyrqY3D3ayzTDjU+0Q8zr6aC0X4ajGo6exs2V
	 eFieXHmBMQ65R9Bae+GHRoBrCjjih6C4BiYSgeJhvriBogeeiCkIkEJvq2SqkFcZNz
	 OfGtuHSdKtrRH2PRwkDyH8W2Gx4KKTLXGg//czMmXNqqnfV1Qa0Ys3XQkNNqmgdTz1
	 GmuKxinVokY9hpq0OI+AGOY2F/GL8r5ClvP5UC7VkO6Kd5cYAwjRtuvyLcxbol/ebQ
	 4fcBqXBkpeIxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBBF2CE04B4; Fri, 10 Apr 2026 12:17:21 -0700 (PDT)
Date: Fri, 10 Apr 2026 12:17:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <25415176-d977-41c1-83d1-3f060292f636@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adlHKowvhn8AGXCc@slm.duckdns.org>

On Fri, Apr 10, 2026 at 08:53:30AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Apr 09, 2026 at 11:10:04AM -0700, Boqun Feng wrote:
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
> > 
> > ;-) ;-) ;-)
> > 
> > > probably need to do some of the hot unplug operation during init if the CPU
> > 
> > Seems that we (mostly Paul) have our own trick to track whether a CPU
> > has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> > used it in his fix [1]. And I think it won't be that hard to copy it
> > into workqueue and let queue_work_on() use it so that if the user queues
> > a work on a never-onlined CPU, it can detect it (with a warning?) and do
> > something?
> 
> The easiest way to do this is just creating the initial workers for all
> possible pools. Please see below. However, the downside is that it's going
> to create all workers for all possible cpus. This isn't a problem for
> anybody else but these IBM mainframes often come up with a lot of possible
> but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> be negligible on some configurations.
> 
> IBM folks, is that okay?

I have also seen x86 systems whose firmware claimed very large numbers
of CPUs.  :-(

> Also, why do you need to queue work items on an offline CPU? Do they
> actually have to be per-cpu? Can you get away with using an unbound
> workqueue?

It is good for them to run on the specified CPU in the common case for
cache-locality reasons, but if they were occasionally redirected to some
other CPU, that would be just fine.

I am also keeping the patch that avoids queueing work to CPUs that are not
yet fully online.  Further adjustments will be needed if someone invokes
call_srcu(), synchronize_srcu(), or synchronize_srcu_expedited() from an
CPU that is not yet fully online.  Past experience of course suggests that
this will be happen, and that there will be a good reason for it.  ;-)

							Thanx, Paul

> Thanks.
> 
> From: Tejun Heo <tj@kernel.org>
> Subject: workqueue: Create workers for all possible CPUs on init
> 
> Per-CPU worker pools are initialized for every possible CPU during early boot,
> but workqueue_init() only creates initial workers for online CPUs. On systems
> where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> set but no workers. Any work item queued on such a CPU hangs indefinitely.
> 
> This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> during size transitions, triggering workqueue lockup warnings for all
> never-onlined CPUs.
> 
> Create workers for all possible CPUs during init, not just online ones. For
> online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> execute on any CPU. When the CPU later comes online, rebind_workers() handles
> the transition to associated operation as usual.
> 
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/workqueue.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -8068,9 +8068,10 @@ void __init workqueue_init(void)
>  		for_each_bh_worker_pool(pool, cpu)
>  			BUG_ON(!create_worker(pool));
> 
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		for_each_cpu_worker_pool(pool, cpu) {
> -			pool->flags &= ~POOL_DISASSOCIATED;
> +			if (cpu_online(cpu))
> +				pool->flags &= ~POOL_DISASSOCIATED;
>  			BUG_ON(!create_worker(pool));
>  		}
>  	}
> -- 
> tejun
