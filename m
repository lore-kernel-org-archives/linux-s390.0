Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A21E3DEA;
	Fri,  4 Oct 2024 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065926; cv=none; b=K+E57OcLWMHqTQzcgGA6xyjVNk8cNGtEyCm0kTI57I7xBaxzrphOpA3K8aCeVeOYPwDKtHPCioJeKo5cCYdJrewlgLEb8jJFBAwPdBHBbhIbcjYoXfKuMP1dglyyKVi7WZUW4MhPKUIArp2xHaYHs44uafueqOOD/E58QsErd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065926; c=relaxed/simple;
	bh=YC4rSi+hnY8p6yLMjL4fnGcd6qKC8fBqYXPbjodsqSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBPqKGhOQCsSLAqNQ/7lEfhaaXpVSXYSl55yviT11nEDNngmH1Fq447WybiBt7LCf4DSeEwTUS7kS1MoiO1mH4naeB6G8CxnxG8crQp5CabwsQrojEhWc4GB0EKPTvcVWhnNE1G225UAEA0W+3WXPXx4rvFZeF9iDQg7Q0PU9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzhGrlTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzhGrlTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C1DC4CECC;
	Fri,  4 Oct 2024 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065926;
	bh=YC4rSi+hnY8p6yLMjL4fnGcd6qKC8fBqYXPbjodsqSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzhGrlTsepb1mIHT0NbqNPGMZRnkXG1BD1U0w5zBvidfligxCqVI8nkEVsSC7QUYz
	 KMO434LkAXTFDXDzfhNt5oIFLBTEOfcKws8En6kOwwuzgvWqURgbMLNn2rZDioStG3
	 qDuVlWZDuVGN5LOqBoRYPQDrLwZQ6NehZBmjisvLad5Tkm+KIM+FHxYxgnHH8843d9
	 YmvWUSe44TB/i16nfkVgY9nX/XLiEDUgsuvp4NmtKuXX7CpDwyzf3sfuuOkBrA4vG0
	 mOp6QC0Lfsj/YXjCRSrg2oOMUmfb410QoKrqHlB1Br8Q3VbE2hdn//XvzOLe4tEg6O
	 BDTBv+/IZTWWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/76] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:16:26 -0400
Message-ID: <20241004181828.3669209-9-sashal@kernel.org>
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

From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

[ Upstream commit 131b8db78558120f58c5dc745ea9655f6b854162 ]

Adding/removing large amount of pages at once to/from the CMM balloon
can result in rcu_sched stalls or workqueue lockups, because of busy
looping w/o cond_resched().

Prevent this by adding a cond_resched(). cmm_free_pages() holds a
spin_lock while looping, so it cannot be added directly to the existing
loop. Instead, introduce a wrapper function that operates on maximum 256
pages at once, and add it there.

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/cmm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 75d15bf41d97c..d01724a715d0f 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -95,11 +95,12 @@ static long cmm_alloc_pages(long nr, long *counter,
 		(*counter)++;
 		spin_unlock(&cmm_lock);
 		nr--;
+		cond_resched();
 	}
 	return nr;
 }
 
-static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
+static long __cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
 {
 	struct cmm_page_array *pa;
 	unsigned long addr;
@@ -123,6 +124,21 @@ static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
 	return nr;
 }
 
+static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
+{
+	long inc = 0;
+
+	while (nr) {
+		inc = min(256L, nr);
+		nr -= inc;
+		inc = __cmm_free_pages(inc, counter, list);
+		if (inc)
+			break;
+		cond_resched();
+	}
+	return nr + inc;
+}
+
 static int cmm_oom_notify(struct notifier_block *self,
 			  unsigned long dummy, void *parm)
 {
-- 
2.43.0

