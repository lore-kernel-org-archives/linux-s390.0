Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F771E04B1;
	Fri,  4 Oct 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066674; cv=none; b=e/MLCXgrT1sSrejRlMdZUPbxl1UR9tJmvjCV+IEREUmPftfvdrlr+3zb95FEuj0fovyDE7MrD/X+DbaOZ/5o+0OosWjmiG69Qy7rfQuFgEgOfMI/RWbyQWTS2/Lm1ch9p/EBFJps1Z6Eogel90LTqJog2oJK7gTBKhZ2kTWm9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066674; c=relaxed/simple;
	bh=kvOXRNJdLSkFt19dQGORrV4xUn+I7ThF4IlOi+Fs/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP/Ehorg7lyhfDm2Tz46cPVtIMv07TqIQtBTWTA+ZmM84b0aawmlecnse5UNdMwVlYAo/PIwDDnNuYlEXBTpNvp5bGK9oMwpPeT5d6eLTVqUH6qDWdmvwr6AxU6thmN4m+BBUkQmEIkpIy+mg+kmBdBcZPaJUvHTRA6FThJr9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D76lt81Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D76lt81Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643E4C4CECC;
	Fri,  4 Oct 2024 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066674;
	bh=kvOXRNJdLSkFt19dQGORrV4xUn+I7ThF4IlOi+Fs/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D76lt81ZCT3xCpVnKYdHduWXZaRX1J2ZDk4HZY9uH8H0RudBezA3eeqN+nt27crYl
	 D7P1Vg80X6mUW9K0FQFdA3RlBtAPdU3KpCOumaLR2RRbNoqsMrMylEEta4uVEKVkGi
	 1x+oU11qvTSpNQL+jPGa9hEs6uIZ9H22IGf4W3UDhqjrBZhb8nffvXP7KP81+VlxjI
	 TdgjjraBh4f+mDmr3pY1FBRDN818SBGPHRuFvtTY7tQcygWW8WDZ7HAkeBs+02DMDA
	 dAd1yV+kFpMoK9BjIFZX26j93fp8w8HksGWWILT7MYOI9aNf2vq7VrQHh5M/ZvS530
	 mVRMa+9CqV45Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/21] s390/mm: Add cond_resched() to cmm_alloc/free_pages()
Date: Fri,  4 Oct 2024 14:30:39 -0400
Message-ID: <20241004183105.3675901-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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

