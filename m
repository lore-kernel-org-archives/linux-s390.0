Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FE20D9CF;
	Fri,  4 Oct 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066447; cv=none; b=bv0H/nJqFqC6vMHZXWUDA1y/K/v0XaG8FAWAPZP5PnWCXbeeXL93iayrmIuOoAdOTwsGFfwlm0vg2kILa61bTVzMxj80szQynF1M3V1FITIDPkQL6xKw0SJtUe21ry9XjYNfVGfpXLYRBHfJeIwy8MlGED3pWCGCdB1RiO85X4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066447; c=relaxed/simple;
	bh=q4yL+SJ+F1XeQsOq8Y8jFlNT8NBvrQhYPz7C9FZjtCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiXWle3oD9ob6BbTKOY7hWZK4GsxlAVSvWJI+Q55ABMhh+mPedyvzxMGB0KXSktDy6CRsdKWT042Gcnx+u80Hb04WU0wh6GT4tQ7QAvSlHXlsyjMVjR4JTh7919/bBKI3WIezftzUD7tVH+WUGNUEAwm45ch3zvDMgbouFWQE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctm9mBdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctm9mBdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9AC4CECE;
	Fri,  4 Oct 2024 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066446;
	bh=q4yL+SJ+F1XeQsOq8Y8jFlNT8NBvrQhYPz7C9FZjtCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ctm9mBdhwjAEExdUocOKjU2vo/yDrVZFS2ClscbWTUfrCPR3LRaLehwJfckitqL7Y
	 8dg4/IhGk4mYsOn0UImull4AF0ogsSPl/oLQOdzZ4jwCPu/WVskB5nSbjLU1MZvJ4E
	 VXwy/8r0a/ctce5aBDadtLpGtOQdnJKfQ74bgzXVF0fkU1J8uC+LGZ1RrXepQZutkh
	 o0IAppL+yRBsfTCw1B3b3cqQJLLA9QckKwlPDCCZQJcIDU47dpk6/gpcO21lZsvPaM
	 9Hyq2aUX/bGQPqpe0sfyvHwdP03J8GOGcaQd4LGo8PjDl1ItplFZtOGTEBMjlp49MY
	 0cSgF+D/OpoBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/42] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:26:15 -0400
Message-ID: <20241004182718.3673735-4-sashal@kernel.org>
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
index 9141ed4c52e90..02e030ad38c5f 100644
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

