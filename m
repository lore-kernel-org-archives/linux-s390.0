Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E2BEFFF;
	Fri, 11 Jul 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239192; cv=none; b=IMFr8YmnGTgmA3sDLS/Qvto1bjBgAd3WS9OM9Fno0yYUnp8TicclkJqX38JNRGlvHjaXFxT73ED2dlDA1FDoFqMeBiuXcyOgRbtfDvqxYJ7EVnL5X9HAgTrK+31h3iU+Ao7kawsU0FaJG900lsZmCLhWT89Ii/gBh7jvO+IyXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239192; c=relaxed/simple;
	bh=J4wUz16iRQD/QxH/1/KTXO8oOeJvtziJcWCuq90fPgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw4dA60JCqGc8xez7Mx63ASEumnk10Q0zyf7nXqGz46UinJO4gw702EhJFhAX6HwPoLJWvfN/XuEZ+PZA091yi4IZTBG6qQxiQvcX/qefThOJrrCsIoesiEVesMU0Zb7tNiZC3ezY1L5gkqdilfl7I9oxPZ/jKS3dnSQXTCQirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nmrReV8D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nmrReV8D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JQDO7CQbOse5fynpXP+bHFdnydSlbIlzSOnsKM4/1ek=; b=nmrReV8DwctvLjXYkxFOs5GG3A
	sbZLcU/SKsakeyPJR7xcr9eLL8ztsj6REA+QLFqWeWl8wptXBsAXI+yXPrpEh/MYtqcWL24pyadUV
	MaSk4RYDiaDAYA3SV8AzNgL9GFilmQCW/ZZtTGfIwFQ22WLmpdwUa7eS1yS0XB/dMyFCshp3PliUt
	GImPgDWwv8qamQAUbrZf0nuywP7ftzAQ4mX2q07XXZUPxzb49ZHomGPOn1RkyRCu66Oh/QoarEM+Y
	VHw/cEYm47Rs1AeUIbEXOHdHZ3p8joIZ89nk7uUMNn0+Xhsp57tADXactQhYlWnemIXP19LWAMIuE
	HTJ23B0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaDRy-00000009GLp-2VOl;
	Fri, 11 Jul 2025 13:06:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5E873001AA; Fri, 11 Jul 2025 15:06:01 +0200 (CEST)
Date: Fri, 11 Jul 2025 15:06:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Li Chen <me@linux.beauty>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Li Chen <chenl311@chinatelecom.cn>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Joel Granados <joel.granados@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
Message-ID: <20250711130601.GD905792@noisy.programming.kicks-ass.net>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
 <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>

On Fri, Jul 11, 2025 at 11:20:30AM +0530, K Prateek Nayak wrote:
> On 7/10/2025 4:27 PM, Li Chen wrote:
> >  	/*
> >  	 * .. and append 'j' levels of NUMA goodness.
> >  	 */
> >  	for (j = 1; j < nr_levels; i++, j++) {
> > -		tl[i] = (struct sched_domain_topology_level){
> > -			.mask = sd_numa_mask,
> > -			.sd_flags = cpu_numa_flags,
> > -			.flags = SDTL_OVERLAP,
> > -			.numa_level = j,
> > -			SD_INIT_NAME(NUMA)
> > -		};
> > +		tl[i] = SDTL_INIT(sd_numa_mask, cpu_numa_flags, NUMA);
> > +		tl[i].numa_level = j;
> > +		tl[i].flags = SDTL_OVERLAP;
> 
> Tangential discussion: I was looking at this and was wondering why we
> need a "tl->flags" when there is already sd_flags() function and we can
> simply add SD_OVERLAP to sd_numa_flags().
> 
> I think "tl->flags" was needed when the idea of overlap domains was
> added in commit e3589f6c81e4 ("sched: Allow for overlapping sched_domain
> spans") when it depended on "FORCE_SD_OVERLAP" sched_feat() which
> allowed toggling this off but that was done away with in commit
> af85596c74de ("sched/topology: Remove FORCE_SD_OVERLAP") so perhaps we
> can get rid of it now?
> 
> Relying on SD_NUMA should be enough currently. Peter, Valentin, what do
> you think of something like below?

I think you're right. SD_NUMA appears to be the one and only case that
also has SDTL_OVERLAP which then results in setting SD_OVERLAP, making
SD_NUMA and SD_OVERLAP equivalent and SDTL_OVERLAP redundant.

I'll presume you're okay with me adding your SoB to things, and I'll
push out all 5 patches to queue/sched/core to let the robots have a go
at things.
