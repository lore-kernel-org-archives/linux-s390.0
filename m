Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F032877F4;
	Fri, 10 Apr 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847212; cv=none; b=qWB1ciCCw/83bIJDkzz2UHhBBqJgOxqfvyM5U4bBBYwJWwr49bKW4LuQrMnel3KNhHlbP7XmVE7Z+Uw1bCR8BPMEf2KmrM5j3CYNLp/yibhpt33EELuUvNwUYU/e0VZUD/5ocJQgtmgIowLlNTfoPGb+pHKkzphGb8Ia4OG9USE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847212; c=relaxed/simple;
	bh=Kd6ksWdlUmRQPwhRR+pEgC2i0CqfiHJQyJdYiy/b/5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjmQoWTuINqc559HWatfKvH2nvF1uzMBIoBXfwIVZizlslpPQb6Bz8tKqj7vGGXXcqbD4Cgl0aD7jk8ztMHiN7OChuiSU7BBO1m3+esrFiSkJaPoyRD5feO7uaiQaKS6SLZiXjWy+TnEzFslOGKLD9poOeAseAugchV18+KyFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atslMX08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atslMX08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664F7C19421;
	Fri, 10 Apr 2026 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775847211;
	bh=Kd6ksWdlUmRQPwhRR+pEgC2i0CqfiHJQyJdYiy/b/5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atslMX08++6bs55u18fQJVL933vgZWsxO+KQqD/mjpQCBLwKyQi3TGTdZlLEF8dNj
	 0DXtmfRa+eLHYSWW8LBoOEhDfusuW4CM1n5AWL6h7CvjuOH0Nwo4TKCigpWq6mw8mh
	 JWrNaPZFErdINNJMhse8zMowCuxwf5rZjxFI7TGoRpKh+O3OFFhUgr/EaQHlgwJLZE
	 XfSbWGWssUu3PKbUlB06nq3qBsit2c3KQSJfDmF9dfTfQHuYpG5ppBoBij6hj0j84W
	 UP5/bVJFpL91ksPSiJgMmJaJii+McT3uaMH8DhfWAQMNEbBlb4IhDrkFGiUn1lCfq+
	 WeVbMj3m1uLVQ==
Date: Fri, 10 Apr 2026 08:53:30 -1000
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
Message-ID: <adlHKowvhn8AGXCc@slm.duckdns.org>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfrfJGrglg0bGw_@tardis.local>

Hello,

On Thu, Apr 09, 2026 at 11:10:04AM -0700, Boqun Feng wrote:
> On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> > On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > > 
> > > > [Cc workqueue]
> > > > 
> > > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > > unbound one hence there are still workers?
> > > > 
> > > 
> > > Ah, as Paul replied in another email, the problem was because these CPUs
> > > had never been onlined, so they don't even have unbound workers?
> > 
> > Hahaha, we do initialize worker pool for every possible CPU but the
> > transition to unbound operation happens in the hot unplug callback. We
> 
> ;-) ;-) ;-)
> 
> > probably need to do some of the hot unplug operation during init if the CPU
> 
> Seems that we (mostly Paul) have our own trick to track whether a CPU
> has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> used it in his fix [1]. And I think it won't be that hard to copy it
> into workqueue and let queue_work_on() use it so that if the user queues
> a work on a never-onlined CPU, it can detect it (with a warning?) and do
> something?

The easiest way to do this is just creating the initial workers for all
possible pools. Please see below. However, the downside is that it's going
to create all workers for all possible cpus. This isn't a problem for
anybody else but these IBM mainframes often come up with a lot of possible
but not-yet-or-ever-online CPUs for capacity management, so the cost may not
be negligible on some configurations.

IBM folks, is that okay?

Also, why do you need to queue work items on an offline CPU? Do they
actually have to be per-cpu? Can you get away with using an unbound
workqueue?

Thanks.

From: Tejun Heo <tj@kernel.org>
Subject: workqueue: Create workers for all possible CPUs on init

Per-CPU worker pools are initialized for every possible CPU during early boot,
but workqueue_init() only creates initial workers for online CPUs. On systems
where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
set but no workers. Any work item queued on such a CPU hangs indefinitely.

This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
non-preemptible") which made SRCU schedule callbacks on all possible CPUs
during size transitions, triggering workqueue lockup warnings for all
never-onlined CPUs.

Create workers for all possible CPUs during init, not just online ones. For
online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
execute on any CPU. When the CPU later comes online, rebind_workers() handles
the transition to associated operation as usual.

Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/workqueue.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8068,9 +8068,10 @@ void __init workqueue_init(void)
 		for_each_bh_worker_pool(pool, cpu)
 			BUG_ON(!create_worker(pool));

-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
-			pool->flags &= ~POOL_DISASSOCIATED;
+			if (cpu_online(cpu))
+				pool->flags &= ~POOL_DISASSOCIATED;
 			BUG_ON(!create_worker(pool));
 		}
 	}
-- 
tejun
