Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04937145B26;
	Thu,  5 Sep 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505830; cv=none; b=Jtu+cw49ZJ58aDCeDNw3asGmqep3FpUP5h9Ug1BJFJDnsBY2CanskKbYnhR4i2wfK3IhB30+FXqsLfM2KB1vE63BG8cqT/NSXlGMaEGZyAusWy8xK/RD9fHbNC/mXilTuJ4ZpalpTSk5SRogRsiLD80xU/IE/k47fApM0YbZ/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505830; c=relaxed/simple;
	bh=hCFzTizAoGoDsVUGq3EAWMcM65X29QRH/OHHwFMG7sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQh5UsDsg38x9alMY4FUz+Pu+J22DglTAfrvHOseUTchOCleC9LQ64hkML6JpkDjfiCTChPm9jLh+NVIRaS48tTMJPDjbo1KyfA+ABNoQ8RhV+1n0D8DGDurwDnaC/nRrTt8HmzatYHmZII/6165XaN5tap20TBv08tAH9Xdcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8ys7Ws8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8ys7Ws8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105AC4CEC2;
	Thu,  5 Sep 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505829;
	bh=hCFzTizAoGoDsVUGq3EAWMcM65X29QRH/OHHwFMG7sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8ys7Ws8jELO5HmNyglvZvTDDEciClaaVAuGb3ChDbtCt0wlBHxoeNJA0zE8W+BWR
	 g/TDXNMEIqwELQBILJ30xJ7TfCIzeZV3mW7JCj73LGczxQxOcz5L+hdXd7DswIUPp3
	 dJnQrzHOh/oRvKMamVsERZwbQwG3Sh7Nrz8IRSRmttD151vj1ntjArnCtlijOcGZSt
	 FBKcy0pDCFdTIsEvpeNUE+88AZTzBUVLbvusiqTAieIu7MPUtGFn0N0L7c51mziyD5
	 UrLRtc8XpcKowRc02PjGIWf110u5F9k1xu3lJpgHcvSqU+dawQlhOrolnLFW3WiFZG
	 20bWWx97cSMbA==
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
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 2/5] perf/core: Export perf_exclude_event()
Date: Wed,  4 Sep 2024 20:10:24 -0700
Message-ID: <20240905031027.2567913-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>
References: <20240905031027.2567913-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And increase the dropped_sample count when it returns 1.  Now it can
track how many samples are dropped due to the privilege filters in
software events.

While at it, rename the same function in s390 cpum_sf PMU and also count
the dropped samples.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c |  8 +++++---
 include/linux/perf_event.h      |  6 ++++++
 kernel/events/core.c            | 11 +++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 736c1d9632dd554f..f663530ae1f6ba5d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1074,7 +1074,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
 	cpuhw->flags &= ~PMU_F_ENABLED;
 }
 
-/* perf_exclude_event() - Filter event
+/* perf_event_exclude() - Filter event
  * @event:	The perf event
  * @regs:	pt_regs structure
  * @sde_regs:	Sample-data-entry (sde) regs structure
@@ -1083,7 +1083,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
  *
  * Return non-zero if the event shall be excluded.
  */
-static int perf_exclude_event(struct perf_event *event, struct pt_regs *regs,
+static int perf_event_exclude(struct perf_event *event, struct pt_regs *regs,
 			      struct perf_sf_sde_regs *sde_regs)
 {
 	if (event->attr.exclude_user && user_mode(regs))
@@ -1166,8 +1166,10 @@ static int perf_push_sample(struct perf_event *event,
 	data.tid_entry.pid = basic->hpp & LPP_PID_MASK;
 
 	overflow = 0;
-	if (perf_exclude_event(event, &regs, sde_regs))
+	if (perf_event_exclude(event, &regs, sde_regs)) {
+		atomic64_inc(&event->dropped_samples);
 		goto out;
+	}
 	if (perf_event_overflow(event, &data, &regs)) {
 		overflow = 1;
 		event->pmu->stop(event, 0);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 955d39543398afb0..aaa4bc582d2f1d4e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1634,6 +1634,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
@@ -1817,6 +1819,10 @@ static inline u64 perf_event_pause(struct perf_event *event, bool reset)
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
index 4d72538628ee62f4..8250e76f63358689 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9978,18 +9978,21 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	perf_swevent_overflow(event, 0, data, regs);
 }
 
-static int perf_exclude_event(struct perf_event *event,
-			      struct pt_regs *regs)
+int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 1;
 
 	if (regs) {
-		if (event->attr.exclude_user && user_mode(regs))
+		if (event->attr.exclude_user && user_mode(regs)) {
+			atomic64_inc(&event->dropped_samples);
 			return 1;
+		}
 
-		if (event->attr.exclude_kernel && !user_mode(regs))
+		if (event->attr.exclude_kernel && !user_mode(regs)) {
+			atomic64_inc(&event->dropped_samples);
 			return 1;
+		}
 	}
 
 	return 0;
-- 
2.46.0.469.g59c65b2a67-goog

