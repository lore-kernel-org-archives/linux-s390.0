Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0C2009D6;
	Fri,  4 Oct 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066317; cv=none; b=unQhogdtXzvzS4hYqY7NVAkXtw2o4Rz3LLMWRJl4GPp4DIXnGQ49rng3dk+d12cnJlsDbXiCd/3Av5Em9Bx/mE52NkhVZRb8Zu70SXrOyabXNw9mXV/p2aeGUBW8lk2XMtaut38JgurcPAu3232Dj8fL0LgJLstAoyAj1hOlF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066317; c=relaxed/simple;
	bh=Vi/hAEYFq7ePieRuHfB5bHqTlziodram3DiEVl1OKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quGaLFj4s2ceBW6Q7BdO0skFCwI1X506Q3tPDbHXCOcdWKfEbG1bPr0tvNWuc4RuN9pdTR7uo6jlnE5lEuI28uXKzaq/v6yAYUcgFHfF+NObewaKuu+KeQERMKvYMKSp0AKcUkdqSR2eJttJLEooyf+0WYiRYv3nUn0Y/6KJ/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrVILWpS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrVILWpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046AC4CEC6;
	Fri,  4 Oct 2024 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066317;
	bh=Vi/hAEYFq7ePieRuHfB5bHqTlziodram3DiEVl1OKTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrVILWpSdW6gRrMduIp/RAyhVpvlE64d/YkbsYUtsaho9T9MHVhPQLa/Idp0SqDg7
	 8TMFpiItHLk/SblXuQGsb40YEFdt3FYpLxuHLsewmaNq4dH0Pcsi6i+JRvzj4LTZKv
	 itoQZrS/Ckh25XF6zZZ/wRtSmn/RYp4C95CAjYPvbONJKw1deZqj6X47DuzfAcd+Vd
	 HI41W3fqnN0hqdV7IbGMdwGNU8m3fJOKyslgolGO1NIeuLicV8+xelGOXYrm1sn9mi
	 uaPkb7rFb6U5hDomUV4nf/fd3hAZdGMhrG+NBR/ESmM20b7p4scyBDiQuLafNvKcQ6
	 /tcAWrHOum0xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/58] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:23:40 -0400
Message-ID: <20241004182503.3672477-7-sashal@kernel.org>
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
index f47515313226c..9af4d82964944 100644
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

