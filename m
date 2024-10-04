Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9A1F12E4;
	Fri,  4 Oct 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066139; cv=none; b=NsjcZXmWjc+p+6N1zoKiBuo+Lfa+HNgaLK4p8CwojoFmGYuF2LjHUNUUFGK8pMwxvYOi5SV6Lg30UXvCbmEIJ9+2qNR7Zb8CpgLgzmHHFZJaS+Gk5o6osTKgK3zjpm04X6a4QIRjjPObzAfKl1+GxNMW7YfBdVgCLxygtqpMZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066139; c=relaxed/simple;
	bh=xdDEDjberbmf6Rz3El7XGRbMGSDdepN9AKwcrl4hKNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmcwHIxiVdvhYG3znMzA0bCDXwJ3uLqpB9V9pTlC3Jb7B/QAmugKAhJXv3cxkV6RHaBXDZxN9ecsHM9OR5ewTeKdbhmxsf2K/l3EqhAyjroKjj/SNH6XrDmNQfUrY00bDv3P3BV4hZ7Hquay7Ln1+nPNHxLcI438O55QvDVL/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ2r3De6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ2r3De6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E37C4CECC;
	Fri,  4 Oct 2024 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066138;
	bh=xdDEDjberbmf6Rz3El7XGRbMGSDdepN9AKwcrl4hKNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ2r3De6byiRPSh7Pg3zw3QhNeEWK/7d5IF7Nc+KJc3s7KWiMgJuyg1gYOnnoOepS
	 PotFQowT/LdqsGmoEn/X1DINyqxwcqv9j+etB1CeNHZLw+w6bHbZsVBbKQfU0+BT+3
	 ffpUglkzN2UrnB7dGaOpXtTMHMUJor4slAcJIxjXjaVlL2AR/4cYetpoBPE7vbra4V
	 dNDpeAdICXwjOyXm24h0sknQx7k3/bTALr7p3xckGjX8AodzIyHThcUu7ckWlXUMoj
	 nFpijtKSFrEAezFFuEO4VDAXYqJHEqdwGQp5JtMl4JShGRkNMDAvfa7jAfgGsiOvii
	 6vmcXiWQhXSaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 09/70] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:20:07 -0400
Message-ID: <20241004182200.3670903-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index f8b13f2476461..2549ac258733c 100644
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

