Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F81E1C03;
	Fri,  4 Oct 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066716; cv=none; b=NtH7vWSzFt1qvUH2oXcSZNXp3UDOIiIYC2GDs/1w9m88YaPSbgvVfBq1Dhw+OVhEyg+V8q2S4j6azNrnhqwbDJovWdNvsfeFGalkPHuH+43CGwDD4FZTZ78V8iWAyJI9qU+BZJOSphPMxhcHGO6EPxrFIkvNQ3V0qXsz6Jez18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066716; c=relaxed/simple;
	bh=kvOXRNJdLSkFt19dQGORrV4xUn+I7ThF4IlOi+Fs/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0JvY2Jog2/qV2MVJ2DBKeWxXs7+X2Dlwc8PElbcTHnnZ+OV+8jQFIUzN0krjwxPiQKPswGBCORikh828KQmTqy4nU0hHDedG0gHW56ynJMV4jZgOYZa14GYg+OrHmCL49DNSoKKb8xoLZQov5VZamST8CZXgd1n/gtSWxBr0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKhEuOnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKhEuOnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3FCC4CEC6;
	Fri,  4 Oct 2024 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066716;
	bh=kvOXRNJdLSkFt19dQGORrV4xUn+I7ThF4IlOi+Fs/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKhEuOnExWtfiwfn7kFgQWn+qYhigIgFeabg0O2isdPSwfLwyyEpOYLisMgEMUC0G
	 7+DtQDKRHfjnBzQErLHnSuBjKLdUQ07yALMWNhXn906u+GoPnKvk+UtQzmhBFXeYqB
	 46J96y2Q5Iifsn6/Wb8najFsueZO5TfxiPYPkygONne4mAJOKN7zngyiz+vPiCH1cm
	 Qi7x3oZGmhpM82weHwZy/lsrTdZ187jbLYgAbh0ocRg8D8EAGJ6LkPoY1NI1mQYy4R
	 gy7+bX99VU6ifDntWQox0hK1waYHjPZ+d4oHQkqWGBhzwIw4mqz8uodAglezKR9pdC
	 8KgcG8aVfVqjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/16] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:31:30 -0400
Message-ID: <20241004183150.3676355-3-sashal@kernel.org>
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
index a51c892f14f3e..756aefbd05249 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -98,11 +98,12 @@ static long cmm_alloc_pages(long nr, long *counter,
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
@@ -126,6 +127,21 @@ static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
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

