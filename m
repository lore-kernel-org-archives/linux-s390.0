Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174D46C844;
	Mon,  7 Sep 2026 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776663; cv=none; b=kTlr+7kSu4HQE84Ce3fk6Lcdm/DbD+rzLDqtoLD6Lsf+EYNZm2V3EeKxmFtOL8/aJ+QILSSU9rxRU5cvavHRLShXmx3Xf8TeIAtFpk6tzF04MYFGaYKVFCH5lhpq1PX9BliM2Yd5L0O5gCVefLSVV33OWSpBmDHdwQJU7Nr1fZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776663; c=relaxed/simple;
	bh=mtOtfyMdOqH0xfQ8bkfVoHr2KD00v8RMd2IJU/hSLno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDgGfPakMii11SgCpXvM3P1wHre1bVUttaQJvjBjvu+tA3mBAKSjM58TQDfVxZ2Cb/r0ZZZpPHQAzwLpY0rjm1uqkMPkm65ns/poPbZdaPo2nrhD5HX3RIxYYTolnrIQf5TdwfTLLoPazZdFkRiR80m3EYk+VPD0m5/xMI2jNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJI3p6NQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJI3p6NQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCCF1F00A3E;
	Mon,  7 Sep 2026 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776662;
	bh=IId503ozKlk3cLt2ZvHKfnW0uEA0aXfpIbl0Bze/AnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CJI3p6NQLSFnQpujvGnuTo3rRXUwQLT1SIbJL+qhR0l//VBMu7zVfI8MW9VVEHCD1
	 A5o8GtGZSuVUt8esWePoLVon2FWWNlFflXhI9T3ZbE+5/NZH8rfUDs+2qF/6AlcZDE
	 swiluBjtOYD42LYLyt5+KUkfPzoR1fs1LPkr3+oiqakvqoRPBDO0aW67oWImCRGAJQ
	 V7q1ry7sRho63rWNnkWZjzFKeEgnd5HH4v5VR5ZEkgU4T8RCisUntlkFgfktSOFLIv
	 A2qXHUH9wUJKLUjp4XTZ+jZR7AHfq9iTRq1U/SUUe3a0WD3Qpgn+xvQypPPC8bj/rD
	 0STxseZ4bsSCw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:50 +0300
Subject: [PATCH 09/13] s390/qdio_main: Use kzalloc() for the QDR
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-9-ca7f39806234@kernel.org>
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

qdio_allocate() allocates the queue description record (QDR).

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
 drivers/s390/cio/qdio_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 6b9442bae7ffd..bebc1250ebebf 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -934,7 +934,7 @@ int qdio_free(struct ccw_device *cdev)
 	mutex_unlock(&irq_ptr->setup_mutex);
 
 	qdio_free_queues(irq_ptr);
-	free_page((unsigned long) irq_ptr->qdr);
+	kfree(irq_ptr->qdr);
 	kfree(irq_ptr->chsc_page);
 	kfree(irq_ptr->ccw);
 	kfree(irq_ptr);
@@ -992,7 +992,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 		goto err_chsc;
 
 	/* qdr is used in ccw1.cda which is u32 */
-	irq_ptr->qdr = (struct qdr *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	irq_ptr->qdr = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!irq_ptr->qdr)
 		goto err_qdr;
 
@@ -1005,7 +1005,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	return 0;
 
 err_queues:
-	free_page((unsigned long) irq_ptr->qdr);
+	kfree(irq_ptr->qdr);
 err_qdr:
 	kfree(irq_ptr->chsc_page);
 err_chsc:

-- 
2.53.0

