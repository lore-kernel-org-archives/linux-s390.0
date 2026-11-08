Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128681;
	b=HrElWaZX+GiDoDcqAAfUC4Z2kfuUWnd3iwIt96keYcyGySsS4xWxse8Sti9sGHW0Oo44
	 wnJSKAJFGVzAj8fiw0z7lSLdN1p3MzXz5P/OA/xHqPyqSqro6wlo6d3ZoFHGiGbEshOU8
	 7etsxFV71otM9FUl1h4nsCDf97iLO9G+/xBi3eJlPpaUL0SNVciHTSLbUSmWFcvodwsJy
	 JDcV6ooFPHVItwN8AbRG5PhI7dUuTOy5tONDdpvYgp88paC5/LHL/RWcNy9yZ0jDWY2l6
	 gX6br6yYk34JzS9SiILOSPkgxXfLt3hESecwTP0g9JedCh58rPyiD3Zr7+XFztOPEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128681;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=4f6ZdnIE0tPvvGmmjPRNkhj5X7OVxmpaKFCvrKiayoM=;
	b=09y4WuexumRsyNhPTzrN+58H9HwgFm2Z3c0WgZgh22GUx6cU3mrMPoqgpZTLroKEpA15
	 t/b88rDWQtcnGZ56V4DcC1ef8iTpXj8kdF3vb5u//NpP7Cn5yIv9l+YAht0skSxxrN7I3
	 6J1oCcDXgTqII4SPRw74a7zCbqJ0Ukt3+c698fjMlOu0hJPZWu+f8q8xTKXGz6sO9+NR0
	 C7tdqUAZx06G/vpehSmOF2lcbxT7ySEEblSWiSkXf7F4d/YWlR9c8e41dAa/tOiLgWN4V
	 WaTcgwuI2DIEpw/nGJlUAzAZDO/RBrSeE0upEcTEtCy3CStPxvtirpfaKSCICzy7vlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ablm3vX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066D606D80F;
	Sun,  8 Nov 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ablm3vX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56641F008A1;
	Sun,  8 Nov 2026 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128681;
	bh=4f6ZdnIE0tPvvGmmjPRNkhj5X7OVxmpaKFCvrKiayoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ablm3vX+NierNMFKJlQnSgrrXdlcLZ/0EOELMb7grOAnXKnbLgKyV2Z5bz8+t00ru
	 S4p81ww0Ffl8rd1nRqX6sJq4L522LGRlpAdK9elkJmejFAkaRBxlbXca/S+j/TTt/K
	 pQqSKoysv4nOOBO69MRGjkPdNqI/zB5ACiu9CsAA8TQaRCEw0vDTQvr7z0OeDSwzXC
	 JlKWsyBRmiKy+qhYh+hko05LGTyvzRbhWNdTD1YAUux1WcoNUMys5cpfmq6fiaBeWy
	 KIYZrT2NVxmBBmc69rei4gbFGwoc6sOdQetOZKqK81OLLJououNu/Uo5YPFC/A7eLw
	 /9mQdts7Fh23A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:37 +0200
Subject: [PATCH 06/14] s390/sclp_tty: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-6-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
In-Reply-To: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7c..e36739bd27328 100644
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

