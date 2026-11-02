Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617241;
	b=sm3n0sxtrZSmIrfQDihImVTWwxCo62dLrk+7QcwdiQgyvyrP5+ASz1k2E8p37dPvcH/r
	 ufwB1KK3Rxf3uAxfdPLmQUznPaBDuLSGsOva6OlEfXmd5cvJOZE4PUQTi3mlxUy2YM7AZ
	 ccPz1AfCxHJyl6vhRuRiyHVW2TKRkzQoczlB1paHi0DkF55rCpOkeslXEoXCvgqU/E8WY
	 MlhofLMYjjR0pUXve24HIJ2NBb/LeMSuoU6iJwUY5DJxRG2+191BJg/nEwP/xlEEPf2EG
	 qFK58Q+1qXsijeiz5+Znnr3KHpdur7pBZd9kLA++Ak+62/Bgglw2O9QuPRKZW6LRRVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617241;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gmu1a3NLHJfVVFwt2LsdZOjGhk0iaWLym4PaWiReE/U=;
	b=qDCufLmt2SE/L43wwClP6lnWj6qjd8QjltTWf+bpwQfQH74uQ95VBzpuHGQruRy10NiN
	 oLQCYP5WQBQ/aVRugR4G5wvoXZjZnvi2y7+nf2Bl1/nLLWnj7/baBMDIiqjMeYxVI6NHv
	 dCv1+HiPzqt57altQcRxeW2+toeqe17FYmYGE5UL78mvrxcdQB/zy2WU5pdZjhnoS3zST
	 v+tKBTm6pylsM3AJVyUMHnQNoD4MP7NFPsP/wwPb5qbIwiNldqC1Vv62fYgFRqWv/gLyM
	 iznESBm+ucB7jKuD1Cc+/SUsQNHFkj8SL3gCvgQIKWGccrxynDd98ebDVSZYVjreoEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=pFIIuG9I;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CB606A32D;
	Mon,  2 Nov 2026 11:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C5CB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=pFIIuG9I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gmu1a3NLHJfVVFwt2LsdZOjGhk0iaWLym4PaWiReE/U=; b=pFIIuG9Ix79G8xtMZU7N6Ru1g/
	ZU3lybPoXV7qM675SevAwh7hG+KsUjzeYFFwu7JmsN+Tf6o0YExqPLv0X6j+PsEXW8OFJ0oruSiLy
	JcWmASAayz6MW29RAESxTQi1aJGAjIwToi+cSjZSylBV5lus3FTCmYwRmVQNk2442enb21IFLrr/X
	HO0cxL7jYPNZuBK2fg3Zfn3qpay6yRrHiVqOzMdKRkI/ES7fwqc1dLw6iOZUzrFNFQdvcMlEVdwb1
	yuaB5WAUaaap65CXZHSE9Uym6hjsnuN8j8ysKdQWfg4XKxpQi3fknF/733Vgd+n3xZAxKog42HbsP
	luZ4SBJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpm8-00000002PBW-3HSe;
	Mon, 02 Nov 2026 11:00:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AE3153002ED; Mon, 02 Nov 2026 12:00:26 +0100 (CET)
Date: Mon, 2 Nov 2026 12:00:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
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
Subject: Re: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in
 Kconfig.preempt
Message-ID: <20261102110026.GG1813469@noisy.programming.kicks-ass.net>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-2-ynorov@nvidia.com>
 <388636ac-4521-4523-bb5b-b6bc71591ff6@linux.ibm.com>
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
In-Reply-To: <388636ac-4521-4523-bb5b-b6bc71591ff6@linux.ibm.com>

On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
> 
> 
> On 11/1/26 20:21, Yury Norov wrote:
> > The IBM s390 doesn't enable PARAVIRT config for their hardware
> > virtualized Logical Partitions (LPAR). However, the steal time is
> > accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
> > is enabled.
> > 
> > Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
> > and requires it to minimize the configuration space and runtime overhead,
> > with the lack of non-paravirt user. Now that s390 wants to adopt preferred
> > cpumask, there's no reason to keep it coupled to paravirt.
> > 
> > Make PREFERRED_CPU a user-configurable option, even if paravirtualization
> > is not enabled, and drop PARAVIRT dependency on the steal governor.
> > 
> > Keep the default module selection conditional on PARAVIRT so other SMP
> > configurations can opt in without enabling the governor by default.
> > 
> > Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com/
> > CC: Mete Durlu <meted@linux.ibm.com>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> > Can be applied independently from the rest of the series.
> > 
> >   drivers/virt/Kconfig   |  8 ++++++--
> >   kernel/Kconfig.preempt | 12 ++++++++++--
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> This is really useful to us, since even though s390 is nominally
> paravirtualized, it does not technically benefit from defining
> CONFIG_PARAVIRT.

And therefore removing PARAVIRT is the only possible solution?

> Specifically, steal time accounting happens by
> computing a difference between wall time and CPU time, and not by
> explicitly querying the hypervisor.

Nobody explicitly asks the hypervisor, that would be horrendously slow.

Something trivial like this should do.

---
 arch/Kconfig                           | 9 +++++++++
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 arch/s390/Kconfig                      | 1 +
 drivers/virt/Kconfig                   | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f9..8980054beb52 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
 config HAVE_PV_STEAL_CLOCK_GEN
 	bool
 
+#
+#  Archs that can account CPUTIME_STEAL; normal route is through PARAVIRT which
+#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and PPC-LPAR
+#  which have their own thing and don't go through generic cputime accounting.
+#
+config HAVE_CPUTIME_STEAL
+	bool
+	default y if HAVE_PV_STEAL_CLOCK_GEN
+
 config HAVE_MOVE_PUD
 	bool
 	help
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 7d125e288f6e..3c49baf606d7 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -41,6 +41,7 @@ config PPC_SPLPAR
 	depends on PPC_PSERIES
 	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
 	select PARAVIRT_TIME_ACCOUNTING if VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_CPUTIME_STEAL
 	default y
 	help
 	  Enabling this option will make the kernel run more efficiently
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7138d923d86f..03a884355218 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -291,6 +291,7 @@ config S390
 	select USER_STACKTRACE_SUPPORT
 	select VDSO_GETRANDOM
 	select VIRT_CPU_ACCOUNTING
+	select HAVE_CPUTIME_STEAL
 	select VMAP_STACK
 	select ZONE_DMA
 	# Note: keep the above list sorted alphabetically
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index eeb84e578ddf..a3721d34a55c 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -43,7 +43,7 @@ config FSL_HV_MANAGER
 
 config STEAL_GOVERNOR
 	tristate "Dynamic vCPU management based on steal time"
-	depends on PARAVIRT && SMP
+	depends on SMP && HAVE_CPUTIME_STEAL
 	select PREFERRED_CPU
 	default m
 	help
