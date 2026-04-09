Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108730171C;
	Thu,  9 Apr 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756831; cv=none; b=JqxM0NlYRGxAOtwO+g42vbR75yGitjjySc/wreQGaQHi3mhQSbeG6XWy3IR8f78fsseKEZHjF956ke1IX3xMCi2q948Y11D6B27F9HPMYgiLUkqyi41S+p0Yfi105BZQlK8/vwW5ECizC/afOafHxf/m1ilOHsoOVsTp2ntC2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756831; c=relaxed/simple;
	bh=P5rbBQ0kC5XI0Q6RmCLv8X0KF/am3xddCY9EgKat5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlY4S48nyySLkJ2YsOCwYtLV9xwK0gfQM+YkN+NY8OF2NRPHbbT3ZHZIdDlJppPqyvcKGAfYHMMTekhC9b6Tk0CODkzrI5Vu4TrF1kzndr1L5n81tQXBEt4XDWIhadZIwrK/64XVo8K2eFkMxRbz753CrsfTHa7nA+hpTrndo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdnPShNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdnPShNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F89C4CEF7;
	Thu,  9 Apr 2026 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775756831;
	bh=P5rbBQ0kC5XI0Q6RmCLv8X0KF/am3xddCY9EgKat5n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdnPShNS7IHxl/f1hW/qYp11N7UroYNBtTBP9lUdJhRW9UGXCEnRA0mK1f+zfVdni
	 1+jolNNbhAV1lUY1FJEz36pkmV4H6KbvB9ZM/bzUocy+pJs6Motx9BWWU/5L30HIOc
	 ythS8d4wWiKq+xtJ/FnM4568j+G0I9M3/cHJZyJTFFIWLq52vHc4C2Qm6zEtQSCwpB
	 35FVOHnpgTWUyRAKqDYjF4SMFixE14agGp6ihwchg8TBGBhpqUCHehrWeuultyfgEN
	 gcjpSV1QP+hejbg8inWWp+isLfRd06l/ietuFSH4GSwfy4B8fsHkiubydDLYnP7vFZ
	 Mu0z21WvYjCFA==
Date: Thu, 9 Apr 2026 07:47:09 -1000
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
Message-ID: <adfmHZfABu64Kv4D@slm.duckdns.org>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfkdRCxmhpRverB@tardis.local>

On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > non-preemptible") defers srcu_node tree allocation when called under
> > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > 
> > [Cc workqueue]
> > 
> > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > unbound one hence there are still workers?
> > 
> 
> Ah, as Paul replied in another email, the problem was because these CPUs
> had never been onlined, so they don't even have unbound workers?

Hahaha, we do initialize worker pool for every possible CPU but the
transition to unbound operation happens in the hot unplug callback. We
probably need to do some of the hot unplug operation during init if the CPU
is possible but not online. That said, what kind of machine is it? Is the
firmware just reporting bogus possible mask? How come the CPUs weren't
online during boot?

Thanks.

-- 
tejun
