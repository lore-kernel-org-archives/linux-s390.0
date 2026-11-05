Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890546;
	b=m2Fn2kIOh2zEztvt5UHNFofO7Wy0fm+lkg6wiUEAlNkVUZm2l+SrMMXukMACw6DHnTnE
	 h1xk4+asJ5zJ4XkY6L8D09vzsj8++U8c0NoRqXJ4jEdvoEoaf62+hRK8hV0Y4fqEBcJzu
	 pLekoUJDtuilO0tViWdR3aCtM2PXshoFw90/CAVfjyuG3Ef7kHBhfgImkERD00FX4yhEI
	 mB2xtfDm327IfrKl6dAIufYRR8oFCqgZPpMnN5Ychjd8VxzFr3X6KfL2FGHfMBoGeaorI
	 toa2QJcZ4dX/YdZItbIHDwMwJfNV9hSL0AjaRUPy8po5pVNZuVmFi7aNK7kKQvoFhXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890546;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=E+3ZUaclhseohkOn5r9sKhXgtCK7fNAm8sjLGqWFldY=;
	b=pn93DCqodsxyohKIpzTFrojw3WOQC1t6+tRKEVDPr0itXt0yCn2022PX2Hoz6Ql6qpUd
	 jy39/7r2Ibn3/7VCI7n6PZyx5LGvB+9sejdlaMZv43yg0/IaBpEZLz3XSpRc3I7EABXaP
	 c8MTIEmwT92XHeMRrMH0/ng2vdy0U25wRB8ozTbasT+nCc3oIdcwQz+bNsWunrvUKuqnA
	 Wn/S6qE4XwOUrKTU5P6AK1Abi8kSjOiSl1OsT8qfKHc5JGEeXkXd723hb36cu3OwxLOxo
	 ET08Lh1KYZkP36tU0IAwHK4r+mHZT2y1ll7fGgwa+YfSJ7Pmtagr6fQihse90sdQUMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gcYKzKSc;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AC6606A31B;
	Thu,  5 Nov 2026 14:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37AC6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gcYKzKSc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E+3ZUaclhseohkOn5r9sKhXgtCK7fNAm8sjLGqWFldY=; b=gcYKzKScm6GmGtEXWYxBQCLwDE
	jKtAu268Erk6NPqXSPn+NyDxL1mKuvlbThTC0bih4K4h9TBIxvLS6gLwdT9AA4cVH+QINMN6CWJZ2
	Aj11lvFjC7YlUnX2zSr++eQ2/6e06SSbMY5urSHt7UJwcZyGzdyvvuoFkPW9dSTrlhEQu5db2btV0
	gD9/OdDYeb65NV59+3GpmUmYHj15cnhcPAvCq9FEWPHVy3XujM+bTlaYRpqiJRCAs+ZwLRjt/skdJ
	2PRvPY2lB5gc0Byxk/cLFLqzTvqtt7GDeN0zzWqgd01p9+f6kakIzdj/v63Q26CFEj2C5u2z0h4PV
	x0ddqbqQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOysN-000000036yy-249d;
	Thu, 05 Nov 2026 14:55:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02BCA30057E; Thu, 05 Nov 2026 15:55:38 +0100 (CET)
Date: Thu, 5 Nov 2026 15:55:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
Message-ID: <20261105145537.GP1813469@noisy.programming.kicks-ass.net>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261102084704.GQ1779021@noisy.programming.kicks-ass.net>
 <auoQfjpg3CRvV5yG@yury>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auoQfjpg3CRvV5yG@yury>

On Tue, Nov 03, 2026 at 11:49:02AM -0500, Yury Norov wrote:
> On Mon, Nov 02, 2026 at 09:47:04AM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 01, 2026 at 02:21:56PM -0500, Yury Norov wrote:
> > > The preferred CPU mask currently lets the steal governor reduce vCPU
> > > demand when physical CPUs are contended. This series adds manual control,
> > > opening more use cases.
> > 
> > Sceptical, I am.
> > 
> > > For example, setting CPUs aside for selected fair tasks at runtime while
> > > steering other fair tasks toward the remaining CPUs.
> > 
> > That's exactly the kind of nonsense we don't need and makes me want to
> > stop reading right here.
> 
> OK, I started with the wrong argument. Please consider this as the argument
> #3.
> 
> #1 is: conceptually, preferred cpumask improves performance because it
> moves the scheduling decision from host to the guest level. The guest
> can do it better because it knows more about the workload. But then we'd
> consider moving steal governor logic to the guest userspace, because it
> knows the nature of user workload even more.

I am confused; it is a simple control loop and has nothing to do with
guest workload.

The host is over-committed, this results in vcpu steal time. The guests
observe steal time and reduce vcpu utilization.

It is a co-operative scheme; a bad actor can game the system. It is
imperative all guests behave the same or do not play at all.

If there is no level of trust (our coconut friends) do not use this.

> #2: convenience and scope. Some systems don't allow loading modules -
> either on config level, through selinux, or somehow else. They don't
> even have compiler installed sometimes. 

You hurt if you shoot your foot off; not my problem. If you run guests
like that you don't use this.

> > we already have cpusets that is more than capable of doing this.
> 
> Then why do we need the steal governor at all? We can steer all
> processes away from a given vCPU without any driver, only by playing
> with each individual process' affinity. For vCPU throttling, task
> isolation, or whatever purpose.

Different level of operation; different semantics. Cpusets is for strong
bounds on your own workloads, this preferred mask is weak bounds on the
system due to outside pressure.

In a way it isn't much different from ACPI idle injection.
