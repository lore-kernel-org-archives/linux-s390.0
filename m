Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786F3D16E2;
	Thu, 10 Sep 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038037; cv=none; b=KKSTue1c2FVjZS6nXqBHUggbga3JtrXg49Za+6ebUogx/crsMJrB1VZ9rSTEZ0othhizuDGTSkozGvErhkCm/1/D+O5WLpIohxiecXPjf9Yijn3WHLwz9KyTLfaWCGsPKUvULe5RGo6UGkvQNyLoLL11eSGga739inE46T3gjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038037; c=relaxed/simple;
	bh=CnXHp1JkDOfwDEmuFIt1o/K8zCbiqBSR3yDlzthGbnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKZUkP+E9I4p54tgOAGC0zZLhos6KK1wcmTZVH8G378Xn2Cl/bjhHsowHpqov9xGZHEjnt2QdrGawz5teNlzkEovjvhvqEx7kLJxeB/GFpEmwE5HT5+egUrQVcpM6/mUEG5Tuw+7J0xqEDVNl5sEuGR/A8G5p/kmG3BSg1NL6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVsepamy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVsepamy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF391F00898;
	Thu, 10 Sep 2026 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038036;
	bh=U1G72EbqUjI9oNziOv0XdCQMAxirZYF5Q2JcgCPI+0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dVsepamyflN4CWrmX4M5jdM3tEOFYmVaGJYyPMgYyQGltoCu/UE269px5Np++ntkv
	 /aZjvuCUE4Y91WOA9Stmag4LPGRYjgNTOCzTRYxGs7+08594wADyF2AAMrR/QyKEhB
	 teZsGft7BlpW8tIJuTju3U5vUx1MUaskToroQvtiXq43rJKHRmPPRUjBvD8h1CyIsV
	 J8NDJOsqVwu36YLRUbBFcMUQ2BXbS2xOpyRGKK/pg/BHBR/+J3pCXBjxgYnS5XsYkh
	 3Q1U+9JEMdFN26kZQwGgNYEgEsxWcjbky9eG/j4fe29P/C0I52z5XlZ0e4ORSIx8wg
	 YecKXB7wpxmNg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:10 +0300
Subject: [PATCH v2 08/13] s390/qdio_main: Use kzalloc() for the IRQ
 structure
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-8-e931086fdde1@kernel.org>
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

qdio_allocate() allocates the QDIO irq structure.

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

While on it, drop the kmemleak exemption for the CCW. The IRQ structure
is now tracked, so kmemleak can find its pointer to the CCW.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index d137bf8c70664..28eb8602ca97e 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -12,11 +12,11 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/kmemleak.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
 #include <linux/io.h>
 #include <linux/atomic.h>
+#include <linux/slab.h>
 #include <asm/debug.h>
 #include <asm/qdio.h>
 #include <asm/asm.h>
@@ -936,7 +936,7 @@ int qdio_free(struct ccw_device *cdev)
 	free_page((unsigned long) irq_ptr->qdr);
 	kfree(irq_ptr->chsc_page);
 	kfree(irq_ptr->ccw);
-	free_page((unsigned long) irq_ptr);
+	kfree(irq_ptr);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qdio_free);
@@ -961,7 +961,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	    no_output_qs > QDIO_MAX_QUEUES_PER_IRQ)
 		return -EINVAL;
 
-	irq_ptr = (void *) get_zeroed_page(GFP_KERNEL);
+	irq_ptr = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!irq_ptr)
 		return -ENOMEM;
 
@@ -969,9 +969,6 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	if (!irq_ptr->ccw)
 		goto err_ccw;
 
-	/* kmemleak doesn't scan the page-allocated irq_ptr: */
-	kmemleak_not_leak(irq_ptr->ccw);
-
 	irq_ptr->cdev = cdev;
 	mutex_init(&irq_ptr->setup_mutex);
 	if (qdio_allocate_dbf(irq_ptr))
@@ -1011,7 +1008,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 err_dbf:
 	kfree(irq_ptr->ccw);
 err_ccw:
-	free_page((unsigned long) irq_ptr);
+	kfree(irq_ptr);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(qdio_allocate);

-- 
2.53.0

