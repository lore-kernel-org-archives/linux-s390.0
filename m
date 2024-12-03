Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D71FC7E7;
	Tue,  3 Dec 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249083; cv=none; b=Kb7JQxvABi9idK9E0XYCf33I0XAKter+kiz7sUFWI/IXH/M/GTLqbP0IxW72nckBI668mShiGHXBj0FBPOaSiuhUd2Xq6rNw3QOhdN7gW+zB7WWGa2+WG/BDF+pGKVsz+qIJUvynCr0rgyTx+2gwxgtWBP+77hjw9tL/6JWxxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249083; c=relaxed/simple;
	bh=L4BkkKXTWvXmMfLn0RL6KeEHKDcuO56tiD37MnLutg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHziIZAA/C2nTUypAEZDzOwnSP29lbjQl7vktzo4zpHMPj23WLDMu+MSE851e55FzeZS4fvhv7zdS7CMle+DYvHS79U1ls6Qhi3solS042UysyLCCAdepDQ6iZtPkf5Rc9vgKT1qRGH/N5W6tebn9oDb/zYj53MeRpd6tMMjq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgbFiohB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgbFiohB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0750C4CED6;
	Tue,  3 Dec 2024 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249083;
	bh=L4BkkKXTWvXmMfLn0RL6KeEHKDcuO56tiD37MnLutg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgbFiohBsH/JTSqPwJps3HwoZwk6/6ppcl+lWIPQ5HCMfj5Vhe+qkqVgvu95WJtSI
	 SgipJV+KwH71M1yriIsYzZ354vj7RR6SBPcow4dEpMaCgaUzwNJInKFoDOd+oE99+h
	 LgBJxJkSAbXlJ4VjE4GIkFUOZY0pAKwpFz/CjZ56PkT/YuP1LXiSGyBdE7NRCTsxPU
	 YmgG2jsopH7Lh3cxAvfra7B6VKeS+XPjNPKM54BqyCpyQVhJib4mMXuRxAJBcrA89/
	 jtQbSnw1wvAfyzpxmZ9I+yu2gPOLKJJXajtNri0OrDzpfK/LSozVv9o0mHksfPchfe
	 F1V6UrdAFeo8A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 1/2] perf/core: Export perf_exclude_event()
Date: Tue,  3 Dec 2024 10:04:40 -0800
Message-ID: <20241203180441.1634709-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203180441.1634709-1-namhyung@kernel.org>
References: <20241203180441.1634709-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at it, rename the same function in s390 cpum_sf PMU.

Acked-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 6 +++---
 include/linux/perf_event.h      | 6 ++++++
 kernel/events/core.c            | 3 +--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1e99514fb7ae3db4..5f60248cb46873ea 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -981,7 +981,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
 	cpuhw->flags &= ~PMU_F_ENABLED;
 }
 
-/* perf_exclude_event() - Filter event
+/* perf_event_exclude() - Filter event
  * @event:	The perf event
  * @regs:	pt_regs structure
  * @sde_regs:	Sample-data-entry (sde) regs structure
@@ -990,7 +990,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
  *
  * Return non-zero if the event shall be excluded.
  */
-static int perf_exclude_event(struct perf_event *event, struct pt_regs *regs,
+static int perf_event_exclude(struct perf_event *event, struct pt_regs *regs,
 			      struct perf_sf_sde_regs *sde_regs)
 {
 	if (event->attr.exclude_user && user_mode(regs))
@@ -1073,7 +1073,7 @@ static int perf_push_sample(struct perf_event *event,
 	data.tid_entry.pid = basic->hpp & LPP_PID_MASK;
 
 	overflow = 0;
-	if (perf_exclude_event(event, &regs, sde_regs))
+	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
 	if (perf_event_overflow(event, &data, &regs)) {
 		overflow = 1;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bf831b1485ff5b3a..8333f132f4a96cff 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1690,6 +1690,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
@@ -1895,6 +1897,10 @@ static inline u64 perf_event_pause(struct perf_event *event, bool reset)
 {
 	return 0;
 }
+static inline int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c6f6c286b2d8d1d..1089c41b63c1e683 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10081,8 +10081,7 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	perf_swevent_overflow(event, 0, data, regs);
 }
 
-static int perf_exclude_event(struct perf_event *event,
-			      struct pt_regs *regs)
+int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 1;
-- 
2.47.0.338.g60cca15819-goog

