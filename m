Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE418FDB1;
	Sun, 24 Nov 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451971; cv=none; b=BniQmS49/gFm/2srO+JCV5XVE/63AfrEEwHEFXV0j/FzuEgCOZg2sjE7b9TYQlp7ufzubPyn596WPPqvCdMEH+fOXulnMYscU8Vfa5eOSNlsmq2NpQD4RI1pXroQ3agxIMCYTdr+OgmMvjB8/NMIu1Gzh/0Q2MNwSSfdABc7NsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451971; c=relaxed/simple;
	bh=lt/xhLG0XxpPJyokMTkxMdrDM510uvu9wg9/ipp1So0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azsGw0sE5qaD0kqN3E0ZH+7tk1Nesnk1mrdS9RWcBti+wddsxhZ/gpv0SlcRMZ3vNazYq8K41HpoX6JNIzEFHjH+2WmEw08QZEsAnThwAomdSyswHgz7L8nSzX9HgGtlPO+3yC+a4wO67ZdwkKEhDruWpnKvRKMdmCfXDl/eJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuZZTIp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuZZTIp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48108C4AF09;
	Sun, 24 Nov 2024 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451970;
	bh=lt/xhLG0XxpPJyokMTkxMdrDM510uvu9wg9/ipp1So0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuZZTIp33/ygQsNKJ1wGwCK1Img2r+g1R4eF1AllmM1WQh1/nuihWSWKkeT8QKXr+
	 /N30U01qtzeUiXDdXDErQft7Lgu8ofCXx7qgS3Ax6WwKcTL1YfXXEaqLpvaf6lcUK2
	 krOvWD6t/a8C5qu5tKx1dNY/YUV0b+fABRExA0ELlUR3S74msFk93E6cJC6cZ9HMe8
	 axdT6UsYpBl+o+x01H6lAYlSFgq/vmzefylSBfmA+hO1FKqio3os1YQi5weBscfKg7
	 cYy82quE7VpobzCwBsjYfhKT9fG0IshKx1rT38ZRWTECL66SmJpPsSBF9oyXjGJCG2
	 aKk1CzCfz9HlA==
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
Subject: [PATCH AUTOSEL 6.12 06/19] s390/cpum_sf: Handle CPU hotplug remove during sampling
Date: Sun, 24 Nov 2024 07:38:41 -0500
Message-ID: <20241124123912.3335344-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 5b765e3ccf0ca..625833a1dccd6 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1780,7 +1780,9 @@ static void cpumsf_pmu_stop(struct perf_event *event, int flags)
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

