Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EAF4963D2;
	Wed, 16 Sep 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560236; cv=none; b=AvzRkpsmuGKGLpSFt+bj0FvsExmG5RDGCWuLVsOP3jXePfRDfiO01L3b1d1LvJlZS7m+W+Vbo8TgdBUA9URocbLlmp+313FefvbyFZL+UJ2lCxaNLiAFDRuFPvQL/0//cyplBWD4XOa6xxhFcZd4G/gHiBjqL3Ko4qUGk6cDc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560236; c=relaxed/simple;
	bh=CnXHp1JkDOfwDEmuFIt1o/K8zCbiqBSR3yDlzthGbnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIG20WuMYtIaRkJI4eWzrqNATgEAb6VswfxnkwjWr73iKzvhRfdCHi/9TnRnvFkpcPOKIpnc3nl8tksxugzJWchh/3mg48o+w/wAFc2thnAzqa6BTWXkJYyMJawV+OBEmxRAJWOtvS0IL4IiHErVg69FZZSnHlWYITYPXpgLXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcm9fdtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcm9fdtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DE01F000FF;
	Wed, 16 Sep 2026 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560222;
	bh=U1G72EbqUjI9oNziOv0XdCQMAxirZYF5Q2JcgCPI+0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fcm9fdttTL0J5d54oDgnnaOXbfP4m62y8rhkTSL8Kso8AsVR22kr2n4xv6/XHwMSx
	 dS3wVkbutXH8B2SFDVIsezpqRL0A4rLC3FwhgQfoVLQAYdk8UyeeDeD1UGNmh8ws7i
	 RwE0f46pnD3le+Fbg4VsF2BERVktF0rEWHDize+t1pLKm5IenmrFkOPrvZc9ne+tr+
	 7J/jHraIIr9WUyc2UsGY0Ld7qZa9Rvw8t97K5xNZc2eJ3GtMQ8tc5484KNZUUe8U8R
	 G6eKu4er/FWQ+EerPBDSVJDjKuhU7qTM++2TSf1B654t2ZJrXj9fUQFWp9Qe484FU3
	 am52O0k6xVoHg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:15 +0300
Subject: [PATCH v3 08/13] s390/qdio_main: Use kzalloc() for the IRQ
 structure
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-8-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
In-Reply-To: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
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

