Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9322F91C;
	Fri,  4 Oct 2024 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066722; cv=none; b=V7hmhvD6mKF1M5SWmDSWL7gdq4EDr2w4iUcEqXmfnEli7Hb2zA5owN5LYpmze2kaRKJRUiXPVTcnRlM5zdNbd/8AOEHKC0GGHrRVBW9MdA85LDyklY9m1SkiCosxZAXfW0wcHv2dVJe0ONz2ru6ujPSTvOnSydVYpx8JllijQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066722; c=relaxed/simple;
	bh=waVMDUFT7sb+E8tgQunJbtH3Yyf3ZMBrv6AQqmFaCNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB9hnbWP93L4EOacCEtVxLrE8plhBEo7v8DLwOl8zqk5tC13K+TqOnqeekQvF73RTC4iXq/YIub9x1H/cs9udCJrvvkdQ4EF7vux9huF1hES/AJMEeQCMz0J0HbloLf7VS4PLTToVmbS9C8DsgKNyzZG/MioD1UCluAkUnxiyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4E5QtjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4E5QtjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2F9C4CEC6;
	Fri,  4 Oct 2024 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066722;
	bh=waVMDUFT7sb+E8tgQunJbtH3Yyf3ZMBrv6AQqmFaCNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4E5QtjXnddPJKDXHE8MGyANXNYL+S6Ggp9ghUxywK9QirYUeqpm//qeEJczTx9/D
	 O9tLbvcBA2XPFVwf44lo1wgVGoXv9GY96GjpXuo9PxHax2KW2jXmWqMfJREX7qXmha
	 DY0e4WSnknrg1gVozRmdn6LHGyH9iH4v0TQz/MhH+/nPjP6uLq9+GTiVpz6TorHM9s
	 xmvZSyOHHk6QBVdBUBUjTzulVojxhS/V2njFHtxhoH8VeePUy29bdZZr93EoTLRE9d
	 wEVPBQuLgWShHkb7hfbYspYRGYTp00eV8iI+/+Nmh4s1h51n4ezDS0CcgG6f7UtMZJ
	 1iiC/+5kkmSmw==
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
Subject: [PATCH AUTOSEL 4.19 07/16] s390/cpum_sf: Remove WARN_ON_ONCE statements
Date: Fri,  4 Oct 2024 14:31:34 -0400
Message-ID: <20241004183150.3676355-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index c8e1e325215b8..c7f94b5d93968 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1360,7 +1360,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	unsigned long head, base, offset;
 	struct hws_trailer_entry *te;
 
-	if (WARN_ON_ONCE(handle->head & ~PAGE_MASK))
+	if (handle->head & ~PAGE_MASK)
 		return -EINVAL;
 
 	aux->head = handle->head >> PAGE_SHIFT;
@@ -1528,7 +1528,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
-	if (WARN_ON_ONCE(!aux))
+	if (!aux)
 		return;
 
 	/* Inform user space new data arrived */
@@ -1547,7 +1547,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 			debug_sprintf_event(sfdbg, 1, "AUX buffer used up\n");
 			break;
 		}
-		if (WARN_ON_ONCE(!aux))
+		if (!aux)
 			return;
 
 		/* Update head and alert_mark to new position */
@@ -1746,12 +1746,8 @@ static void cpumsf_pmu_start(struct perf_event *event, int flags)
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

