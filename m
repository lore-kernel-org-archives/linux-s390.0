Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEF1A76B5;
	Sun, 24 Nov 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452132; cv=none; b=itc2914F6ClyD2GQHpfswlkpNkU5jj1itGlCN2ux/R61RI9nIwmZImHKHZNE0rxoEwUL00UmbejBVLSMP7bHWq4RPtZDtFcvcODJ8g8ym35eRLXzsNIv1SLnBnkq163CDPVW4j+WVFKII8d0ZQyTTfybFSObE8ap9+ipXw5//1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452132; c=relaxed/simple;
	bh=TclN3FuxER+VgqurAwKnGUXiVgQPJrAJQ/ER7xaZn6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4KW1C1Hq30OyHCS3LOiOJeXgX3OGZ5rQDPFUareyLqrHGTEkHioYrQcp8n90oZMaq8gNXNmbp3Lf5mnWbXv45t9TCrB3DVpFu9nPsXWs3FMWUVC+tsQPoc5Z+IHzX96vt4mjBIlCFSE/M+Vo+KcdiWWgTGB658X1ZEQOOk37mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPccgkak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPccgkak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89181C4CED1;
	Sun, 24 Nov 2024 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452132;
	bh=TclN3FuxER+VgqurAwKnGUXiVgQPJrAJQ/ER7xaZn6M=;
	h=From:To:Cc:Subject:Date:From;
	b=mPccgkak0yfJy/7Oi5+XaN5Uus2XmvbRKHlQqM/uO0/m3CLRx0WzOvsqbsci6R08L
	 OJHlvoKBjS7Ryjy0zeYjvK6/8Ol6AE717S4fJfdyOk1JExZCbDzbdK/We+Po3lPo7B
	 bchrC7oXYA44+JfnXc4o+vKC7sPhr9i/ryciTW9YLROIsmBiUcAnL23pJqY9W6vJPI
	 yRzfxD0P66z97zwjIUNEW4nVxpduOPsSh9dgxHcrTfOPSM4KnoO6ZGF/FLvboTY7BN
	 0hI7v3pUE9WbgWoaDZnirWXrtxYQty6M1PwbvM8H79dD4BXPp+/otZFPA0H0yzQ9sJ
	 4ETfWYsMDFLlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	sumanthk@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/5] s390/cpum_sf: Handle CPU hotplug remove during sampling
Date: Sun, 24 Nov 2024 07:42:00 -0500
Message-ID: <20241124124210.3337020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit a0bd7dacbd51c632b8e2c0500b479af564afadf3 ]

CPU hotplug remove handling triggers the following function
call sequence:

   CPUHP_AP_PERF_S390_SF_ONLINE  --> s390_pmu_sf_offline_cpu()
   ...
   CPUHP_AP_PERF_ONLINE          --> perf_event_exit_cpu()

The s390 CPUMF sampling CPU hotplug handler invokes:

 s390_pmu_sf_offline_cpu()
 +-->  cpusf_pmu_setup()
       +--> setup_pmc_cpu()
            +--> deallocate_buffers()

This function de-allocates all sampling data buffers (SDBs) allocated
for that CPU at event initialization. It also clears the
PMU_F_RESERVED bit. The CPU is gone and can not be sampled.

With the event still being active on the removed CPU, the CPU event
hotplug support in kernel performance subsystem triggers the
following function calls on the removed CPU:

  perf_event_exit_cpu()
  +--> perf_event_exit_cpu_context()
       +--> __perf_event_exit_context()
	    +--> __perf_remove_from_context()
	         +--> event_sched_out()
	              +--> cpumsf_pmu_del()
	                   +--> cpumsf_pmu_stop()
                                +--> hw_perf_event_update()

to stop and remove the event. During removal of the event, the
sampling device driver tries to read out the remaining samples from
the sample data buffers (SDBs). But they have already been freed
(and may have been re-assigned). This may lead to a use after free
situation in which case the samples are most likely invalid. In the
best case the memory has not been reassigned and still contains
valid data.

Remedy this situation and check if the CPU is still in reserved
state (bit PMU_F_RESERVED set). In this case the SDBs have not been
released an contain valid data. This is always the case when
the event is removed (and no CPU hotplug off occured).
If the PMU_F_RESERVED bit is not set, the SDB buffers are gone.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index a9e05f4d0a483..fc45f123f3bdc 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1896,7 +1896,9 @@ static void cpumsf_pmu_stop(struct perf_event *event, int flags)
 	event->hw.state |= PERF_HES_STOPPED;
 
 	if ((flags & PERF_EF_UPDATE) && !(event->hw.state & PERF_HES_UPTODATE)) {
-		hw_perf_event_update(event, 1);
+		/* CPU hotplug off removes SDBs. No samples to extract. */
+		if (cpuhw->flags & PMU_F_RESERVED)
+			hw_perf_event_update(event, 1);
 		event->hw.state |= PERF_HES_UPTODATE;
 	}
 	perf_pmu_enable(event->pmu);
-- 
2.43.0

