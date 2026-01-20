Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858340F8EB;
	Tue, 20 Jan 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919316; cv=none; b=ZtmkEAJW4NtVOcI1h+epmFa2h2YWuBBOlhBaYyRMwm+7DR6cLWuyD6lChrv+qFX8D4cyWThlrJfBmmTt3z/Dkpj0JwC8zac/ypMRvX5g87DnjAeTRZlyqg5OT9rAZH5LlMmXQpRNcHv73QIWHFfZ+K6kauCfmelhBsVIPexLk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919316; c=relaxed/simple;
	bh=OtwTnDpvDtbMBHvqPMZewcBZYEUS5NfRqaxfbB7joZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFXPBJLakzOgP1HbIGXK/w7Lgt/ATMl7FU6awjkCW4wHhl2OTasYh8kWt/0kaQE1CFYrcSUYXBy16fIqDQ6EeaBsYXcGBp2ezmYsGQA7qFOGzkAn9RcqY1hlPy8/A+JFWXFRk+Q7xxru3iEAXPeQf1YMAxRLGxfAjx67E4+HGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn4JA8d1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn4JA8d1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304CC19423;
	Tue, 20 Jan 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919316;
	bh=OtwTnDpvDtbMBHvqPMZewcBZYEUS5NfRqaxfbB7joZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn4JA8d1pUoK5IYDAD/REmgz3XFxvQ+4EMUiivOVIwX0mBUNuj1YudA6H2j/KP2js
	 1u7RZ3bveDlNfpGQfj5OGzCZJjpb35llivcWTSd1DS9XVszq78JeigVaaDJt30fVNe
	 m8EiHvICvqta/R6tBqkwUokrutW8CSVjFsCTw82ts94PN7Wb23kyOBNOizq+Fel7E3
	 RpxysRXLhJfosaVgI0e4cwNxSR+D+4cuGZXBmV9O3xQa+5Ik08YXEiNzb0UdVRDW//
	 xY4ofNxvVqahQAvNh0AywkWtlNbS4RWT6M+8pUp5n0ah3jDMHxD4+LYjUSU0SYsqyP
	 4vxzGPayTPZrQ==
Date: Tue, 20 Jan 2026 15:28:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <aW-RDkr-KQ5pkFAX@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
 <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
 <aW6rAjJ5hz5BYuAR@pavilion.home>
 <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>

Le Tue, Jan 20, 2026 at 01:32:50PM +0100, Rafael J. Wysocki a écrit :
> On Mon, Jan 19, 2026 at 11:07 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > Le Mon, Jan 19, 2026 at 01:30:07PM +0100, Rafael J. Wysocki a écrit :
> > > On Fri, Jan 16, 2026 at 3:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> > > > accounting has a nanoseconds granularity.
> > > >
> > > > Use the appropriate indicator instead to make that deduction.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > >
> > > or please let me know if you want me to take this patch.
> >
> > The patch is standalone but the rest of the patchset depends on it.
> > Now I don't target this patchset for v6.20-rc1.
> >
> > So if you manage to sneak this patch in for v6.20-rc1, it works because
> > I'll rebase on -rc1. Otherwise I'll need to keep it to avoid breaking
> > some code assumptions.
> >
> > What do you think?
> 
> It can go into -rc1.

Very nice, thanks for taking it!


-- 
Frederic Weisbecker
SUSE Labs
