Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CF325483
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952223; cv=none; b=AbApAFC+XA8ngy85ynp4lmRmChT/uxmzV1FOgXqpkLvNQg40wcXPEmaei8C3RUKYpdVajJ2RQBCWSUkEGS8x+CaP/+IpQqP+tI771YdlOehkTAQ2EpJU4KLwm5c47xrJR0qsOHjYhyVVdXsxiutVyXlSHMgaGZvBNvrYd7kWSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952223; c=relaxed/simple;
	bh=0W+lmlcV9C5yqRxvTAz1kwFUlI160nEnCfrhCLbQsD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFC9wPKXaOjRnT3E2AnMAYKuyf+m7baGJ9tmQvLHJhOO8XtGSzts2fzF6a/VvjktRxwqMs8xoxYl73A84D5pRK+cqL+/IZwg8YrxZVNlA6QcuV+SkuM+FjVEbqQOgOeon2Xu1TxUUhBRaMhp3aMW4Rs1lXqFxMLAS3GGyPqsbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCS3m1Q+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCS3m1Q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDE21F000E9;
	Thu, 28 May 2026 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952221;
	bh=FSOArdLBMJZPWR4I2DAlMFzLjd28CAELRljaoq5X13I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SCS3m1Q+YzkrHU6h8H8QfiuhoIVX85Wm2b4XHovYDoapYSXjT2yuSkjWrA7769zX4
	 Cnwjkum8fIYauGz56eyMFw5fIcKBNheRU0tNCaUTgqXhOxKg7BWsV09M2ftilywmpl
	 R90tW8oG4Mj8Ydhdkg6d2O1MzIUpcgBkx/jbNVlrpbllZTA7P0QDrIHv1gZJBkGCrk
	 qk3Qt+dbgzaoeiTG6iDFNGuaowwNqJWUO4jEwpilu2J4UHTvTVa2Le5Jc/0lvyXKFa
	 8AQLmxFGVguZiJOxSPu+X9TwOdcPXmnGDzW/lDVltX6apHdQHuQQoD46DnruoryfLi
	 0JezzdY3Ygv8g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:53 +0300
Subject: [PATCH 5/6] s390/trng: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-5-b7108f54d722@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
In-Reply-To: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

trng_read() allocates a temporary staging buffer for CPACF TRNG
random data before copying it to userspace.

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

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/char/hw_random/s390-trng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
index 3024d5e9fd61..5520f66274b3 100644
--- a/drivers/char/hw_random/s390-trng.c
+++ b/drivers/char/hw_random/s390-trng.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/random.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <asm/debug.h>
 #include <asm/cpacf.h>
 #include <asm/archrandom.h>
@@ -67,7 +68,7 @@ static ssize_t trng_read(struct file *file, char __user *ubuf,
 	 */
 
 	if (nbytes > sizeof(buf)) {
-		p = (u8 *) __get_free_page(GFP_KERNEL);
+		p = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 	}
@@ -94,7 +95,7 @@ static ssize_t trng_read(struct file *file, char __user *ubuf,
 	}
 
 	if (p != buf)
-		free_page((unsigned long) p);
+		kfree(p);
 
 	DEBUG_DBG("trng_read()=%zd\n", ret);
 	return ret;

-- 
2.53.0

