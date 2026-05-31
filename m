Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291B314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236522; cv=none; b=FwPju5K9aeee8yi8mxUELFhcuQoSzd3JMcyiv5hRD6ZNimUs7SXkoRI2HGOIDhxJdml1ngQ1bPpaTnDo9DiMhS6CLPURROmWVHeYfqunHjAQfaR9hTiR2OFKRgmaVYEBgwGn2leEzePFYsbn6dgEW6sEb/vNv1vsNpby4dzCQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236522; c=relaxed/simple;
	bh=uC1ATfyVss6GFaJbVzcUBWimpig9uWAp2QD4DSwc2Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4iF+0/qvPp1Du1EwM6Oyes1dSXupDMlqvb4NIrgDCdVdq5YgFxvyVT/fSHfkM8uiHbhkMGTxRikRKbjy2yqSMtvCClcWbuWSgZfVxBsYoU8za88Lw3+tPEOD4jvrl8+Oy5kc6usNZB7gg7kY0RIxGcKjcXLosmgHecBIfaCWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBmqM4G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBmqM4G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AA01F0089A;
	Sun, 31 May 2026 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236521;
	bh=EpFdlsSkvAXhSyZ78eifycKiWR1+SNBkn08mN8o8Kzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EBmqM4G050ZchrAEgOs9ibfOoIaTDC/21YwdfI8fjmljvaoYrPeAJToP7EC/RpM1x
	 s+K0VrxyfSa7juizwFcSdBhdu7zp3gbbacd7izi8GxfkkCwdqYYsIaW7hk8rjxZ0u3
	 0L+MdDMytBSkijRh2KRDBXop0J66tWTQdhhDDVt7GlevSNYABxoMMX8sJTEaEnVOtI
	 L/yhqKliP8UfsRWq26ZWyFhKwBQyrqJksKTVMTuaHQ32sCBvkVcZ/N+aZ78dHtxfgl
	 A3UiC9nv9dmZnr83tnTZkpezhPbrq84dAMxqHFlwQin5NTLZ9hTDR4bnWKigtisKH2
	 Z2kc2yMR9Bf0A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:24 +0300
Subject: [PATCH v2 3/6] s390/hvc_iucv: replace get_zeroed_page() with
 kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-3-f7985308ed90@kernel.org>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
In-Reply-To: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

hvc_iucv_alloc() allocates a send staging buffer for accumulating
outbound terminal characters before they are copied into a separate
IUCV message buffer for transmission to the hypervisor. The staging
buffer itself is never passed to any IUCV function.

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
 drivers/tty/hvc/hvc_iucv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 37db8a3e5158..d29a86d161f6 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -1060,7 +1060,7 @@ static int __init hvc_iucv_alloc(int id, unsigned int is_console)
 	INIT_DELAYED_WORK(&priv->sndbuf_work, hvc_iucv_sndbuf_work);
 	init_waitqueue_head(&priv->sndbuf_waitq);
 
-	priv->sndbuf = (void *) get_zeroed_page(GFP_KERNEL);
+	priv->sndbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!priv->sndbuf) {
 		kfree(priv);
 		return -ENOMEM;
@@ -1103,7 +1103,7 @@ static int __init hvc_iucv_alloc(int id, unsigned int is_console)
 out_error_dev:
 	hvc_remove(priv->hvc);
 out_error_hvc:
-	free_page((unsigned long) priv->sndbuf);
+	kfree(priv->sndbuf);
 	kfree(priv);
 
 	return rc;
@@ -1116,7 +1116,7 @@ static void __init hvc_iucv_destroy(struct hvc_iucv_private *priv)
 {
 	hvc_remove(priv->hvc);
 	device_unregister(priv->dev);
-	free_page((unsigned long) priv->sndbuf);
+	kfree(priv->sndbuf);
 	kfree(priv);
 }
 

-- 
2.53.0

