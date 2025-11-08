Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3634D38B;
	Sat,  8 Nov 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640186; cv=none; b=b30wJlbdOKcYhY9vLKDvLy9g9gu6nU0rTH64scRLDOq4ovP7EbLtSLLcolHZb+k87i2X/EA5IBHvj9id1GXIGbaT2tOgXnODn7bvrxx4jaywaF22TmPhYZvI/8I+WiB1KsqANpElysSxwPcYzKeqwB9YEnVxtH8UoPR+AAFal+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640186; c=relaxed/simple;
	bh=pBhyieeDjchlJ+mOjFaTeT3Y/QitnXECs185al56b+I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cJ4udU1yiWR/CrVNO1XDqIhia70t4/xe6EmyzE6bhtkdBNwG80o3/WpXRQLd+FNqpe4B8LJHnN49/ZcqfjheY6x7AcpMuyNW9UmqNQZqSkMqdRcIzNUGjrK85Exhz4jdimb2jhvAm+2quVGggRB3z3QgqSHHN3PxZRAqFstT4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fWeMhNeb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fWeMhNeb"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A8MEjxP2478531
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Nov 2025 14:14:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A8MEjxP2478531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762640093;
	bh=B/Cs56oiwOfYFf5C+E+O3dVcT+FEPLCVGwSgjVsb61Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fWeMhNebCueBIgpwwJ9HzqbFTchAPIdo17J2WvEY7kkjBFr98Hd14BZVU/elSj4e9
	 sYvaiqrxvUl4BY8IpX0uQCmYyYRGpwEYM4AMpxmeO6jowam81zKx+Iou/8ibo+BM+1
	 ywYMqpzqqzlsIya940Jmlzx8lzG2S8DMVB5+RfgE7pFBtdtphXJ6gZJo7OenPNVKFJ
	 UQgPH5eVKjpuy1XcgvLHNRCiWtDhbQz2AI+JZNS/Lv07T437bJJ0VfM8ndXOQVc3ZX
	 UAUehct6G47TvwmWI2P9q6uIb6MiC/veNOSx+dHqmpfeKU8Yq/RQ/QTtFSTKBOHhQF
	 vb74cw9jAoTUA==
Date: Sat, 08 Nov 2025 14:14:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xie Yuanbin <qq570070308@gmail.com>, david@redhat.com, tglx@linutronix.de,
        segher@kernel.crashing.org, riel@surriel.com, peterz@infradead.org,
        linux@armlinux.org.uk, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        james.clark@linaro.org, anna-maria@linutronix.de, frederic@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, nathan@kernel.org,
        nick.desaulniers+lkml@gmail.com, morbo@google.com,
        justinstitt@google.com, qq570070308@gmail.com, thuth@redhat.com,
        brauner@kernel.org, arnd@arndb.de, jlayton@kernel.org,
        aalbersh@redhat.com, akpm@linux-foundation.org, david@kernel.org,
        lorenzo.stoakes@oracle.com, max.kellermann@ionos.com,
        ryan.roberts@arm.com, nysal@linux.ibm.com, urezki@gmail.com
CC: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
        will@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/4=5D_Provide_the_alwa?=
 =?US-ASCII?Q?ys_inline_version_of_some_functions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251108172346.263590-4-qq570070308@gmail.com>
References: <20251108172346.263590-1-qq570070308@gmail.com> <20251108172346.263590-4-qq570070308@gmail.com>
Message-ID: <04CA2D22-4DE2-4DE1-A2BC-AACE666F5F93@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2025 9:23:45 AM PST, Xie Yuanbin <qq570070308@gmail=2Ecom> w=
rote:
>On critical hot code paths, inline functions can optimize performance=2E
>However, for current compilers, there is no way to request them to inline
>at a specific calling point of a function=2E
>
>Add a always inline version to some functions, so that they can be chosen
>when called in hot paths=2E
>
>Signed-off-by: Xie Yuanbin <qq570070308@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Rik van Riel <riel@surriel=2Ecom>
>Cc: Segher Boessenkool <segher@kernel=2Ecrashing=2Eorg>
>Cc: David Hildenbrand <david@redhat=2Ecom>
>Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>---
> arch/arm/include/asm/mmu_context=2Eh      | 12 +++++++-
> arch/s390/include/asm/mmu_context=2Eh     | 12 +++++++-
> arch/sparc/include/asm/mmu_context_64=2Eh | 12 +++++++-
> kernel/sched/core=2Ec                     | 38 ++++++++++++++++++++++---
> 4 files changed, 67 insertions(+), 7 deletions(-)
>
>diff --git a/arch/arm/include/asm/mmu_context=2Eh b/arch/arm/include/asm/=
mmu_context=2Eh
>index db2cb06aa8cf=2E=2Ee77b271570c1 100644
>--- a/arch/arm/include/asm/mmu_context=2Eh
>+++ b/arch/arm/include/asm/mmu_context=2Eh
>@@ -80,7 +80,12 @@ static inline void check_and_switch_context(struct mm_=
struct *mm,
> #ifndef MODULE
> #define finish_arch_post_lock_switch \
> 	finish_arch_post_lock_switch
>-static inline void finish_arch_post_lock_switch(void)
>+/*
>+ * finish_arch_post_lock_switch_ainline - the always inline version of
>+ * finish_arch_post_lock_switch, used for performance sensitive paths=2E
>+ * If unsure, use finish_arch_post_lock_switch instead=2E
>+ */
>+static __always_inline void finish_arch_post_lock_switch_ainline(void)
> {
> 	struct mm_struct *mm =3D current->mm;
>=20
>@@ -99,6 +104,11 @@ static inline void finish_arch_post_lock_switch(void)
> 		preempt_enable_no_resched();
> 	}
> }
>+
>+static inline void finish_arch_post_lock_switch(void)
>+{
>+	finish_arch_post_lock_switch_ainline();
>+}
> #endif /* !MODULE */
>=20
> #endif	/* CONFIG_MMU */
>diff --git a/arch/s390/include/asm/mmu_context=2Eh b/arch/s390/include/as=
m/mmu_context=2Eh
>index d9b8501bc93d=2E=2E577062834906 100644
>--- a/arch/s390/include/asm/mmu_context=2Eh
>+++ b/arch/s390/include/asm/mmu_context=2Eh
>@@ -97,7 +97,12 @@ static inline void switch_mm(struct mm_struct *prev, s=
truct mm_struct *next,
> }
>=20
> #define finish_arch_post_lock_switch finish_arch_post_lock_switch
>-static inline void finish_arch_post_lock_switch(void)
>+/*
>+ * finish_arch_post_lock_switch_ainline - the always inline version of
>+ * finish_arch_post_lock_switch, used for performance sensitive paths=2E
>+ * If unsure, use finish_arch_post_lock_switch instead=2E
>+ */
>+static __always_inline void finish_arch_post_lock_switch_ainline(void)
> {
> 	struct task_struct *tsk =3D current;
> 	struct mm_struct *mm =3D tsk->mm;
>@@ -120,6 +125,11 @@ static inline void finish_arch_post_lock_switch(void=
)
> 	local_irq_restore(flags);
> }
>=20
>+static inline void finish_arch_post_lock_switch(void)
>+{
>+	finish_arch_post_lock_switch_ainline();
>+}
>+
> #define activate_mm activate_mm
> static inline void activate_mm(struct mm_struct *prev,
>                                struct mm_struct *next)
>diff --git a/arch/sparc/include/asm/mmu_context_64=2Eh b/arch/sparc/inclu=
de/asm/mmu_context_64=2Eh
>index 78bbacc14d2d=2E=2Eca7019080574 100644
>--- a/arch/sparc/include/asm/mmu_context_64=2Eh
>+++ b/arch/sparc/include/asm/mmu_context_64=2Eh
>@@ -160,7 +160,12 @@ static inline void arch_start_context_switch(struct =
task_struct *prev)
> }
>=20
> #define finish_arch_post_lock_switch	finish_arch_post_lock_switch
>-static inline void finish_arch_post_lock_switch(void)
>+/*
>+ * finish_arch_post_lock_switch_ainline - the always inline version of
>+ * finish_arch_post_lock_switch, used for performance sensitive paths=2E
>+ * If unsure, use finish_arch_post_lock_switch instead=2E
>+ */
>+static __always_inline void finish_arch_post_lock_switch_ainline(void)
> {
> 	/* Restore the state of MCDPER register for the new process
> 	 * just switched to=2E
>@@ -185,6 +190,11 @@ static inline void finish_arch_post_lock_switch(void=
)
> 	}
> }
>=20
>+static inline void finish_arch_post_lock_switch(void)
>+{
>+	finish_arch_post_lock_switch_ainline();
>+}
>+
> #define mm_untag_mask mm_untag_mask
> static inline unsigned long mm_untag_mask(struct mm_struct *mm)
> {
>diff --git a/kernel/sched/core=2Ec b/kernel/sched/core=2Ec
>index 0e50ef3d819a=2E=2Ec50e672e22c4 100644
>--- a/kernel/sched/core=2Ec
>+++ b/kernel/sched/core=2Ec
>@@ -4884,7 +4884,13 @@ static inline void finish_task(struct task_struct =
*prev)
> 	smp_store_release(&prev->on_cpu, 0);
> }
>=20
>-static void do_balance_callbacks(struct rq *rq, struct balance_callback =
*head)
>+/*
>+ * do_balance_callbacks_ainline - the always inline version of
>+ * do_balance_callbacks, used for performance sensitive paths=2E
>+ * If unsure, use do_balance_callbacks instead=2E
>+ */
>+static __always_inline void do_balance_callbacks_ainline(struct rq *rq,
>+		struct balance_callback *head)
> {
> 	void (*func)(struct rq *rq);
> 	struct balance_callback *next;
>@@ -4901,6 +4907,11 @@ static void do_balance_callbacks(struct rq *rq, st=
ruct balance_callback *head)
> 	}
> }
>=20
>+static void do_balance_callbacks(struct rq *rq, struct balance_callback =
*head)
>+{
>+	do_balance_callbacks_ainline(rq, head);
>+}
>+
> static void balance_push(struct rq *rq);
>=20
> /*
>@@ -4949,11 +4960,21 @@ struct balance_callback *splice_balance_callbacks=
(struct rq *rq)
> 	return __splice_balance_callbacks(rq, true);
> }
>=20
>-static void __balance_callbacks(struct rq *rq)
>+/*
>+ * __balance_callbacks_ainline - the always inline version of
>+ * __balance_callbacks, used for performance sensitive paths=2E
>+ * If unsure, use __balance_callbacks instead=2E
>+ */
>+static __always_inline void __balance_callbacks_ainline(struct rq *rq)
> {
> 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
> }
>=20
>+static void __balance_callbacks(struct rq *rq)
>+{
>+	__balance_callbacks_ainline(rq);
>+}
>+
> void balance_callbacks(struct rq *rq, struct balance_callback *head)
> {
> 	unsigned long flags;
>@@ -5003,7 +5024,8 @@ static inline void finish_lock_switch(struct rq *rq=
)
> #endif
>=20
> #ifndef finish_arch_post_lock_switch
>-# define finish_arch_post_lock_switch()	do { } while (0)
>+# define finish_arch_post_lock_switch()		do { } while (0)
>+# define finish_arch_post_lock_switch_ainline()	do { } while (0)
> #endif
>=20
> static inline void kmap_local_sched_out(void)
>@@ -5050,6 +5072,9 @@ prepare_task_switch(struct rq *rq, struct task_stru=
ct *prev,
>=20
> /**
>  * finish_task_switch - clean up after a task-switch
>+ * finish_task_switch_ainline - the always inline version of this func
>+ * used for performance sensitive paths
>+ *
>  * @prev: the thread we just switched away from=2E
>  *
>  * finish_task_switch must be called after the context switch, paired
>@@ -5067,7 +5092,7 @@ prepare_task_switch(struct rq *rq, struct task_stru=
ct *prev,
>  * past=2E 'prev =3D=3D current' is still correct but we need to recalcu=
late this_rq
>  * because prev may have moved to another CPU=2E
>  */
>-static struct rq *finish_task_switch(struct task_struct *prev)
>+static __always_inline struct rq *finish_task_switch_ainline(struct task=
_struct *prev)
> 	__releases(rq->lock)
> {
> 	struct rq *rq =3D this_rq();
>@@ -5159,6 +5184,11 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
> 	return rq;
> }
>=20
>+static struct rq *finish_task_switch(struct task_struct *prev)
>+{
>+	return finish_task_switch_ainline(prev);
>+}
>+
> /**
>  * schedule_tail - first thing a freshly forked thread must call=2E
>  * @prev: the thread we just switched away from=2E

There is, in fact: you have to have an always_inline version, and wrap it =
in a noinline version=2E
