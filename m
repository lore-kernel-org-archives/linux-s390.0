Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128675;
	b=jwmQ2sGBMTvbU/sSPLQTvi6J0DvaSK6l38shdoGpojBs4rSjzafhO1eXvRTFPM/enLZf
	 K7l346rztQS1uYeOGNebYD81BtWzGvv2VPy5IZaw0tZFbixjr+q173mx6tcrwx9xvINLE
	 i8aEX+fjo+/7ecTOLcEtCrK41HknTHGg9sFFzus69UMwXktOntYEWJ7Z2hTE1H5TLqG77
	 dKbUjsPIGF/ypp1l8crN96/2/bBeO9xk5zC062wMo7VU2Qzj75utizT01sNw22wjvbYMu
	 TxnjV9E8l09vsKwX5clwhT9UHqN52MseLl5o4o9qH7NmPK+SzYwPGXC0XuhhPz3u+3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128675;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=XT0YKqJ1crGE3lP+8+7n5IpoTabmCNV1Y/YcA5CixeE=;
	b=PjjlHPecAGzeKlb+e7nrL7pDNQBepPMmIfdZDXUjFyyZpe0hvi1E4sRk8nfhseFiqIvv
	 mcxUYvI51ywJ6of1PuWnV5R/XpibevQ/IeAgvVK2wjyhbZ2yPJ9x6shwpulJVIurk+TJ5
	 4L/Qn40GqN6heSeu6DrVE7suFxlym2jVCpYoE9u+/m8knXNfupBEHbUrOvNY/ZhEYOAvN
	 Y5w7RpCqnAXRKx5M/ZG74kLpFQQQmoyQSbmXZ0keVZUiiL46oy4Vyp4uHZ/zyKjpwgNf7
	 SuHXYVcpnJog1eC7yLvPFDFYzlnjJ8YLMs/Ovj5Icsrlci8M/AQ61EQDRCyxBR59/mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIa8xQyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651ED606A333;
	Sun,  8 Nov 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIa8xQyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D131F0089F;
	Sun,  8 Nov 2026 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128675;
	bh=XT0YKqJ1crGE3lP+8+7n5IpoTabmCNV1Y/YcA5CixeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NIa8xQyk8Tta+F8UoRfJBdNGf18oKMN8u1pHXsBwio3XFvkTe4yxf+rc/73jYmqwJ
	 oT0ePE/05lFOIGRnegXEGJdccMrAd1pLp6Av9QUkf077ZukvsA3Jw+dWVHN8r6+Q6I
	 Jii4oW3RQDMBBsLz96rnDdlyMhYI0gTY+swb/zQ6tHSBKgAChUMgv/4XFMZgczLvaA
	 MfyNdZVEhMtoE8OLAwTuRLPOp4YF1T1qxQuRMOsbtxEmiJFtv7VpvKHSRtAUl3mxkI
	 2ok9h1TUvwDbgUBr2nTiq1NZ4MaX3oFlzDACZiDN1qFSDYtQM1MFH0ct8w/1djl1XO
	 5mESE4n/LoPwg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:35 +0200
Subject: [PATCH 04/14] s390/sclp_ctl: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-4-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_ctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index e23a97359286b..84aefff3be98f 100644
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

