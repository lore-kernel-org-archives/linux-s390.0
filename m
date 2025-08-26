Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675B2F8BC4;
	Tue, 26 Aug 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196680; cv=none; b=UWKgRoWLmdQh2/qdHtE0thj1mTN0z1azkZarCznkwi3krFfRVndNMhqCOol7XjqdXyYwSZbiVIfFy+i7xpSBcghpqP8fLExHfEby9o29c2LYacVcLl+DAwH20mJOr6bmqohlI8Ne594hpQpbg5c/xUGZL9FWi70tTPuEBTNvhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196680; c=relaxed/simple;
	bh=nbB61l1pzDl4+a99LzNXebJ8dEqreCMWdwc402CpDlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzxb5petx7oDpo0746hLhIY4PQVkP5DEZBPVsgA9UDhFiMkBQzgmMQQqtkZPV3b1pwodY6sUV+Mj9xDb39MJcxfDVSk7DVG9pSCgoQLXkOPVifdVhs4Au5I0LBH6yCw6h/vvvl8QE0Y2Z2GNSI2EkeiHLr/pRAF8PkgxNQaYeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p+Q6uFyl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+Q6uFyl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7rF4Z3nFFKjvmRCuB0uyqnPIPVz/DLlRjcPNglDabus=; b=p+Q6uFylxWqCNSMkjEFeg4rdfp
	QJ5psU8HRDgFK7/NXSdQKPJO2dqVJJFbWPBmr5cq797ldtSP4kAlLzBYWekPI7GCqhu1kOFMcKxkt
	y6uSzCktiivrZCMhNE6Owbk+vGLsxHeSOCYz6LqZTNsWEguOZUp4iJpX9V3iDn5Iktz2dj3kbeSQt
	zcCcajnHO2mHJAYqN8NR9E0eM7nGHNiFphhooovRkw6xjXYFq1A1zUkW9wXfc89u27t/ImZzVQCEV
	CWGJ8TqNVA5DdoOUVRjFmpX1BkZfTo1A9u4Q6IPv8ovGp5lUIUUkRRBtxOg+ysOUON28JLZO5Y1YR
	SmbYdxNw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqoyK-0000000F6R7-2qfM;
	Tue, 26 Aug 2025 08:24:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DAE223002C5; Tue, 26 Aug 2025 10:24:04 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:24:04 +0200
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
Subject: Re: [PATCH v7 5/8] sched/topology: Unify tl_smt_mask() across core
 and all arch
Message-ID: <20250826082404.GF3245006@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-6-kprateek.nayak@amd.com>
 <20250826080123.GB3245006@noisy.programming.kicks-ass.net>
 <a506bb53-6e17-4a10-a870-50ce87a4ce06@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a506bb53-6e17-4a10-a870-50ce87a4ce06@csgroup.eu>

On Tue, Aug 26, 2025 at 10:11:40AM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/08/2025 à 10:01, Peter Zijlstra a écrit :
> > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > index 602508130c8a..d75fbb7d9667 100644
> > > --- a/include/linux/sched/topology.h
> > > +++ b/include/linux/sched/topology.h
> > > @@ -37,7 +37,13 @@ static inline int cpu_smt_flags(void)
> > >   {
> > >   	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
> > >   }
> > > -#endif
> > > +
> > > +static const __maybe_unused
> > > +struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> > > +{
> > > +	return cpu_smt_mask(cpu);
> > > +}
> > > +#endif /* CONFIG_SCHED_SMT */
> > 
> > Problem with that __maybe_unused is that you forgot inline.
> > 
> > static inline const
> > struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> > {
> > 	return cpu_smt_mask(cpu);
> > }
> > 
> > seems to make it happy.
> > 
> 
> But the function is referenced by SDTL_INIT() macro so there is no real
> point in declaring it inline. Would be cleaner to have it defined in a C
> file.

Ah, that's what you mean. I was more focussed on getting rid of that
horrible __maybe_unused and then either works. But yes, perhaps just
having them in a .c file is best.
