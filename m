Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC42472A6;
	Thu,  9 Apr 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759244; cv=none; b=H73Axv9NeSiuI+MhoTH1ppvWG1Jr0kgHjiqpfP+EeINvPDhpRnaoXTIPUD3H4Khcb7YbIb7XgL8E1jx2SRjYAwuM9aiVgaAcjf0CfL76y58TbOMIYcWjidCMbRAWRLIz79gsbE4jLrPotKuLs8SxzSxXiDowxNIpThL1TEl1UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759244; c=relaxed/simple;
	bh=q1dsgCRT/qzI4qDyl9z2gXVFEjDbUd69CCsY7/0NAGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLfyxL/dveGdPSKZgHrxlWjIgIyxlzvLR24g9ReS5J8+IBgpWVxgdsnZp+KOBwjvajpKUfWzCqjcwSwlIZ9rNKmsssRzdeRTjQ6+PtGk5Cs4qqfAboe9N7B4J6JicWVTB+wdlwVtAyEIv1y9wfgIMrCoHzKFz/bVIjaMulyX0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4D8AzZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4D8AzZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ACCC4CEF7;
	Thu,  9 Apr 2026 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759243;
	bh=q1dsgCRT/qzI4qDyl9z2gXVFEjDbUd69CCsY7/0NAGM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u4D8AzZVtdMSJSY3DHM0UHEopkz3umIE8I3rYWonrUyalMVs4trNeoWrpMJhfyz3f
	 6tb+f5eMwYrTZeyYmA9pKdUT7UmxOEJzSqajYNE/g/8XH6vmFrA+giwYkH5ZWltDQn
	 ruZ9AQeqUMENrJ/KDBkjeZJnlxz8AdP8MBmUBQDZVm9Ay+2vl5QdyFUKzQjYDngul4
	 jGa4l1AKMGcpOyFuJ9C4dJrQsIV4NNVfC6cHye4C9VzESI46DRAkXFAFsX1ZoqEpih
	 yQfjp7K1ht2vXTzZcoAJpEB2tGYs1ubC9dWrXE4rNY3VgQ0l8yBNOzvXA/CRmdIAjx
	 UO4aL6Q+MoShg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 375FFCE0975; Thu,  9 Apr 2026 11:27:23 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:27:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <f16e63c7-e185-4250-90b7-47533ca2d149@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> 
> [1]: https://lore.kernel.org/rcu/073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop/

It might be that my patch (or something like it) will be required in
addition to Tejun's fix because the current Tree SRCU code is happy
to schedule a workqueue handler on a CPU that does not even have a bit
set in the cpu_possible_mask.  This could happen on a system with the
first 50 CPUs, as in 0-49, in cpu_possible_mask.  Tree SRCU would then
be quite happy to schedule workqueue handlers on the mythical CPUs 50-63.
Which, now that I think on it, does seem a bit more brave than absolutely
warranted.  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > is possible but not online. That said, what kind of machine is it? Is the
> > firmware just reporting bogus possible mask? How come the CPUs weren't
> > online during boot?
> > 
> > Thanks.
> > 
> > -- 
> > tejun
