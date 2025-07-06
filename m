Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D933207;
	Sun,  6 Jul 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751771316; cv=pass; b=jHheDfP4LlqH0UyN4+KvWOKRB9DErCluBu+up803Huzek3N+wkU4FqfbK0Udbsy4KN9y/HwwGeOPsJjDQPfPC2JXJYKZjgK/c+chjlqHnTHe6Hawn5DCSgwq9GIcSG1nbdViCoCLpXiHqgGk5opK3mFwLfwlkE4zIwZ7oVcVZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751771316; c=relaxed/simple;
	bh=J6DPmMM4CoEw2rEmRprBuicLduxbutp6nC+XHSkbI0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ski2e6bn7gpogU56O8Qds+zZPz7bAzcgixQ3s1q0VPJ2nij70xGA79ulEFOOoXwOwBKeHzaJBy90mSzGRsmCALFFnL1NGdjxXvNYmT6Tsv7g2FoMWH9blz7ZCTDkqaQOKr4qpE4rsSj5q/Fm9mVvHET5gfaX5RZclKZ87Y+RqRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=n/85JIut; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="n/85JIut"
ARC-Seal: i=1; a=rsa-sha256; t=1751771224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BANOU2jht3RDtVqHFtPKzQFFX64aZ9pNNhCxDSPZ5o4rFU3pY8BB9ufK6On5Ro7fYeO5yUfmYRP2kJ7Q7pYdXa85MLJCtmgCyytA2rnEMGwQuzJxOfuCPX8WyXa383o2V5BxMEGz4EvWL8VRqdQbyrufidet65E3MLt/uxt3Njc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751771224; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=jePSSp++5Batv5PK3k9r42c2ScL6/PQrLL8WfPRMBYI=; 
	b=HtMuRgmCMpd0TDfSFbGbgHeQEzXnZTlNfJU3Q/AGKRSSEv/dpCDQE1AXqEaulX9dzvhEi7uPm8FkKSdeqEtBKxILLNi0ot7OK8z5Sjqs+u/2JIYPZHPnqMICM4Ve0rBx9i5IzBF8Js3DTe+/vpA27WfkyOzmTIfn3WqGnlp/eCc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751771224;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=jePSSp++5Batv5PK3k9r42c2ScL6/PQrLL8WfPRMBYI=;
	b=n/85JIutx8NKp8cgQQQcnme0fbNI1Md8Bo347hSfTgCCepfJwTHYrMoXbChrSoAL
	Jw533PBuKIhVmTsAQ+EntIH+85wGK7WQWwtVpgq71Sv75bSQAIKYgWZ5mjOci6vwFQl
	xJr7g9fZSvZx7KQKUI6AZ8JQwym7AHl5Rz89i6O4=
Received: by mx.zohomail.com with SMTPS id 1751771221451549.3655482599792;
	Sat, 5 Jul 2025 20:07:01 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Li Chen  <me@linux.beauty>," Thomas Gleixner "<tglx@linutronix.de>," Ingo Molnar "<mingo@redhat.com>," Borislav Petkov "<bp@alien8.de>," Dave Hansen "<dave.hansen@linux.intel.com>,<x86@kernel.org>," H . Peter Anvin "<hpa@zytor.com>," Rafael J . Wysocki "<rafael.j.wysocki@intel.com>," Peter Zijlstra "<peterz@infradead.org>," Sohil Mehta "<sohil.mehta@intel.com>," Brian Gerst "<brgerst@gmail.com>," Patryk Wlazlyn " <patryk.wlazlyn@linux.intel.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Bibo Mao <maobibo@loongson.cn>,
	Li Chen <chenl311@chinatelecom.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Joel Granados <joel.granados@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v4 1/4] smpboot: introduce SDTL() helper to tidy sched topology setup
Date: Sun,  6 Jul 2025 11:06:29 +0800
Message-ID: <20250706030636.397197-2-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250706030636.397197-1-me@linux.beauty>
References: <20250706030636.397197-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Define a small SDTL(maskfn, flagsfn, name) macro and use it to build the
sched_domain_topology_level. Purely a cleanup; behaviour is unchanged.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/smp.c      | 34 +++++++++++++---------------------
 arch/s390/kernel/topology.c    | 10 +++++-----
 arch/x86/kernel/smpboot.c      | 21 ++++++---------------
 include/linux/sched/topology.h |  6 +++---
 kernel/sched/topology.c        | 16 ++++++----------
 5 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0b..b05995e272134 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1700,28 +1700,20 @@ static void __init build_sched_topology(void)
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			smallcore_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
-		};
-	} else {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
-		};
-	}
+		powerpc_topology[i++] =
+			SDTL(smallcore_smt_mask, powerpc_smt_flags, SMT);
+	} else
+		powerpc_topology[i++] = SDTL(cpu_smt_mask, powerpc_smt_flags, SMT);
 #endif
-	if (shared_caches) {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE)
-		};
-	}
-	if (has_coregroup_support()) {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC)
-		};
-	}
-	powerpc_topology[i++] = (struct sched_domain_topology_level){
-		cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(PKG)
-	};
+	if (shared_caches)
+		powerpc_topology[i++] =
+			SDTL(shared_cache_mask, powerpc_shared_cache_flags, CACHE);
+
+	if (has_coregroup_support())
+		powerpc_topology[i++] =
+			SDTL(cpu_mc_mask, powerpc_shared_proc_flags, MC);
+
+	powerpc_topology[i++] = SDTL(cpu_cpu_mask, powerpc_shared_proc_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 3df048e190b11..ccf5dcc56f86d 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -531,11 +531,11 @@ static const struct cpumask *cpu_drawer_mask(int cpu)
 }
 
 static struct sched_domain_topology_level s390_topology[] = {
-	{ cpu_thread_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-	{ cpu_book_mask, SD_INIT_NAME(BOOK) },
-	{ cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
-	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
+	SDTL(cpu_thread_mask, cpu_smt_flags, SMT),
+	SDTL(cpu_coregroup_mask, cpu_core_flags, MC),
+	SDTL(cpu_book_mask, NULL, BOOK),
+	SDTL(cpu_drawer_mask, NULL, DRAWER),
+	SDTL(cpu_cpu_mask, NULL, PKG),
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 58ede3fa6a75b..55f09946c791b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -485,35 +485,26 @@ static void __init build_sched_topology(void)
 	int i = 0;
 
 #ifdef CONFIG_SCHED_SMT
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT)
-	};
+	x86_topology[i++] = SDTL(cpu_smt_mask, cpu_smt_flags, SMT);
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
-	};
+	x86_topology[i++] = SDTL(cpu_clustergroup_mask, x86_cluster_flags, CLS);
 #endif
 #ifdef CONFIG_SCHED_MC
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC)
-	};
+	x86_topology[i++] = SDTL(cpu_coregroup_mask, x86_core_flags, MC);
 #endif
 	/*
 	 * When there is NUMA topology inside the package skip the PKG domain
 	 * since the NUMA domains will auto-magically create the right spanning
 	 * domains based on the SLIT.
 	 */
-	if (!x86_has_numa_in_package) {
-		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(PKG)
-		};
-	}
+	if (!x86_has_numa_in_package)
+		x86_topology[i++] = SDTL(cpu_cpu_mask, x86_sched_itmt_flags, PKG);
 
 	/*
 	 * There must be one trailing NULL entry left.
 	 */
-	BUG_ON(i >= ARRAY_SIZE(x86_topology)-1);
+	BUG_ON(i >= ARRAY_SIZE(x86_topology) - 1);
 
 	set_sched_topology(x86_topology);
 }
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 198bb5cc1774b..0b53e372c445c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -197,9 +197,9 @@ struct sched_domain_topology_level {
 extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio);
 
-
-# define SD_INIT_NAME(type)		.name = #type
-
+#define SDTL(maskfn, flagsfn, dname) \
+	((struct sched_domain_topology_level) \
+	    { .mask = maskfn, .sd_flags = flagsfn, .name = #dname, .numa_level = 0 })
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e0205..e6ec65ae4b75d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1739,17 +1739,17 @@ sd_init(struct sched_domain_topology_level *tl,
  */
 static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+	SDTL(cpu_smt_mask, cpu_smt_flags, SMT),
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
-	{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+	SDTL(cpu_clustergroup_mask, cpu_cluster_flags, CLS),
 #endif
 
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+	SDTL(cpu_coregroup_mask, cpu_core_flags, MC),
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
+	SDTL(cpu_cpu_mask, NULL, PKG),
 	{ NULL, },
 };
 
@@ -2010,11 +2010,7 @@ void sched_init_numa(int offline_node)
 	/*
 	 * Add the NUMA identity distance, aka single NODE.
 	 */
-	tl[i++] = (struct sched_domain_topology_level){
-		.mask = sd_numa_mask,
-		.numa_level = 0,
-		SD_INIT_NAME(NODE)
-	};
+	tl[i++] = SDTL(sd_numa_mask, NULL, NODE);
 
 	/*
 	 * .. and append 'j' levels of NUMA goodness.
@@ -2025,7 +2021,7 @@ void sched_init_numa(int offline_node)
 			.sd_flags = cpu_numa_flags,
 			.flags = SDTL_OVERLAP,
 			.numa_level = j,
-			SD_INIT_NAME(NUMA)
+			.name = "NUMA",
 		};
 	}
 
-- 
2.49.0

