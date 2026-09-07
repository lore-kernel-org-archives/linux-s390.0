Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87445FFD3;
	Mon,  7 Sep 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776660; cv=none; b=f7AwKjQT3IVNYa/Vy/KD2tQoktPuVBY52vNWD4IWnGlUDZQmUaGZCLAlJuYV0b8U+6+bE4GKRucJ3wWcxIHeRACyHag2UtB1Lg4kJ0uh4iXipzqtnRJHaD32Tb7kZvuQDsB7oJMt4Y4OkutCRZYr9K2naF8mZkoa7DYfhLiXo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776660; c=relaxed/simple;
	bh=3sAPPrYjjnm9HdvgPt5xKjpVN7wtPx7zbwR8Zj84ydw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ec9SnHqyLZqzWRwhLwnOXysBqF4nXXSLw0+RzB1eSa14XgA1k0gw+s6ErB9qDl5fxc8sesthQzbdaQtGaCvJ4PV9HBxrA14KWGxn114gPdHOvNClezA+OUMVSvRw1PpaZDJa6rP09VLGWmXyEYPPFTAUPQKtbBMJbCK6GDKEVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqniO50X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqniO50X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406441F00A3A;
	Mon,  7 Sep 2026 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776659;
	bh=HdnExtof1dKOLJGTwa/OAp5uv9yMjbL/vk77sD1NPEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gqniO50Xnm5LZ6TI1YBZUE3boTXiiXtNpaUeMHZ1dhx2wnceBAZAlHathU9YU+5+h
	 +6XIiGTfOwr6F5D/o+vgVHo3uJ0bU6MvJvnTDYNBdrCKd3n9YniIPnO4v3HIJGtFMM
	 mnERPheRMSTGehIkkax0QzNZQXB8j9ZUw9vzWgzeeIYIYgtfYywhQG9KFvxWXRPlg+
	 E0PhUizv66lRAu5bMUZltm5s05v14CJm888V+ir6uhECVqNeWNp7j6hMi0D48l8ISx
	 WE5NJAqD9mJYOL2ONticmCrz0bJhpWcaAVOqU6hdFPGfJZHXs8cBWL1idJg+hj2Mh3
	 xpnNdGOPz4xZA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:49 +0300
Subject: [PATCH 08/13] s390/qdio_main: Use kzalloc() for the IRQ structure
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-8-ca7f39806234@kernel.org>
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

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index d137bf8c70664..6b9442bae7ffd 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/io.h>
 #include <linux/atomic.h>
+#include <linux/slab.h>
 #include <asm/debug.h>
 #include <asm/qdio.h>
 #include <asm/asm.h>
@@ -936,7 +937,7 @@ int qdio_free(struct ccw_device *cdev)
 	free_page((unsigned long) irq_ptr->qdr);
 	kfree(irq_ptr->chsc_page);
 	kfree(irq_ptr->ccw);
-	free_page((unsigned long) irq_ptr);
+	kfree(irq_ptr);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qdio_free);
@@ -961,7 +962,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	    no_output_qs > QDIO_MAX_QUEUES_PER_IRQ)
 		return -EINVAL;
 
-	irq_ptr = (void *) get_zeroed_page(GFP_KERNEL);
+	irq_ptr = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!irq_ptr)
 		return -ENOMEM;
 
@@ -1011,7 +1012,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
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

