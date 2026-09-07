Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FA45A29F;
	Mon,  7 Sep 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776637; cv=none; b=eItpbELZhd0+RO+IfoNlL7MegUcskHfBkbPy033ogQKFjcG9txoctFQ2CgGm/gndfVyMVmgcfjwcg2xbz05V834swG6kVzG9i0sMgi4pg+v01CWb22FwUdOPdkrc9moRKSvueco72pbTghgX9zE2cZuIy89NeDnbYBqdfAX0nlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776637; c=relaxed/simple;
	bh=oaUUL2Z6uTL/fsueJ+wmiwF3r3nbRoUwtNTlWdzZV88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCFZiXvnF5/zg9T6IaUoTue91MFtJEDS+SpfC+zGxmkdleHpz+fzXf2tlUB7Hf5PDgzT63MRHqNO4veg9EIJpuIL2GhYvooTVPAEgShvaoI3ljOv8bUxxX3RKG42WsTwss/GcCxRxwfirR4JKw0yh+nEhiR/37AZ6IrGGYE8jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY1Jyyl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY1Jyyl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146981F00A3F;
	Mon,  7 Sep 2026 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776635;
	bh=waNeuygMDtlm0C03ZytfUl73M0zkpwkt1aPQuPSWLWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oY1Jyyl734MLI1IlG6XCXb4v/DmmBySm/AC8pfkMYVcXmqGkF/hjyTQcDBZD80YpJ
	 7uwhf5PYBWI28sW1JGHFu1y5Wk7Z1m56DS9JvQL6uy5HMyozhGkHivDmKGyskrTefs
	 o8LOAeDkyU0s82i4urqcpPwBeo2KcxJ84nLsV5dTDXRA8+mK5tjZhjSCMKk9p9nbvE
	 6op/bj4RPPJ2wBogea0r4eyrZUG1sz5JKKHs9i2ULWFzRm3kAptGou79gjiq59UcGS
	 410iiaD2OL6Lk030dIYPUJ8kUb2n2z+J/7vL+mr/OEQYBIHp0VFAz4I8GIG5gkm2hi
	 j5O4R0aXsVYIQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:42 +0300
Subject: [PATCH 01/13] s390/chsc: Use kzalloc() for CUBs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-1-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
In-Reply-To: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
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

cub_alloc() allocates the channel measurement unit blocks and their
extended counterparts.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/chsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 9689f722c863c..60a4a7e6086ce 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -931,12 +931,12 @@ static int cub_alloc(struct channel_subsystem *css)
 	int i;
 
 	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
-		css->cub[i] = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		css->cub[i] = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!css->cub[i])
 			return -ENOMEM;
 	}
 	for (i = 0; i < CSS_NUM_ECUB_PAGES; i++) {
-		css->ecub[i] = (void *)get_zeroed_page(GFP_KERNEL);
+		css->ecub[i] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!css->ecub[i])
 			return -ENOMEM;
 	}
@@ -949,11 +949,11 @@ static void cub_free(struct channel_subsystem *css)
 	int i;
 
 	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
-		free_page((unsigned long)css->cub[i]);
+		kfree(css->cub[i]);
 		css->cub[i] = NULL;
 	}
 	for (i = 0; i < CSS_NUM_ECUB_PAGES; i++) {
-		free_page((unsigned long)css->ecub[i]);
+		kfree(css->ecub[i]);
 		css->ecub[i] = NULL;
 	}
 }

-- 
2.53.0

