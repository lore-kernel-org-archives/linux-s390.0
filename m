Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8E472F8E;
	Thu, 10 Sep 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038051; cv=none; b=NDSBI2zmpCZRldA/ffivMQ+YotC56PxQK7UNuPTkMpX+dFzGX0wb9aBpAJre3dfaL4MsPm0RFGJV9WYYtqhxSxw8OVk+KK1oqVeCyrS27sAc6qPsgjuWMs5oQEi0zAEmXz3B2sGNZMOHOOE12UzSHaLFTtQ8Fg8rV5hi29icCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038051; c=relaxed/simple;
	bh=hgFVRlQObA6IRobzhqyVXdoXC8mayCY0Z2IgxlZSSuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNDEH7ulRaxR1h5aFCtNEkW2F959YM0jbYbXwIpQOh0TRLoTaQdBRaueO4/QeB4DCh40hfsXiTipOyx3765XTdDyOiA9vjG18XLnot4i0TULP1cgRdR3GnzXMDSdCg9jxNUKFVQ2aM+4rmj+GgiaHTigWBcBUqzw9K+ZAIW1mxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqW3X5Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqW3X5Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D96D1F000FF;
	Thu, 10 Sep 2026 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038049;
	bh=owHwZKjYQNBsdmW9cxprXhtWaMjXxhcOEf9UsPq09Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VqW3X5Jv3ytuz7FUfg5yJqnTnWHxfa2f8uOh13f3L+szD9grS+b3XD6tZXP5GYz7i
	 Rn8nqxn2FR17hX8vFXFoIhx78KAuzao+pXVvnHiAp1GulFNzIeMxX6VlSIhJdDr2ij
	 PodkZYtf6VW+xOFO5I5EDQCidWQnHw+s21fK+KtDkOrKIf030lBYrf9ccB+mryU1A+
	 zuEN+4dny8qUUT2jzRbjpxFLYHY7DJbnf9sIkJztLzG7tixEHkxtIYQJab0SoE2Qkb
	 NtsF7X5HbVomohr15bWvmHFVLS+vNpcSyTtJ3CJetjLekTxePYfkf8LuSbSJ+uyhEA
	 L77q5T8Iyf3Og==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:14 +0300
Subject: [PATCH v2 12/13] s390/qdio_setup: Use kzalloc() for the SSQD
 request
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-12-e931086fdde1@kernel.org>
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

qdio_setup_get_ssqd() allocates the request block for the Store
Subchannel QDIO Data (SSQD) CHSC command.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 7ca8f61a2387b..c0215a7d29a81 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 
 	DBF_EVENT("getssqd:%4x", schid->sch_no);
 	if (!irq_ptr) {
-		ssqd = (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
+		ssqd = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!ssqd)
 			return -ENOMEM;
 	} else {
@@ -270,7 +270,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 
 out:
 	if (!irq_ptr)
-		free_page((unsigned long)ssqd);
+		kfree(ssqd);
 
 	return rc;
 }

-- 
2.53.0

