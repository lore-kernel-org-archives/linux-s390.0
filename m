Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1D2853FA;
	Tue, 26 Aug 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195657; cv=none; b=uQx28LqDt+ItVZpGly2vo8uDLcCJN4Gt6kBoyQd4GpJbTOvBE9ZXYljI1NBiZsKJNT7CJgWeHknQFMXfb2lZdPAQR6S0+U4SH5Q/ACvZ2r/SPsGDF4HpxXmLA6qQvpA7HdEHKJpu2sYbUHaWp0wd2alm328lHwleK6QOWVHWIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195657; c=relaxed/simple;
	bh=iK8bJyugKozpMxKr4N56WGwz38dI4hR+3k1hx+Z8fdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Py2fvdXold7kKd4/BcVXpy54cwlB2ycVJ2zCs0qSzIZTky08/ameN7jDjg8ezTNgEFcabpKzoeiqSpjaUZ99aFWHTz2QepnT/gu2lLX4bdPGxwEp8lJ/K/X80tIfrkMOxJm1stveqOp7oPBlq6nme2JOGO6uUhjfmt6u6gfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H9DpZjWM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H9DpZjWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hmFJ8UGHXtcnTXJTD5aZxBfE9vYuZlwcChixuyZ11Qo=; b=H9DpZjWMWHsq6F3BUVy79e5zuz
	vghIAhY56CI0DpFSVhIibAP4Grh3T4XZmFtAv9N2boiP1jSrrRyqC/Kyt7ZxhkACiCVKZvnDhWzGn
	F+ALksY6fLI9K8Tyu6NlNbuzKhfPGRQzKlBA3P8Fx6yacNBiheOoJjqewsc39YYjZJomLeyhVWnyW
	Kl/o1HBVxiUoLvYU+WlcBCjio4gaTu4doNCN9S8XBFZU6oiJbeUQrefhrCPAdIcHB/xBb9uGuXuMh
	A/wYCGUpUC329jIMJvbiltVIYieOElB91RdrbPNG9oxBQRT7HBz8WT3d8oYoKYEY6YaSFbhpgDYTV
	Is5pjO7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqohv-00000002AKe-1j30;
	Tue, 26 Aug 2025 08:07:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E75E73002C5; Tue, 26 Aug 2025 10:07:06 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:07:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>,
	Bibo Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andrea Righi <arighi@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard
 MC scheduling bits
Message-ID: <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>

On Tue, Aug 26, 2025 at 06:49:29AM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/08/2025 à 06:13, K Prateek Nayak a écrit :
> > PowerPC enables the MC scheduling domain by default on systems with
> > coregroup support without having a SCHED_MC config in Kconfig.
> > 
> > The scheduler uses CONFIG_SCHED_MC to introduce the MC domain in the
> > default topology (core) and to optimize the default CPU selection
> > routine (sched-ext).
> > 
> > Introduce CONFIG_SCHED_MC for powerpc and note that it should be
> > preferably enabled given the current default behavior. This also ensures
> > PowerPC is tested during future developments that come to depend on
> > CONFIG_SCHED_MC.
> > 
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> >   arch/powerpc/Kconfig           | 9 +++++++++
> >   arch/powerpc/include/asm/smp.h | 2 ++
> >   arch/powerpc/kernel/smp.c      | 4 ++++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 93402a1d9c9f..e954ab3f635f 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -971,6 +971,15 @@ config SCHED_SMT
> >   	  when dealing with POWER5 cpus at a cost of slightly increased
> >   	  overhead in some places. If unsure say N here.
> > +config SCHED_MC
> > +	bool "Multi-Core Cache (MC) scheduler support"
> > +	depends on PPC64 && SMP
> > +	default y
> > +	help
> > +	  MC scheduler support improves the CPU scheduler's decision making
> > +	  when dealing with POWER systems that contain multiple Last Level
> > +	  Cache instances on the same socket. If unsure say Y here.
> > +
> 
> You shouldn't duplicate CONFIG_SCHED_MC in every architecture, instead you
> should define a CONFIG_ARCH_HAS_SCHED_MC in arch/Kconfig that gets selected
> by architectures then have CONFIG_SCHED_MC defined in init/Kconfig or
> kernel/Kconfig or so.

Let me add this first -- it is currently duplicated. Then I'll see about
merging the thing across architectures.
