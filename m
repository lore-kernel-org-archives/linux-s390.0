Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920838;
	b=KcMonexBBNPSnw4L2F/wj4Wcs4cYvmvA1wosf1e+fYIGLoclybdMUhy0IMbgnVbg2kmt
	 NBdAXZNvWAS7UL0o5icQocf3UMVScgbN0I6nH/mYm7+2UtwIqtlfLSusawa3f4RYVtIKs
	 lDs4dGOdSk9SOqlt8PoI/lhVxgTcVnFVpOVEAHBnuMT8tzJnmtGgFuBI2UaLhFUUePWT0
	 fnhd67MQIccFjMD86TI2/Iq8avw5JkowiLd4QbibzXBtW36TUa0rXrcWajTmzVLGq6AcL
	 UQdXupQMq0wuAmQYntHb1kV1ch/CK6l2Lta3Obg3uNvtzPzGHXZASIfRPuadg7xDlmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920838;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2iJKQ9g80TKCxV6YWL6c9OznHwGGtVqmigy8uKmIx1U=;
	b=LB/4cIql7WAM+/ZRpsWGfUDdd+9NYaX1cDdDESvCogl65SIqWmnmngWXbJgc/eGPbXB2
	 rVrNmvgWMGXQh3YmfvjtSdSJvHA/MrNgZdXSOGdIMD4RbUdX3STRy8vJxrPs31COdiF4d
	 djj8OCEBlSOA//e3G05Pa8MYG56I/H4okhV5/P9Iw48MBQ08dsmtUbRGM3qF6Q4NZVQ6o
	 j923QFqFt9VfE8ks9u/ybpvyLpLZ4imEYiX5YLNVnWO/kSm/rL8z4n1IlIXisPe9qjZAC
	 vuC6vgRwc8VNmcPL2tLrbDhGvVVG/W5NlfoQu9od2FMypj7nozsqKvqlPZGF0gDv2OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS5UGHdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428660A2635;
	Tue, 17 Nov 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS5UGHdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B021F000C4;
	Tue, 17 Nov 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920838;
	bh=2iJKQ9g80TKCxV6YWL6c9OznHwGGtVqmigy8uKmIx1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mS5UGHdM25I1zvDIW/JSvdij8sfG0xyBzoMKH2NmlGlELEvFwgGM04Ifz8uTl9+mv
	 liwOuPzVlCZ/x0PFIqZUBjILwamoxTHCYk+kgMmRo/BHhbL40yM1n6ZD5z/9nVuTY+
	 /Bal6Pt+cOHec+erubCJFcd3a+zc1EH2ueK/NOnVdNsVvn5WmCgnMWLc3gxWNvGxPJ
	 GXyvaal7RA0oc2B8OSCvDVPGBJNfajf/7ZJPCKX9Zfexfqx58+vXik2EaSixMpw2fr
	 i7zjsaqWFDix8W6Fmff9fcIIjQFNVY3DXTqdXHXqi7gmf8t3E4OQb3uamKmsO5Rhw4
	 vg0eQ255Hum3w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:58 +0200
Subject: [PATCH v2 06/14] s390/sclp_tty: Replace get_zeroed_page() with
 kzalloc()
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
Message-Id: <20261117-s390-sclp-ready-v2-6-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
In-Reply-To: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

sclp_tty_init() allocates the SCCBs that are used as the output buffers
of the SCLP line mode terminal.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7..e36739bd2732 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kmod.h>
+#include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
@@ -497,7 +498,7 @@ static void __init __sclp_tty_free_pages(void)
 
 	list_for_each_safe(page, p, &sclp_tty_pages) {
 		list_del(page);
-		free_page((unsigned long)page);
+		kfree(page);
 	}
 }
 
@@ -525,7 +526,7 @@ sclp_tty_init(void)
 	}
 	/* Allocate pages for output buffering */
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
 			__sclp_tty_free_pages();
 			tty_driver_kref_put(driver);

-- 
2.53.0

