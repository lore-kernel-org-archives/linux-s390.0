Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDE1DD530;
	Fri,  4 Oct 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066543; cv=none; b=afv2Z3P21Af11Ps6ix1NcGdkd1NI7QDFxKSkcxiDcFKw29SNzHgi3+c0htjXJKiTL1TbS6TMuVZzPxcyS1z9JrQUfpqvo0PYuDeEu8PZ9bX38LSCUzq3gmtzOM1dwYMLcpjS0J4nvp8/wxl58z+8LTVvmPpW8SEBUZUYuiefl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066543; c=relaxed/simple;
	bh=otjOsiDz4bTanHKzYuDkhYA9yxCY++MDYjkxVF0KTtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE1gWb3UQsQRCHpMcze+6vZt0i0VK//dXP2v3JTJIi0P35JMqDJi/Jt9gQsRGFFZyIv4thVdGS+jROQ/P+RsYUTcDSJKPpuKIefq+tYRkR5VzyH/g7pRqlPOF+R7UoUHkJ7xhCaLnV+VIezEQ0fqJaA3/PVDLMqI9V8ZIwqrhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTliVDpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTliVDpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC21AC4CEC6;
	Fri,  4 Oct 2024 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066543;
	bh=otjOsiDz4bTanHKzYuDkhYA9yxCY++MDYjkxVF0KTtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTliVDpo8QIFkMft802N8KKWVPg15hTZmeN7SEa/M/016MGhMQ3fXH8Z7F3A5tPd9
	 r7XPA0FHQRhTQ8IgLcLtHCHqD9k0CeXqkR6jmCHr/w8LlMlpnDEW/USm/YmjG2squF
	 hwR4230Gck/VMquUbOG9IsFeQxTI8wSzwYjjn53DiZQ8M1fjedCRtJWfihWeJ7PIOg
	 8pVS4rPfBvr5AggMD0CFfeE+7CJujhomAHRe6EuZYI/CjnvNSr0GL+uiY0NiYLDy9j
	 +pUP8WOEd1z9dEXVmkyBCytCJiMEAvWNI154dx7Dw/FjwPveVVGOwJg0j48i8NOckx
	 lDnDusrXcGT4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/31] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:28:12 -0400
Message-ID: <20241004182854.3674661-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 1141c8d5c0d03..9b4304fa37bfc 100644
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

