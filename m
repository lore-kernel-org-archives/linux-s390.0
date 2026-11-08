Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127762;
	b=HHz7mTi/MO5UVSbHNL5KBApDdvcLd2jp4trdID4pdb7j6yEz6LdSUKPi30MNWmggyFRP
	 SscJqNf1iYv9F00BWcHA/GVMe64j0EuT2JzvBRJD7XLxR3JEMs+a9Llb+VbWD0yoNddwt
	 lgmk7drQLOnZcF/bWmERaY/bVguWkdMgdgwayE/E/nkTvAuT0pQLDQ4ILXjC6SGFi4Kkz
	 aP5ZqQP2fkpsMPLelSUpdXP9Me7r3A/VaVrbpcyMiXcU4k4iJp/SKPg3IV3nN9DdFF38I
	 X8NcfjhQ9JRX1LiOCMlTOt0ky45QpIQYN5sVhymucY3PPEljwFqyVuFiCUkzYxNgNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127762;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vGNfBHOfJEaTODk0UVMUPWh2+98FNaAkNc8rBZooR1k=;
	b=UxrZq/8gB2o/W1YzgE5yq1VODkxuU0tsQfetadzSbOP0eA+f75U67rLhDOfXwrtJ4bvq
	 iJHWXGyMtLiVFK6Gnrf6PxKd585ZNGdfTIKk7+hwzcMD+0ABFgkgLGQ3mOMntaKsKW133
	 3RT/+lbT7IRfEbDTaZ3m2Qjn2MuKpQiWLoNFzn61vDey/SWePzU7+KxFlinlVqAz0VYtK
	 gw+SIctYMSq2d/z64FjZUsumlJSNq66Eoxrh4AX77cBOQX6wcsxMtGp95RmHx/B+2kIeH
	 U2c3e1s4a5F1FthExdHdGXFeqJ51SC1uOuzTlYk+Z1KqnHYF54yn0KYZs1Mcugbx5ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvf+CZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C4606D806;
	Sun,  8 Nov 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvf+CZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222971F008A1;
	Sun,  8 Nov 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127762;
	bh=vGNfBHOfJEaTODk0UVMUPWh2+98FNaAkNc8rBZooR1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TDvf+CZIwx7eB9ZyWvpd50vKyoNK51ivIdJam3KpGu4w9aEOJqt30YPL3qj0wK9MH
	 t6bxnEphSPMLZzCBCY5eYKnsjh4kC8gLOGI/63rCnsIEufKQXeEbADEyrT3NxS1ArU
	 +5NPvW7J3fTaVnhivnbq9uhOehuRHcj3TVdZv9D4lY0eIX2QafzffPmjTUw20js9bC
	 LGFTCAO/mN3qJWxne8iLoOg0xdBrJghNr7ZD2NhvnrJ4HuJG5wAgwTR7iVU7ODO2ta
	 Mms/cpMn55diPEThEBQqy08GpQ1P/KMm/lpxaS65wUzXHUcYMJQmtBuNVbXkXLbO1n
	 mEPecjudyA7iw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:49:02 +0200
Subject: [PATCH 5/5] s390/hmcdrv: Replace page allocator calls with
 k[mz]alloc()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
In-Reply-To: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

diag_ftp_cmd() allocates the DIAGNOSE 0x2C4 parameter list used for HMC
file transfers under z/VM, hmcdrv_ftp_probe() and hmcdrv_ftp_cmd()
allocate the data buffers used for the transfers and
hmcdrv_cache_startup() allocates the buffer that caches the contents of
the last file read from the HMC drive.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() and __get_free_pages() with kzalloc()
and kmalloc() and free_page[s]() with kfree().

Round transfer and cache buffers up to a page for the required 4K
alignment, without rounding to a power-of-two number of pages. Reject
unsupported sizes before rounding.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/diag_ftp.c     |  5 +++--
 drivers/s390/char/hmcdrv_cache.c | 18 +++++++++---------
 drivers/s390/char/hmcdrv_ftp.c   | 14 +++++++-------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/char/diag_ftp.c b/drivers/s390/char/diag_ftp.c
index 0a506559799eb..174c65a6e6052 100644
--- a/drivers/s390/char/diag_ftp.c
+++ b/drivers/s390/char/diag_ftp.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "hmcdrv: " fmt
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
 #include <linux/wait.h>
@@ -152,7 +153,7 @@ ssize_t diag_ftp_cmd(const struct hmcdrv_ftp_cmdspec *ftp, size_t *fsize)
 #endif
 	init_completion(&diag_ftp_rx_complete);
 
-	ldfpl = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	ldfpl = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!ldfpl) {
 		len = -ENOMEM;
 		goto out;
@@ -208,7 +209,7 @@ ssize_t diag_ftp_cmd(const struct hmcdrv_ftp_cmdspec *ftp, size_t *fsize)
 	}
 
 out_free:
-	free_page((unsigned long) ldfpl);
+	kfree(ldfpl);
 out:
 	return len;
 }
diff --git a/drivers/s390/char/hmcdrv_cache.c b/drivers/s390/char/hmcdrv_cache.c
index 85fb689594ca8..4857c543a2ef4 100644
--- a/drivers/s390/char/hmcdrv_cache.c
+++ b/drivers/s390/char/hmcdrv_cache.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/jiffies.h>
 
 #include "hmcdrv_ftp.h"
@@ -42,7 +43,6 @@ struct hmcdrv_cache_entry {
 	size_t len;
 };
 
-static int hmcdrv_cache_order; /* cache allocated page order */
 
 static struct hmcdrv_cache_entry hmcdrv_cache_file = {
 	.fsize = SIZE_MAX,
@@ -214,11 +214,14 @@ ssize_t hmcdrv_cache_cmd(const struct hmcdrv_ftp_cmdspec *ftp,
  */
 int hmcdrv_cache_startup(size_t cachesize)
 {
+	if (cachesize > KMALLOC_MAX_SIZE)
+		return -ENOMEM;
+
 	if (cachesize > 0) { /* perform caching ? */
-		hmcdrv_cache_order = get_order(cachesize);
+		/* the buffer must be 4k aligned, hence round up to page size */
 		hmcdrv_cache_file.content =
-			(void *) __get_free_pages(GFP_KERNEL | GFP_DMA,
-						  hmcdrv_cache_order);
+			kmalloc(round_up(cachesize, PAGE_SIZE),
+				GFP_KERNEL | GFP_DMA);
 
 		if (!hmcdrv_cache_file.content) {
 			pr_err("Allocating the requested cache size of %zu bytes failed\n",
@@ -239,11 +242,8 @@ int hmcdrv_cache_startup(size_t cachesize)
  */
 void hmcdrv_cache_shutdown(void)
 {
-	if (hmcdrv_cache_file.content) {
-		free_pages((unsigned long) hmcdrv_cache_file.content,
-			   hmcdrv_cache_order);
-		hmcdrv_cache_file.content = NULL;
-	}
+	kfree(hmcdrv_cache_file.content);
+	hmcdrv_cache_file.content = NULL;
 
 	hmcdrv_cache_file.id = HMCDRV_FTP_NOOP;
 	hmcdrv_cache_file.fsize = LLONG_MAX;
diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ftp.c
index 3312b2ac00a9d..e22789b532de2 100644
--- a/drivers/s390/char/hmcdrv_ftp.c
+++ b/drivers/s390/char/hmcdrv_ftp.c
@@ -194,7 +194,7 @@ int hmcdrv_ftp_probe(void)
 		.len = PAGE_SIZE
 	};
 
-	ftp.buf = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	ftp.buf = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 
 	if (!ftp.buf)
 		return -ENOMEM;
@@ -218,7 +218,7 @@ int hmcdrv_ftp_probe(void)
 		break;
 	} /* switch */
 out:
-	free_page((unsigned long) ftp.buf);
+	kfree(ftp.buf);
 	return rc;
 }
 EXPORT_SYMBOL(hmcdrv_ftp_probe);
@@ -238,16 +238,16 @@ EXPORT_SYMBOL(hmcdrv_ftp_probe);
 ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
 		       char __user *buf, size_t len)
 {
-	int order;
-
 	struct hmcdrv_ftp_cmdspec ftp = {.len = len, .ofs = offset};
 	ssize_t retlen = hmcdrv_ftp_parse(cmd, &ftp);
 
 	if (retlen)
 		return retlen;
 
-	order = get_order(ftp.len);
-	ftp.buf = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, order);
+	if (!ftp.len || ftp.len > KMALLOC_MAX_SIZE)
+		return -ENOMEM;
+
+	ftp.buf = kmalloc(round_up(ftp.len, PAGE_SIZE), GFP_KERNEL | GFP_DMA);
 
 	if (!ftp.buf)
 		return -ENOMEM;
@@ -280,7 +280,7 @@ ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
 		break;
 	}
 
-	free_pages((unsigned long) ftp.buf, order);
+	kfree(ftp.buf);
 	return retlen;
 }
 

-- 
2.53.0

