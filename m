Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D894734D4;
	Thu, 10 Sep 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038054; cv=none; b=FvQR6rHrh/qjzf/sxqjljwdA3bKUbGtOWoLetD6tAd0ImO5yeID6j3B8TLnPnZI+Ux60bnZUjZgtX5VvjDhfzB+legDcGYpfLUZYN4vcvqM/rkLg/2PsBWQ8S3pdeofpYiSH3YMWije+J6cszfFPbeL0AYQCT/pGb5m5O7IqvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038054; c=relaxed/simple;
	bh=msniaosZMR/qwh9gdvOXvUlhttFaDmHvFelXNEpOfZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut22XjAA8adklbcvCFvNzbn6HjD9FzqU7c/8Bz0vyK9zS+am2XmKMiBKQPiJarUBwPT0S7bjcjYEaGhcKyDoTb5UJzaK0GW1JYRjL3CuhnDfvqX6gIY95IdejpPQVgina9UeLrQwxbVTrvZa6a7jniIBleVZTP3XByP+JrkhlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRH9KEeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRH9KEeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B7D1F00893;
	Thu, 10 Sep 2026 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038052;
	bh=ZWoW41+x+7dy6umxK1i5p5XUicgKN/VyGWTHRTGB5Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HRH9KEeXmVngHNuUOWNn8xRQ7/eO7kzWYtRlf+g6+nsRcMThfVn9XAQD7WHChf76P
	 FSxx9uAhqbsd7WTBRzgkgGXMKpvQm3hhb+2UXwcaflcaa+Xq/aBK0WH2zmQmQRbl6B
	 9jBegERP4F5Lw7JkfAPVn/8+S9jcWcFxYPObvewN0Cjon4pVFmcLF6YiI5VJmBZqaG
	 NVyDFo/84Wz0EMbhl4ZudmUN0ZfhyXRjSERYm7cbU8UNzjHcE8dy0cLzEeXNTdZ+TD
	 0jU+f+UoD7kVR31vSAjE6ZloSuZhJHbQvO7kTLWD6A4ujSu36NzkNGkBu5gxrpj9Pk
	 1GxVloef6tfOA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:15 +0300
Subject: [PATCH v2 13/13] s390/scm: Use kmalloc() for SCM information
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-13-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
In-Reply-To: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

scm_update_information() allocates the response buffer for the CHSC
Store SCM Information command.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

While on it, use __free(kfree) for the local response buffer.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/scm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 171212a6d2d9c..b79fe023ab8d1 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/cleanup.h>
 #include <asm/eadm.h>
 #include "chsc.h"
 
@@ -224,12 +225,12 @@ static int scm_add(struct chsc_scm_info *scm_info, size_t num)
 
 int scm_update_information(void)
 {
-	struct chsc_scm_info *scm_info;
+	struct chsc_scm_info *scm_info __free(kfree) = NULL;
 	u64 token = 0;
 	size_t num;
 	int ret;
 
-	scm_info = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
+	scm_info = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scm_info)
 		return -ENOMEM;
 
@@ -250,8 +251,6 @@ int scm_update_information(void)
 		token = scm_info->restok;
 	} while (token);
 
-	free_page((unsigned long)scm_info);
-
 	return ret;
 }
 

-- 
2.53.0

