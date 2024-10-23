Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8155672;
	Wed, 23 Oct 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642171; cv=none; b=pccekiRCIsKG0D0bEDqluTuyIoU8EtEPpmZSr5eocKFF9AN2O5E5wm8ew2PK8ra+/cvf+hF+QWdiI3MRGOAf3yHH06kNcDrre0gIxRdiEgv5yPaiOgrrF6Zz+ZA7yGzK90BeG56heNzzUpa+WO9PGwqB176VRigoe1asDJZZlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642171; c=relaxed/simple;
	bh=A4QwPJQlw9zD0sZg2Q9Dv/Ayd2j8ALkZKSmR7YsG0Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMdCHckxg2PY41MsA9MXHe/5rMelqZGqsGwP/fw//syMSt6+8WOIZpxAqUv412xNEcnnj/Bv3j/hX36JFFvlTlEO9jajH+5+mPtrUvaFfyMpT+8kWXSGsrl6ZDdn14huaVAMQg2cyF6Y93DlJ8QiHeq9YY4zY2ff/tNphxiLzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exojCRsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exojCRsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53889C4CEC3;
	Wed, 23 Oct 2024 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642170;
	bh=A4QwPJQlw9zD0sZg2Q9Dv/Ayd2j8ALkZKSmR7YsG0Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exojCRsB+rVAk4Fj9T2SZgXmyFivZay4GulED0veFq/Md4DUyyHzd3UTkSZQnuxbX
	 X4OSqlZ4wglU9AbmYuA2VuDiwihXT+UgjZELujmRtRnpBwTND4zDoXzj/8IRrD2WsZ
	 wi/9V8X7zOAHZpmVAjIEvs4Qx5mfUXcCcc3Gz1kZWT4iiqNudCwS0w1cPw5ozdF3mW
	 lHrW+0/RInp+uzMxwCb7zw07C/JfTysoQoIXu//w7os/uCe9BGGAyKxHAGW/kwrbD4
	 HHOTR6w3Iyg5WGQe3o5+3jk/P78h5ZRQjxmUUFzyPJhs+oo/AbUNGGWiJWkZbZpp8X
	 cKa0VBnKFBnBw==
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
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v4 2/5] perf/core: Export perf_exclude_event()
Date: Tue, 22 Oct 2024 17:09:25 -0700
Message-ID: <20241023000928.957077-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023000928.957077-1-namhyung@kernel.org>
References: <20241023000928.957077-1-namhyung@kernel.org>
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
index 5b765e3ccf0cadc8..ff9e694f2be45c6b 100644
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
@@ -1088,8 +1088,10 @@ static int perf_push_sample(struct perf_event *event,
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
index c1e6340e561c400e..6b31958a2b1db8db 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1649,6 +1649,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
@@ -1832,6 +1834,10 @@ static inline u64 perf_event_pause(struct perf_event *event, bool reset)
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
index 7e15fe0a8dee4ee7..5d24597180dec167 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10001,18 +10001,21 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
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
2.47.0.105.g07ac214952-goog

