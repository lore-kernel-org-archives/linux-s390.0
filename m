Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920832;
	b=v90b8+hKiq4imczcIyg+xxL4nphpQkvViaXqNUopzrvTmEW345s/EaqdKG/1wAVDaChi
	 CMWDY/N82hwDkGtjc5hp++vR18y0kBTR3m0HNXOX1KPbE/mxYjEiW+2R0ApBEU5A8cbCW
	 2JkerT9QN1P1EZnyP0W/XcCUcGhYVyEsZtoaI59gBaKbcDuGhZUENA7m9JaKTcDj0ZGiB
	 5pI7kgHseBw+2cH1YI3DV8QY6hPhaYyY97M5ozuj4E/H9NCDCX9ep0h3ZkH2BUPAMrmr9
	 El5werA2zFIv6q7bv1y0eXv3c+RIn7lOjH8dglXfdl1DyddrO1wws/Z/6dPZrqWDYQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920832;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=K32cYhhpMABUKSCg35m/+J5/IEFf1g45r5D+/Iqjo7s=;
	b=Onn4bHqOyc5m4XH7CdDn7eQMH2F9SYBQRdufVi/GmHHd3QycbO9M4srHKZFFUH5QlkfJ
	 6W0a9TFgdIsbl/OWc2Kszz15Gk5PytG7TMjdr5E3XnjI2nid0SBz9J+APEoZR6gwxeQGt
	 kgHfv59cfl9cczIxYz0bAFvcFrexkCWwxV/v4BNyhRGn6pj5oAaDI6F1CHHx7VhVHcyaY
	 +sqmS/EWqUeJykzbF8KmeAtbKaBW2NqHYQfHUv63INpzisHbsbW2dzQdALTWg5ybbQxB1
	 zGxyoRxdAg9750W+pPeXngFhmaKV+VL1KYdLmtuZHtZJMwuKPTEihlpRGTCnyiil/jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVUf7u3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78760A261D;
	Tue, 17 Nov 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVUf7u3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E11F000C7;
	Tue, 17 Nov 2026 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920832;
	bh=K32cYhhpMABUKSCg35m/+J5/IEFf1g45r5D+/Iqjo7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NVUf7u3H6FYrGftOdsKYlwCrzA5Eb1yPspRj9Y8FRhAsicUQ6qxf43ABuFoIHlkvH
	 yQqkYBIs6Pnr58jFbCn9u8xpsolUSLOJhGzTdVCFCk77MSTHIuPl5hsRgbW5R8SK3g
	 ls3fx342OQHxkNMpSLnNgcC3YnEm3vbjM9qhCHECf1jDZkaGf1HxODf80EEPgHNsFo
	 7abRNRs7o5uNZ4qPqd6bzrU4rF33FHT/wjyai9uwT/FOi1wCI9vqBK1AUQ/qWQesH6
	 2a8EQmqVLQLx9a3f9hfOFvOicYAxnliCXjk1i9Sehkv8fD64ud7wrA5yDoqA2RumOj
	 MrROSM7JnkJHA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:56 +0200
Subject: [PATCH v2 04/14] s390/sclp_ctl: Replace get_zeroed_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-4-e518c99622c6@kernel.org>
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

sclp_ctl_ioctl_sccb() allocates the SCCB that carries a user supplied
SCLP command.

This buffer can be allocated with kmalloc() as there's nothing special
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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_ctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index e23a97359286..84aefff3be98 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/slab.h>
 #include <linux/miscdevice.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
@@ -59,7 +60,7 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 		return -EFAULT;
 	if (!sclp_ctl_cmdw_supported(ctl_sccb.cmdw))
 		return -EOPNOTSUPP;
-	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	copied = PAGE_SIZE -
@@ -79,7 +80,7 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 	if (copy_to_user(u64_to_uptr(ctl_sccb.sccb), sccb, sccb->length))
 		rc = -EFAULT;
 out_free:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 	return rc;
 }
 

-- 
2.53.0

