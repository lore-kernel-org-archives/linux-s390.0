Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423D1D5178;
	Tue, 26 Aug 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195335; cv=none; b=J4udfB6r/Knp6lcRebfuBgkC6etGTzUzCLkzA0l/LX3shmBo+xkpqQBrHTIDZk2uCsge/zvy75ucKk9Y9ZDNeMTtoE76sFE3HGB+yDQeqQE5nvQUzhttPmiSKo+BhFC13xNw+kDPgmU+33GtY7KmjHa8DMW30Frv1uGk3ULjaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195335; c=relaxed/simple;
	bh=8oS45OZxsUUtLvXW5qoqxb0N051dvs8OmIcJ9ROhSpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM8xI+gxl4RU5ipYLZRAtJ41sijTp+JvWwop6qqFHofNpT1fI8NkAKkhWhp9j+tht+7SAPeIbzd/tVAEB4ajuBUcuMbigl0XXg5Se6eiFErHw4bM/TxiHDcBKxHxpWNEBWdcK/CKtVDr2V4vJHfcXnM41+W+ARd4Tq0bR7cJbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YRNJLkkG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRNJLkkG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MeaWqH2Rz3f87zQ3/bNc5oTQxLBcu0GLQKcR2xh3Qso=; b=YRNJLkkGouui1FXZAEdgnAYbtq
	nObm01fOGuFzOAUKso2zWlt0z2cLuE4vbV+flWhLC7PGgdGG+6C5SWh1Sstq1NVW3KejpgeiNZLqL
	Wg+R9GabyRFIyGtmOF9OoPtvi4sBIPJ4/ie2WcsQ4SEdUcc/XgDpKvsDpQ3jddTkRKOTJrfpdlPd3
	t0w3QbF1YJ+/v65cMQCWFYrMOntKPAijSzY6PW6irY2KhIyKAnJt0x6jDQwJCGHeRFAG2I8NwB5XW
	tksAkp+jD/Bdrcmvf5rrHrixtTxpOu2xCmZbJ/QzdoKQfxu03AedLbJk27bejPLIXds4Lc1xG0/fO
	405uTk/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqocO-00000002AI3-15mB;
	Tue, 26 Aug 2025 08:01:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 134803002C5; Tue, 26 Aug 2025 10:01:23 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:01:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <20250826080123.GB3245006@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-6-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826041319.1284-6-kprateek.nayak@amd.com>

> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 602508130c8a..d75fbb7d9667 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -37,7 +37,13 @@ static inline int cpu_smt_flags(void)
>  {
>  	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>  }
> -#endif
> +
> +static const __maybe_unused
> +struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_smt_mask(cpu);
> +}
> +#endif /* CONFIG_SCHED_SMT */

Problem with that __maybe_unused is that you forgot inline.

static inline const
struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
{
	return cpu_smt_mask(cpu);
}

seems to make it happy.

