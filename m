Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702E2E5D2A;
	Tue, 14 Oct 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434982; cv=none; b=RKM/PbwmZwMWC5be/b5f4K6B8KYEQAfCZLF1cvVgiaMI9ssqybVWM7EUhkX+ydDL42Iwpo82dyXcDPAoUYo8gmKlPFMIKCMaosqzB5eAzt5d0GeG/Qnh4lZC40jnrqPkNtTirW+MTCSz1ydlyxtPIhuU9BiIiD0iu0t3WGea1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434982; c=relaxed/simple;
	bh=GGtR/7/cDoa0TG0sWm6pd9jcmCj8RTee3ZIi+3U/44g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTid79wdnQsTmlSpFIhVCM5KVKAHL+Umtq32k8hJ1nxOdrs4BODdxWha5tDiOCezGZGs0X0b4qJFUkVBVtyfcx9y08DmQ4vDFjtIIXvlyV/Yvik0dzQVvOIa6ChJ4G5kZ5A8bng1zS6yZpqFUyJ57oShvUxv3Tc2iS0GO6IrKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lT3Jtn7W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lT3Jtn7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EyinUIp7/RYhTp5epJi+n1GQX1sFo+xbZTFlP4HGzjw=; b=lT3Jtn7WLusiNPynl/CNMZA26A
	dizGjfWpPThsB+CPPP+VBT1d7Yf8GvtmvImfJ5+mjXuMrZyWFCNkkwd373BEiHxSOaFObuL9EQIov
	GPM/cBO/PaHIaEYTL88sqqp43WQwYYrZFQBfoJLo/Fnb4kbSc9QbTG6Qjx6sNaLiTdpV+MMtbbvvb
	iOesMlrclvhPCdz5jldRsMPxRjQXTHw/9ea3nqaBi3wGtR9L7ebhkJYkTHAZ7DXywiz1qAHTCDFnW
	60UaLrTlPRzJ3mqXymx7ccZb7K2ZiRhlVHh/HXYWNy40YZCh97z5RnAFy42g98Gdjc0Xqe5t4Ivzg
	fWOjpouw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8bXl-00000007xSU-20Gz;
	Tue, 14 Oct 2025 09:42:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 185FB300212; Tue, 14 Oct 2025 11:42:10 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:42:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Message-ID: <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
 <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>

On Tue, Oct 14, 2025 at 11:25:53AM +0200, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> On Thu, 28 Aug 2025 at 14:57, Peter Zijlstra <peterz@infradead.org> wrote:
> > Now, when I look at unifying those config options (there's a metric ton
> > of crap that's duplicated in the arch/*/Kconfig), I end up with something
> > like the below.
> >
> > And while that isn't exact, it is the closest I could make it without
> > making a giant mess of things.
> >
> > WDYT?
> 
> Thanks for your patch, which is now commit 7bd291abe2da09f5 ("sched:
> Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") in v6.18-rc1.
> 
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -41,6 +41,44 @@ config HOTPLUG_SMT
> >  config SMT_NUM_THREADS_DYNAMIC
> >         bool
> >
> > +config ARCH_SUPPORTS_SCHED_SMT
> > +       bool
> > +
> > +config ARCH_SUPPORTS_SCHED_CLUSTER
> > +       bool
> > +
> > +config ARCH_SUPPORTS_SCHED_MC
> > +       bool
> > +
> > +config SCHED_SMT
> > +       bool "SMT (Hyperthreading) scheduler support"
> > +       depends on ARCH_SUPPORTS_SCHED_SMT
> > +       default y
> 
> This is now enabled by default everywhere, while it was disabled by
> default on most architectures before...

I'm not sure ARCH_SUPPORTS_SCHED_SMT counts as everywhere, but yes.
A fair deal of the architectures had all this default yes, and I had to
pick something. Can't make an omelette without breaking an egg and all
that :/

> > +       help
> > +         Improves the CPU scheduler's decision making when dealing with
> > +         MultiThreading at a cost of slightly increased overhead in some
> > +         places. If unsure say N here.
> 
> So it should default to n?

That's just help text that got carried around. Many of the architectures
that had default y still had this text on. I suppose we can change it if
someone cares.

> If it is really needed on some architectures or platforms, I guess
> they can still select it explicitly?

There were 4 cases:

 - arch doesn't support SMT
 - arch supports SMT and lets user pick, default Y
 - arch supports SMT and lets user pick, default N
 - arch mandates SMT

Of those 3 are still possible, the one we lost is the default N case.

Old configs that have =N will continue to have N. New configs might end
up with Y.

Why is this a problem?
