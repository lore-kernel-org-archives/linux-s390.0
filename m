Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51D2269DB;
	Fri,  4 Oct 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066623; cv=none; b=g7cGlVgn4vQpUuWoMYxeLet/p/FhckiWxzZxJGI6cen5UfrdIWKM/rQQLhh5TjBIcLx1+yh9KcGqJT+pob+zZ7qY+bkKHqfbdk+zu8Uj+LdmGGtuqiGGG39Qu98R7bQXUfbyao6QppREkaElHafxiNIRXJ8BUw8Oi1y07jK1S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066623; c=relaxed/simple;
	bh=NbAZc4XqAhYoepvIRrPOZBK0dUQRKugFczYyr2FgpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeJYdjebvhXp9vnsfezz/EJi0MGDGmWfEQfsLN0bIkrI4RjDm4qboQp/e616kB/K/iGby8O7TmPD7S/JKpJvidnIK50wpvkOT5EY3IX9XPHnAFcApq5eIgYaAyTpc2RR533CP3AzkzkzjMzxewXgWBxnaQXZ4cz9MavJ0ccoV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD74c9jT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD74c9jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91934C4CECE;
	Fri,  4 Oct 2024 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066622;
	bh=NbAZc4XqAhYoepvIRrPOZBK0dUQRKugFczYyr2FgpP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WD74c9jTFtpRHuPWNrp1g4DxKJchoR3hZTGPJNHYIED0In1xMhPzjK0KXf7AodtAr
	 zIC//k6awwpKN9Y89yoNt1ppQpz8nYi77aHlgP1bfy2E2p/K5cCy8IQXhfIglMpg88
	 T84MWLUhNExXk4Sz9Ez+2NHbkviI+16SSWDJYktXWDmJlccLtxbL1DSv0hg9ifvSu3
	 Msvi7exJqedKk1oM8EdkkbbCwiAHf/T8q/jKF5YOC/1MRuozGdOqVBQrF+q3l4ufOd
	 XxuHymcGhzEQnQUSVfK/xTT4qHOGhWn5zNk5mUtrdWziE1CjlKCnBjNNbVqUObi3Pp
	 VIUmWQXmz4lJw==
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
Subject: [PATCH AUTOSEL 5.10 09/26] s390/cpum_sf: Remove WARN_ON_ONCE statements
Date: Fri,  4 Oct 2024 14:29:35 -0400
Message-ID: <20241004183005.3675332-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index bcd31e0b4edb3..a9e05f4d0a483 100644
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

