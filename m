Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0845DF72;
	Mon,  7 Sep 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776650; cv=none; b=n2Mhe/0ISyEtl8GXfAxQaC1roU4WI0FHSlxXa397CIU4XXVDo0eXZvDa4TP8FtnYinsSRqkILZDHlVjvl59FGo+kQGVNmQgOJvDvRyXob/3cESNVxDN/8JbfuoYvtFXdocoHM+3rhcE4YPuhRbvqCjmSAXtvRfzIMOJAjkVSD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776650; c=relaxed/simple;
	bh=OPEjpdpHJ8HkCCzkXsbFMzy/C+tLBx1daKwtN+9ZOAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITYBbyv1ZVWN63cpbMIwOeA92ZEfCpBA9bJVYUpNFZNLXyCtuqLpXjDPJz6Fii4D46EGZY86Icb2DDHYLMSfEnzwPLppD64XPT+SzmqDR8Uda0/AWcoIt4bRyqVOCiTrEH/Hjc2oWiHm0vqFqiYAXVlknov10/LyviyDlpvbjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoHeM4em; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoHeM4em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521541F00A3D;
	Mon,  7 Sep 2026 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776649;
	bh=NE/c7IMcBZdCzVyFsxXaIo3nYpN6KWCimcqlbKV3gw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aoHeM4emORpWMhclCvywlqazbQ5frAqBkDcwKeVvznG5SaQO/7btyXum+zi11LO3V
	 ferVo6XUuN8HzdP6oBkuuUDL47THLj5VO+aafzPuBgybQwn9IpGSQ62Y2VzOUCqlh3
	 R0K+Q8GEx9e9Bvepo9ngdYugleEuMlYQXreqUIt6ZSJdhEFVFrpb2B6B83LY3i4zc/
	 i9Y+juUJMqY2qopO1CDzCOFUD8cGwx6l3pJwi/V6ehTilgomSbTPUlX8Ewsx2gpAs8
	 tNYNXgSadOVAjGHXAKW5cUlXIp74SzeWA5YgzwFGoeZzJFBwHt93DDERYES5AHdc0B
	 X/uTY83VzVKXA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:46 +0300
Subject: [PATCH 05/13] s390/cio: Use kzalloc() for CHSC work areas
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-5-ca7f39806234@kernel.org>
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

chsc_init() allocates the work area for CHSC commands and
qdio_allocate() allocates one for CHSC calls during qdio_establish().

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, change qdio_irq.chsc_page to void * to get rid of the casts.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/chsc.c         | 6 +++---
 drivers/s390/cio/qdio.h         | 2 +-
 drivers/s390/cio/qdio_main.c    | 6 +++---
 drivers/s390/cio/qdio_setup.c   | 2 +-
 drivers/s390/cio/qdio_thinint.c | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index c3186c0a372b4..d98f629e89295 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1143,7 +1143,7 @@ int __init chsc_init(void)
 	int ret;
 
 	sei_page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
-	chsc_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	chsc_page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sei_page || !chsc_page) {
 		ret = -ENOMEM;
 		goto out_err;
@@ -1153,7 +1153,7 @@ int __init chsc_init(void)
 		goto out_err;
 	return ret;
 out_err:
-	free_page((unsigned long)chsc_page);
+	kfree(chsc_page);
 	kfree(sei_page);
 	return ret;
 }
@@ -1161,7 +1161,7 @@ int __init chsc_init(void)
 void __init chsc_init_cleanup(void)
 {
 	crw_unregister_handler(CRW_RSC_CSS);
-	free_page((unsigned long)chsc_page);
+	kfree(chsc_page);
 	kfree(sei_page);
 }
 
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 4bd4c00c9c0ca..dff5f53a8795d 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -244,7 +244,7 @@ struct qdio_irq {
 	int perf_stat_enabled;
 
 	struct qdr *qdr;
-	unsigned long chsc_page;
+	void *chsc_page;
 
 	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
 	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index c1e09fa34e774..d137bf8c70664 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -934,7 +934,7 @@ int qdio_free(struct ccw_device *cdev)
 
 	qdio_free_queues(irq_ptr);
 	free_page((unsigned long) irq_ptr->qdr);
-	free_page(irq_ptr->chsc_page);
+	kfree(irq_ptr->chsc_page);
 	kfree(irq_ptr->ccw);
 	free_page((unsigned long) irq_ptr);
 	return 0;
@@ -986,7 +986,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	 * qdio_establish. In case of low memory and swap on a zfcp disk
 	 * we may not be able to allocate memory otherwise.
 	 */
-	irq_ptr->chsc_page = get_zeroed_page(GFP_KERNEL);
+	irq_ptr->chsc_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!irq_ptr->chsc_page)
 		goto err_chsc;
 
@@ -1006,7 +1006,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 err_queues:
 	free_page((unsigned long) irq_ptr->qdr);
 err_qdr:
-	free_page(irq_ptr->chsc_page);
+	kfree(irq_ptr->chsc_page);
 err_chsc:
 err_dbf:
 	kfree(irq_ptr->ccw);
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index ea09aadaae4ec..bd80703c174c7 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -253,7 +253,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 		if (!ssqd)
 			return -ENOMEM;
 	} else {
-		ssqd = (struct chsc_ssqd_area *)irq_ptr->chsc_page;
+		ssqd = irq_ptr->chsc_page;
 	}
 
 	rc = chsc_ssqd(*schid, ssqd);
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index e167aa75c3dff..a2ff51887537f 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -136,7 +136,7 @@ static struct airq_struct tiqdio_airq = {
 
 static int set_subchannel_ind(struct qdio_irq *irq_ptr, int reset)
 {
-	struct chsc_scssc_area *scssc = (void *)irq_ptr->chsc_page;
+	struct chsc_scssc_area *scssc = irq_ptr->chsc_page;
 	dma64_t summary_indicator_addr, subchannel_indicator_addr;
 	int rc;
 

-- 
2.53.0

