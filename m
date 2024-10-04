Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4A1DD867;
	Fri,  4 Oct 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065939; cv=none; b=J65W0gVnmAwGosKnV9hcdmEr71PHqgcw16HLW/DzlnpmLyXW9hPxn96VKL+EkNlr9lNfM/ucSc1+lbSRKuAjX12FkA9U8TW7HcOgPV+vDQMpITVcPT6ZkLJa8PDSFElfSsBS4nRmMkC/s6GiecS65+BCKBb72Ob7aKk/OiKLTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065939; c=relaxed/simple;
	bh=OPg7FRb0kBq7ivezil0fQ06/cg//Z3nwebfuiYFWQvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/KLVbuwlpUvLg8SkbfY5f8BNaSKyyozZL6ZB9+sxcBAWM87kT6rcQJ7TubHw5A8PsBKFfU2oem5uDpk85pzI7E+Wn8crCp2yEBFhZatOj6R2BOh0ShuAcZkrLU5bGaIPlH4Zbq6TX9tz5H0/0SQPmWI1YOpTi7MCw2BSOR7z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVEWhAff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVEWhAff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CACDC4CECE;
	Fri,  4 Oct 2024 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065939;
	bh=OPg7FRb0kBq7ivezil0fQ06/cg//Z3nwebfuiYFWQvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVEWhAff2WTAHa7Csze1fmmKk3KvRxVW+yq8xlfrJwi8g2UXbKnODjM3VkX1/BQ4v
	 3kcEuPP0BzjbcAN8kjsDzSJt+rKNxnsO9k1mEdJxH42w7pbaO1LV3/ttVaA2VcLqgn
	 yzZFUP5KkJ3uRmGS5UN9aSdeMHevuFSAHEIqTci8fULbSbyOXnPlFUgTwkDYv6Abso
	 wgFhzsQH58RHg8JaQTkbVf/EkhvHDOEiHsIfLE09Lj6+RAJsKJiOVHLGuHpWg6tdxL
	 S+uQwxO3wV1883MVAu8MZtZq8pn9HN7pO8Z2yYxNElqMlFhc3ei6S3RK0lQ0wcu05p
	 YZTsXhEvF9TvA==
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
Subject: [PATCH AUTOSEL 6.11 17/76] s390/cpum_sf: Remove WARN_ON_ONCE statements
Date: Fri,  4 Oct 2024 14:16:34 -0400
Message-ID: <20241004181828.3669209-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 736c1d9632dd5..48fa9471660a8 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1463,7 +1463,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	unsigned long range, i, range_scan, idx, head, base, offset;
 	struct hws_trailer_entry *te;
 
-	if (WARN_ON_ONCE(handle->head & ~PAGE_MASK))
+	if (handle->head & ~PAGE_MASK)
 		return -EINVAL;
 
 	aux->head = handle->head >> PAGE_SHIFT;
@@ -1642,7 +1642,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
-	if (WARN_ON_ONCE(!aux))
+	if (!aux)
 		return;
 
 	/* Inform user space new data arrived */
@@ -1661,7 +1661,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 				num_sdb);
 			break;
 		}
-		if (WARN_ON_ONCE(!aux))
+		if (!aux)
 			return;
 
 		/* Update head and alert_mark to new position */
@@ -1896,12 +1896,8 @@ static void cpumsf_pmu_start(struct perf_event *event, int flags)
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

