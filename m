Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B84611CA;
	Mon,  7 Sep 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776641; cv=none; b=Q9DtHLqgiMeIAxVe4LJMWdZTsL7QtsV5C42kKuS3CXQV3lsOTgUTuxkBuhExo5JWQujSKEZZ+/xPDdL1YR/95BSxuyH1YSSii5DPBoCX3Gl00SWKNweK7ZubikK6HAkqdngEsRqd/snPuieuG7G83xojQXkDeQUSWFZLjyYZvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776641; c=relaxed/simple;
	bh=tnPqOGWy+G/exKowrqrFWAt1LzC422b7ugtuCq4Q7iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIE7eorSvg6Rk/n51d8cYSSRfZ1B2VlYFKRMGsF33IUv5IZCR7eZtqlTf9TwSQJ2GuPMFg6kWdftWBXiki46ZzOAiVQ6P1eS9gMX54UoMUjJy4r5ONRBXG+smt0s0BD33FDTv8E6z9YSzairzmeQUAcqDgy/dXVqDqEV4m9J88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMNiho05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMNiho05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E91F00A3A;
	Mon,  7 Sep 2026 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776639;
	bh=BvSsEcfuxj9lC5YTGUuAUBtK1T4naFDW4wq12j/K7Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PMNiho052IJwVfeivb9lDHuj7T0OqI+bZc5Z3AmRzn1GKy2BsOSQTw80aToZUydU3
	 Ziw7aYbHRvGwmC940vzWg8/AWKslCjf4QjowV8BsmtK/pdDw0ULZR5lV3OacR7WjNE
	 5F7BwNwd4rxubKftcgONyAyVQB3RnKX+dMkjAYcasV8SqBAP15gVKhQmylWhIDzoYZ
	 V0GZ2gHFFTrbZX6n/NEzKUXZfTymd1lsWH+7uXdA9/3v51LE9eiI2jyTS0Yt+lYSuS
	 caxlfC9QSCSzNCJMlrIULXTqxgLHBQRp79bp2kAo+5sbqX+rMQKmrVEWtgDIpdBmpd
	 7cIwvnB8HVNuQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:43 +0300
Subject: [PATCH 02/13] s390/chsc: Use kzalloc() for the SEI work area
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-2-ca7f39806234@kernel.org>
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

chsc_init() allocates the work area for store event information data.

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
 drivers/s390/cio/chsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 60a4a7e6086ce..c3186c0a372b4 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1142,7 +1142,7 @@ int __init chsc_init(void)
 {
 	int ret;
 
-	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sei_page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	chsc_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sei_page || !chsc_page) {
 		ret = -ENOMEM;
@@ -1154,7 +1154,7 @@ int __init chsc_init(void)
 	return ret;
 out_err:
 	free_page((unsigned long)chsc_page);
-	free_page((unsigned long)sei_page);
+	kfree(sei_page);
 	return ret;
 }
 
@@ -1162,7 +1162,7 @@ void __init chsc_init_cleanup(void)
 {
 	crw_unregister_handler(CRW_RSC_CSS);
 	free_page((unsigned long)chsc_page);
-	free_page((unsigned long)sei_page);
+	kfree(sei_page);
 }
 
 int __chsc_enable_facility(struct chsc_sda_area *sda_area, int operation_code)

-- 
2.53.0

