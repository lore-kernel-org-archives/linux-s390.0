Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B1DF251;
	Mon, 28 Oct 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145716; cv=none; b=U+BVLyh9TqfupN1ZgM6qS4GhjQMNuE2QgdHEntPwfG08MYqsTqhlSupDyt2O+V+azXxlnjBVJSxRxOznTj46Zfed5vvJvjTl7cToyI6s4QuG/SubTZN5TvvP1jcprgqCQfuzfMdOMIE+Hcnq91JzEDrNCaH49nOnoSUV4G3xV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145716; c=relaxed/simple;
	bh=alW+GZ8j4gr7HOS6AYR6GnNg+XUrR8zbkobMAqgoutU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT7kSElYRIhUGhK642uMRlG37LjSKXRWy2RTk4CYxY6xQi4SM/xRhdOFloB/zIg+T8gdcvp2yEKqHln6lt2t1Ubj4cfjZJIuackGoHozcb8lPTsKTN/ERr8S+FimOebhhE+GuCvIEcZ3h8EUbES4kIDFJPJJFY4ZLygdvryZLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0GFnts/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0GFnts/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FCFC4CEE3;
	Mon, 28 Oct 2024 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145715;
	bh=alW+GZ8j4gr7HOS6AYR6GnNg+XUrR8zbkobMAqgoutU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0GFnts/HH7g1i+lsxOpuLi4QYSaND0fJXLT3IUJtoLNU2PhsriDE0LRde5cACpFs
	 32YkyxajMqH1RU4ASTYuqAai9cCqC3YiAKH6vBIyPterVOGYOK6UKovJKllML5RD+s
	 XPPB3OIS8doSyAzwSt1YcP9iteYMem+ef3eQJNaOuJICMq82X+WZK/SgiewO/5ItX/
	 ceZ4qWtd/dIEr37jIzhiMVsqvu+70fd9uf+0p5gFoUtZ7VT/aNbYcGjAuLGb2O2V75
	 C1HgmCz/2kX/iFjjkJVm1VQ67xtLQFv4sOAEr4QkYqiEhpRbMlJcfDJMODbrivS7NZ
	 J5q0aEvSb+Dng==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 1/2] perf/core: Export perf_exclude_event()
Date: Mon, 28 Oct 2024 13:01:52 -0700
Message-ID: <20241028200153.1466731-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028200153.1466731-1-namhyung@kernel.org>
References: <20241028200153.1466731-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at it, rename the same function in s390 cpum_sf PMU.

Acked-by: Thomas Richter <tmricht@linux.ibm.com>
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
index 5b765e3ccf0cadc8..d1398b23113b5b1a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -996,7 +996,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
 	cpuhw->flags &= ~PMU_F_ENABLED;
 }
 
-/* perf_exclude_event() - Filter event
+/* perf_event_exclude() - Filter event
  * @event:	The perf event
  * @regs:	pt_regs structure
  * @sde_regs:	Sample-data-entry (sde) regs structure
@@ -1005,7 +1005,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
  *
  * Return non-zero if the event shall be excluded.
  */
-static int perf_exclude_event(struct perf_event *event, struct pt_regs *regs,
+static int perf_event_exclude(struct perf_event *event, struct pt_regs *regs,
 			      struct perf_sf_sde_regs *sde_regs)
 {
 	if (event->attr.exclude_user && user_mode(regs))
@@ -1088,7 +1088,7 @@ static int perf_push_sample(struct perf_event *event,
 	data.tid_entry.pid = basic->hpp & LPP_PID_MASK;
 
 	overflow = 0;
-	if (perf_exclude_event(event, &regs, sde_regs))
+	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
 	if (perf_event_overflow(event, &data, &regs)) {
 		overflow = 1;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb908843f209288d..68c5001ea3102581 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1648,6 +1648,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
@@ -1831,6 +1833,10 @@ static inline u64 perf_event_pause(struct perf_event *event, bool reset)
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
index e3589c4287cb458c..6960c15f85b1a5ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9989,8 +9989,7 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	perf_swevent_overflow(event, 0, data, regs);
 }
 
-static int perf_exclude_event(struct perf_event *event,
-			      struct pt_regs *regs)
+int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 1;
-- 
2.47.0.163.g1226f6d8fa-goog

