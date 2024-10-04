Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02781D8DFC;
	Fri,  4 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066458; cv=none; b=HXpRUvWn2vNK1WCJSHH7PoEvbmwAkmuEPLmi0EhLSq/yYUjpWu8w6+EGEhML4zFxWvM6RUqdmG3/HuCd2oaSY2cf/ZZURE8jBYf40p/1NFEymQhlzjwF74DXY3UL1KJEArFMeZOfBs5SgP3+UCA+TOiHXsJRFil416Nq/gSFMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066458; c=relaxed/simple;
	bh=Y9psA9GJ+zTWRVNpbmy4Xh0upHgTBS5tRptwPGNdKQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXpDEGUux1sOMPSfb3I3cNb+iesAsu41KXOS/3tW5kR1mJkM2A0MWd3hsoLP7sr2U5/kHO/flsy/j4OTpmim5C8AL4OCodAqWt+ZUdtlZs8Q0q6vCqQbPCPDfzWXmIITIgWzeE6n+t4pZZxTn5p0nX74seCHm9L/BckW/PcSY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq+hKWNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq+hKWNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8C3C4CECE;
	Fri,  4 Oct 2024 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066458;
	bh=Y9psA9GJ+zTWRVNpbmy4Xh0upHgTBS5tRptwPGNdKQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rq+hKWNEewMkr0sFEUPsVlzb8FRFr8F8F3cS4WCPjVP3z4XSQpnOf2AqYC6QMYNdT
	 fecClM6tgOtd59E0PlRbH+EV+nV0Doy08K6aFJwkEYADBL1g+fQbgIH9Q8KE/pFTYH
	 8472ynDv+0AY2ztvEWS9bT2aUWaouOB9EpBjLnPP0HJ9dOag1IglXO+exL42SDfA7z
	 Am4/GEVqdoVBkUz9RbVEpxgoVV5CPqYm+h1NRnDRxQH3rJynqYAVEkkjLtQVKzxyTS
	 XC1rDvlhb9FTxme2wmz9s2RldIBLVUmj3QgS3GcA6MSFjnwSNPBF8xAlJ9P1Fu7cbF
	 eIQhiAdmEFejw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/42] s390/cpum_sf: Remove WARN_ON_ONCE statements
Date: Fri,  4 Oct 2024 14:26:22 -0400
Message-ID: <20241004182718.3673735-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit b495e710157606889f2d8bdc62aebf2aa02f67a7 ]

Remove WARN_ON_ONCE statements. These have not triggered in the
past.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index ce886a03545ae..f3b0a106f7227 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1432,7 +1432,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	unsigned long head, base, offset;
 	struct hws_trailer_entry *te;
 
-	if (WARN_ON_ONCE(handle->head & ~PAGE_MASK))
+	if (handle->head & ~PAGE_MASK)
 		return -EINVAL;
 
 	aux->head = handle->head >> PAGE_SHIFT;
@@ -1613,7 +1613,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
-	if (WARN_ON_ONCE(!aux))
+	if (!aux)
 		return;
 
 	/* Inform user space new data arrived */
@@ -1635,7 +1635,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 					    __func__);
 			break;
 		}
-		if (WARN_ON_ONCE(!aux))
+		if (!aux)
 			return;
 
 		/* Update head and alert_mark to new position */
@@ -1870,12 +1870,8 @@ static void cpumsf_pmu_start(struct perf_event *event, int flags)
 {
 	struct cpu_hw_sf *cpuhw = this_cpu_ptr(&cpu_hw_sf);
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+	if (!(event->hw.state & PERF_HES_STOPPED))
 		return;
-
-	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-
 	perf_pmu_disable(event->pmu);
 	event->hw.state = 0;
 	cpuhw->lsctl.cs = 1;
-- 
2.43.0

