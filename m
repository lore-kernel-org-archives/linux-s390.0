Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128678;
	b=f1d+keTotNXn9oI/88gnxJ0I+vrkXaAVrhAyMuuiEH+anxCMZsmlpYV53XJoyew5zxHf
	 05bQ7ibjBQWdlJd/2td31hchIVFlrnv44FfNQQcOjEdHZxqX1i3ZxniCGeIYgfP0LcMJH
	 Go6eYLsHrg3uQI5Fn3AaJaM0MTL++06TKmPtzhorFFNG2td2B0rvdM3THXm1KnRBgK8/+
	 pkdfF4IUmzS9LDdheyRu6NBxo4w6SBKz/+2twYm8gLSLXEWzglrA1vYY8e0Y0xSFuPY7r
	 oh5rj+djOBIZjMdK+0DYqYQ5cteWpx7lgW2M41oSZpPoUSnnogwX+dQ+pT2/YAM2Glg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128678;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=9Fekj84/ogn/fq4bKg6J4Il6J5X5oZC9LiyDjaHRbcE=;
	b=gWX6dz+eRP5mgWC5ZxZ0Jxfaj8tZwBV/1mwIW6dpru/ROjABgeFsTXbvwllzMVvn5h4e
	 xLBCR9scZNlgiiCSSYwe+4LBxTBratww1/YJsFxbvgZPdxQERpXAWKM4Cmq/Ps/dXIwRj
	 6VtWBrkrtmdFlqvKYUs2Fgnpx2vef/CGFdvU1DFpmTsh7yBHGsJmuhoUJikITWsk0bnAu
	 TB6NGE+3f66JoKisT+qskzgQC4tD+IL+2AZN69HLxhLXRTaX6pzsZFCzbgafg5+RoIElL
	 AHDxhp9hu5w8LHTiWUi7guYqL+oxVwySJBEPWpNcQ7ewJ6sCxsmnb0op7rD8Y0+rD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmRapOy4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525C606D807;
	Sun,  8 Nov 2026 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmRapOy4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAD01F008A4;
	Sun,  8 Nov 2026 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128678;
	bh=9Fekj84/ogn/fq4bKg6J4Il6J5X5oZC9LiyDjaHRbcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lmRapOy4NqvhzXhzk7xPJQXImpvxDVibo0juEmmKPRV1XVxgLZY8T3VnhUYswyGbg
	 Oa67RyP3lSP8LT+koDXLye5576tGYWzDdfFdBTBh5x/DJ1S/JeHRmkyWiq5oEFdSB0
	 4Xlbt/BW7blWhz6RrewuCbCik8OKgsJrz4z2b5LnwMRjbim3miA/LOxTsm0yqVLaBy
	 mgLQWIsmAVkFXAj34xtzQzWfwwOCVfrLTn2MIzc4+q1sty415nctK1SmLgzsgAAfCs
	 wccjt+DMBSYV949bSTu6RJc65l5z3snium2a4QclzAApshdh2GVHl+k8KVGp4k5Tbp
	 lua/ZKTVx+rYw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:36 +0200
Subject: [PATCH 05/14] s390/sclp_con: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-5-3e7c90eb6676@kernel.org>
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

sclp_console_init() allocates the SCCBs that are used as the output
buffers of the SCLP line mode console.

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
 drivers/s390/char/sclp_con.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index d8544c485808e..9d096d7b59687 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kmod.h>
+#include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
@@ -272,7 +273,7 @@ static void __init __sclp_console_free_pages(void)
 
 	list_for_each_safe(page, p, &sclp_con_pages) {
 		list_del(page);
-		free_page((unsigned long)page);
+		kfree(page);
 	}
 }
 
@@ -294,7 +295,7 @@ sclp_console_init(void)
 		return rc;
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!page) {
 			__sclp_console_free_pages();
 			return -ENOMEM;

-- 
2.53.0

