Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF1201DDE;
	Fri,  4 Oct 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066330; cv=none; b=S1v4OA3akrnByeYiMgGFfAq2qhuRrPxyhu82LVxpBqhVHtiBY/f6mLFmsFyAJJgrOEsCSBNGdx9IpNE/VRgd/ie/P1F3RYHfTNzsXxEsIn4MaO/619xCi/zHOUhzHm7opUNDauxF/1bcNp6DUJR2ulfW8roJGhYtWQcPeXAOb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066330; c=relaxed/simple;
	bh=9CJPsSFqQDwx8SIT94dFtp9RENCJgvhVDximLmdWC2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D81qwfamDsHZMDfMd2HnWOj1h8wR56QFGhtIEw+GdJ7YmFTL0m4r20w9lY4el399fXwMnrzZ/ymLKbZBNGNWRLtoJQOuH81jKMNLI+wzOyYO17OL7cnI+vFECyf20qEDAL0JR+neXNn8xQ4bKm3p7X8o8i6Cdhx9lv32+o/WmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJINxAY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJINxAY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB9FC4CECC;
	Fri,  4 Oct 2024 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066330;
	bh=9CJPsSFqQDwx8SIT94dFtp9RENCJgvhVDximLmdWC2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJINxAY0YPU+E9nAV56O/n6U22B86NfsJT7aQDFsPz9e5Qp2iEC6b05w+F9VbdSOr
	 qgTlNUIPx0sllx1p4EAfZClvIJ4074IkSkp49z1u2YdHsrSEpZc+3400mxJEE8H1Wg
	 B3tBs65FPoxw+Dsu/6yRCAlcoPQWa7T78fn2BOwRjYue2IPwhENTZROEQTq5a0jblP
	 XEoPP7hljtyZ1tvROAJBP/P6N1NWcOZkK4u+QMf5FzZfXsoDDJ3F3nIt7PG6CzEKL0
	 iAXWAqta8lgKPR95V+TgIdDUr3FIYsoKr27hZKVQIIM+XTuQCgAT8ujUwcJdw3fg1r
	 of7Hm3hcgdXRA==
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
Subject: [PATCH AUTOSEL 6.6 15/58] s390/cpum_sf: Remove WARN_ON_ONCE statements
Date: Fri,  4 Oct 2024 14:23:48 -0400
Message-ID: <20241004182503.3672477-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 06efad5b4f931..a3169193775f7 100644
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

