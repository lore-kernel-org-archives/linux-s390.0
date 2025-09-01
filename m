Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49882F0C75;
	Mon,  1 Sep 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715755; cv=none; b=FpJfkQkZ6iIFQEEjOGww17pO0LeMj4fgvM2835I3KEDJR054GjZvWR6jmaNIUlKBfnBAwrZukLUHhaLDa8GuTb9vhrV5s6CriQsb1QK+2r/Xdusywn8iY4MdeAv7drOFA1EudOfa/lESJLbGuEPXjvnos7zI0Eaql05hjwahlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715755; c=relaxed/simple;
	bh=Pv1gPChXFW9aP72GOnZp1EBJBRdrDhsP0cqaXoYRyIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP9ewMIRmgbsppuc3DYmYttjKPyZsQ0kzwZJXGpc4kvfGfvDLJ9p4tIvjogbtE9qi+OhhbQNHgk2TQdd4XUPOIqXwLYHY+cjH1iGPEVGjR2zhMW2ORMHB4arOw5hmWkv7S/nhNIslV099PDAWqxNLnNAHRS3dnYzbv9fHMA/dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqEV2hED; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqEV2hED"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1dF6fbw1yJI8uaYAJFZd1q8MyMtOzcn+2AD+kfES3EY=; b=qqEV2hEDfIYsiLyIjT6xwlfb2Z
	qjNR3sTYmNr1NaC0MoP0e1TXctDVgNM5uy7GqDBI8moy1P0EklJDnHcI9IG23VYPYvdg9txYrqLdR
	r+e3zwIgO7jfG1kPD25hbbprdJvF7NFJYJdGEQVg78D6m2ITPhA0L6bfMu+oC7IYCNL4oYafI+S8y
	PSPiE2gEJf72Z42pJgFWUMDzRIFrRMKLSnm654JoR3Grjh/akEtBnUxUGki8R2QKTNJf0Yc1vGQKY
	ZwT9eh1gLvKRwftTrWjzq5arPxFqSiZamrBsEzBjpjdFSNMr1DlKh2ZLQr2SQ6/y+qeuvTW9jwxxo
	upB6QVBg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut00J-00000005LHb-2d3q;
	Mon, 01 Sep 2025 08:35:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2473300342; Mon, 01 Sep 2025 10:35:07 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:35:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Message-ID: <20250901083507.GD4067720@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
 <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <7137972e-bc7a-432c-94be-755ba9029d8c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7137972e-bc7a-432c-94be-755ba9029d8c@linux.ibm.com>

On Thu, Aug 28, 2025 at 08:13:51PM +0530, Shrikanth Hegde wrote:

> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -170,6 +170,9 @@ config PPC
> >   	select ARCH_STACKWALK
> >   	select ARCH_SUPPORTS_ATOMIC_RMW
> >   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
> > +	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
> > +	select ARCH_SUPPORTS_SCHED_MC		if PPC64 && SMP
> > +	select SCHED_MC				if ARCH_SUPPORTS_SCHED_MC
> 
> Wondering if this SCHED_MC is necessary here? shouldn't it be set by arch/Kconfig?

Ah, so without this SCHED_MC becomes a user selectable option, with this
it is an always on option (for ppc64) -- no user prompt.

That is, this is the only way I found to have similar semantics to this:

> > -config SCHED_MC
> > -	def_bool y
> > -	depends on PPC64 && SMP
> > -

Which is also not a user selectable option.

> nit: Also, can we have so they are still sorted?
> 	select ARCH_SUPPORTS_SCHED_MC		if PPC64 && SMP
> 	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP

Sure, let me flip them. I need to prod that that patch anyway, built
robot still ain'ted happy.


> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -547,15 +547,11 @@ config NODES_SHIFT
> >   	depends on NUMA
> >   	default "1"
> > -config SCHED_SMT
> > -	def_bool n
> > -
> > -config SCHED_MC
> > -	def_bool n
> > -
> >   config SCHED_TOPOLOGY
> >   	def_bool y
> >   	prompt "Topology scheduler support"
> > +	select ARCH_SUPPORTS_SCHED_SMT
> > +	select ARCH_SUPPORTS_SCHED_MC
> >   	select SCHED_SMT
> >   	select SCHED_MC
> Same here. Above two are needed?

Same issue; previously neither were user selectable symbols. By only
selecting the ARCH_SUPPORTS_$FOO variants, the $FOO options become user
selectable. By then explicitly selecting $FOO as well, that user option
is taken away again.


> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -330,6 +330,10 @@ config X86
> >   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> >   	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> >   	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
> > +	select ARCH_SUPPORTS_SCHED_SMT		if SMP
> > +	select SCHED_SMT			if SMP
> Is this SCHED_SMT needed here?

Same again...

> > +	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> > +	select ARCH_SUPPORTS_SCHED_MC		if SMP
> >   config INSTRUCTION_DECODER
> >   	def_bool y
> > @@ -1036,29 +1040,6 @@ config NR_CPUS
> >   	  This is purely to save memory: each supported CPU adds about 8KB
> >   	  to the kernel image.
> > -config SCHED_CLUSTER
> > -	bool "Cluster scheduler support"
> > -	depends on SMP
> > -	default y
> > -	help
> > -	  Cluster scheduler support improves the CPU scheduler's decision
> > -	  making when dealing with machines that have clusters of CPUs.
> > -	  Cluster usually means a couple of CPUs which are placed closely
> > -	  by sharing mid-level caches, last-level cache tags or internal
> > -	  busses.
> > -
> > -config SCHED_SMT
> > -	def_bool y if SMP
> > -
> > -config SCHED_MC
> > -	def_bool y
> > -	prompt "Multi-core scheduler support"
> > -	depends on SMP
> > -	help
> > -	  Multi-core scheduler support improves the CPU scheduler's decision
> > -	  making when dealing with multi-core CPU chips at a cost of slightly
> > -	  increased overhead in some places. If unsure say N here.

See how SCHED_SMT is not a user option for x86.
