Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA7346ADA
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952216; cv=none; b=VyHddrQuaUA90/SEc8SqX7qQbSscgMJk7uzXjuyLb9HRn8gDgiZrmC1Tk1/IHnF1fBZgCALLuSVdrJSDlqPlP5oN9cK699W9oAykrU8lSgCaaolWAldoZbDauApxvIUSwVgWgPW2qSaYwvYAFD4/wnIzRSAhEEmgYjh0Z7bcgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952216; c=relaxed/simple;
	bh=6ZODIc7iRfZPBP+ndmLgwMAKwwP8v7fjmQKlfhJxPLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBbelYTLUEr9tfaJi2P/3KPDa3603tpTKV/Ib/P/cwwMgu5VzjC3oYVYbc9SSNcf0pwDk8tbjL1Xfjte2pVeYPD5Wf/w5zZxZrmoIRxHvlg/XEH3GCwwgkdAZ3eKTmfHF2HzhHBS38gnvoa4inVbOjS7iqp8YfxJckU8GiIyTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noNv5ngb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noNv5ngb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517461F000E9;
	Thu, 28 May 2026 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952215;
	bh=uUsTmbnoJ06kn7d//MyYW7YQxzV/JSB1W2Xl7joVSyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=noNv5ngb36qYzYjmGsiV4hHzRn+gGeTKPYWnxd7dTLNmO2dIptj7s+7Sndy/4sHNb
	 z9rNbbJ8mbtVA2ekQoIRs+utRWJTLxxKPGqrZLQRWs+YuRkAJyBve4ztDKJqidx7U0
	 RtaqMX/GZHINQxu4QRoGbHfYzlIr44s1poPkXkHajCbMR04hVesJVg71v3UK5JL19w
	 5RajBiFyLqJoTiqRhcfS8D8lE7QaRgpJSRz/XWfLDOx69zQJgoBsqxVWHiTmZpc4x8
	 AlfTIFtLQbOhbqa7nDFaB2wGOMtO3E0XxeCuA3EVupeWun0t0UEKHNGqoJHlBQMcW9
	 DKwgzdIQp1epw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:51 +0300
Subject: [PATCH 3/6] s390/hvc_iucv: replace get_zeroed_page() with
 kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-3-b7108f54d722@kernel.org>
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

