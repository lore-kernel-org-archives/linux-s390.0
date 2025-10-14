Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225A25BEE5;
	Tue, 14 Oct 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451508; cv=none; b=FMxXUbUUL2xtOPPeIZvif8yPVjbdYtJ9gBdKslDwIsfktaO/tO2qDbT6K5ZH5Sl6pnFl35TQxAwrGMw5TCLzJWplCNZCJ/pwqukaw+kAtQkUMhweRpXYV4OV3iKHnsGYAckoff59x0JONv0Zs5QiWmy96Wub5HOxjqujuuEm3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451508; c=relaxed/simple;
	bh=C6uXU8IHXxoZXH1bAxIf/BeNm0rAdsdg75UMFU/czVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjAD6B95dNuKb7/b5wrrdu5tUs28p8GNYqGE5+6t/koG5obw8D6dswBFwqM/lJPyfb5Uwqp1NVE0xYMIpsXMszhuLIuhkr4BLPpNSI2XFNyoDhNhR4yacdWlDYuPNuFgMEyJNPszBvRPXve+jRZkcOJfjV3vAXLMJt20WNae528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5FGoCuL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5FGoCuL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iioJ+H5BgqY5puHAxyGpj4x0tQd8UQglUZLFQMVFr44=; b=g5FGoCuL0zimjyfsecg0GRPO3s
	f2hG87ySsnZH7QcTJb8TQCsEySz2dFP4keEkjH5kzFbd/KkjPxKdkXKEqEgtiGQ/Te5cxe+Y2+U6q
	/kOztLe5ogwbAvF91sF91iGZ2+mhRuA9BvvcmGjV8tMX09UwRpVdrMRetqlORBFBDfwu6ARcRLyKB
	scfsGWlt02Rr+PxFo2fszdISCCzl85Uycsc6IGprodh3E6yMvAGJ7AnRqpu3mc4Ac7qB6Rzo7mKqX
	bpAxQFCB24P7lkEa7Xa8AlRgLQUB5A8ksAjQoI0GntfG9rsTpx7akpNBe1/RxrfDxJ89jH/XEW23m
	N8TRJhfA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8fqF-00000005ErK-3Loc;
	Tue, 14 Oct 2025 14:17:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2CF4300212; Tue, 14 Oct 2025 16:17:30 +0200 (CEST)
Date: Tue, 14 Oct 2025 16:17:30 +0200
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
Message-ID: <20251014141730.GZ3245006@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
 <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
 <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>

On Tue, Oct 14, 2025 at 02:37:11PM +0200, Geert Uytterhoeven wrote:

> > > > +       help
> > > > +         Improves the CPU scheduler's decision making when dealing with
> > > > +         MultiThreading at a cost of slightly increased overhead in some
> > > > +         places. If unsure say N here.
> > >
> > > So it should default to n?
> >
> > That's just help text that got carried around. Many of the architectures
> > that had default y still had this text on. I suppose we can change it if
> > someone cares.
> 
> Please do so.

How about we remove the recommendation like so? There are many help
things that do not have a recommendation. Mostly these options add a
little code and the most expensive bits tend to be gated by
static_branch() so it really shouldn't be that bit of a burden.

CONFIG_SMP was the big one for the scheduler, and Ingo recently removed
that (he did an effective unifdef CONFIG_SMP=y on the scheduler code).

---
diff --git a/arch/Kconfig b/arch/Kconfig
index ebe08b9186ad..3d8e2025a4ac 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -57,7 +57,7 @@ config SCHED_SMT
 	help
 	  Improves the CPU scheduler's decision making when dealing with
 	  MultiThreading at a cost of slightly increased overhead in some
-	  places. If unsure say N here.
+	  places.
 
 config SCHED_CLUSTER
 	bool "Cluster scheduler support"
@@ -77,7 +77,7 @@ config SCHED_MC
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision
 	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
+	  increased overhead in some places.
 
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
