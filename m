Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992234;
	b=bqzlhLV7nIkuG8RInczlzKVfDQEQs5BSA5leeDJm1T08BU8BGp0vqR9/PpdwaOtyVw9H
	 Auo0y48rn0sOXvy4Dd5QFR98OFck910sa7JFgdZKYk1/DZrpaO0ixRxySHbXqBWJZbsli
	 5ErncEbVzYETaBXBZtBY41+UWUk0pRPLyiDpk9ntCEBmvOzQLSnCIIxJmci1LWGTg0vSJ
	 7OuJACUhnTb+dPc43zQHRHheHGhZEBXii6JdLKekJE8jw+9gvnO1qy1TQALLdQSwnr2Jy
	 U1yvt4fNHWKg5MtOj8G2dJVgUSnQIBXWimW9PZRJHc9TXZqzeaPedFoVDbfypDTb8Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
	b=QrpaaJ6pTs5iUB37eSclHTzL4SBVYHWnW5BtKwNJ2F9x3wGd5l7DD349S7mgeFcPlWK8
	 41LJEUHBQqQGIGWmKE2ZOabx06882Xbwl0pYKienNWX1xO7obXo0ogg3gnbxjyQBqHxEQ
	 3w3UbxzSZUgkOvJ7T9J4lvLzfts+EJWCHrx3P9i86F71JjueY2OgoMWCnXWtr5IH5wU4w
	 qaKLPAPzV5qve1SdHLmGZtEBw/wdaKtd0Hm35CQ/T/k2eLj0xF008A/MktHkmEzIpv8OB
	 WjkIFvHdN58WN3+6xomldKEn/+yMJUutIHp/qml/1jLr47lJ+sBaH2mY99TBZls3y0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRLu4lzZ;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BC606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 19:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26BC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRLu4lzZ
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ea43af0caso9711286d6.2
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992233; x=1794597033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
        b=IRLu4lzZzcc2ZQGOKB7mVW3pv4psR+M1ijFPg5jVEmMFj5y3l+OUITizgZNjm/Ewd4
         DLCXXv6cL53BD82KuAoSF1V4wcWqHaGY5XjJPLGY2bX8OPA+xbKdn3cezJE3eyYhiU9q
         uVVScAX35b7cI7qc0L3TIjbFNw7bX5kvpgIT+V2YgKld2M0N4/paVVZPkzf8ba1LlpXT
         wbf7ZIgXZZy2LRsmlPh6AOs+5tPjcTHCTSQvb4vwjwc9ldwldbtG9cOITQvbnYilGKWK
         TB/4pIgZbZq0437QTX3OFkA/ztdQm0fkDXXtr6QOY1Skv5R0c9kcXgApGVWLt7IK4CA0
         1QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992233; x=1794597033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
        b=IBff9vPqFPQxEQFGJZSG4Ri9623eeRb7GwOE2zHIeoSkZmIupzQdj8FnjfdDTHEDDJ
         SalGnl+lrjiQRzt/iIgJUJdo2WY0y0dtzu7Cq3nh5ieQ9m6howtjKhozqVHf7UAJ8YTz
         a/2w33YXz6wyn1QGvrmE//+b9p69TCukxI371HfHbHRkLwOMEXYPtHL7Hxj8J19gVFY9
         cUb1QkaRxkb5SCgwtanA1erhXmha6+rHOIjFTr5EWNCXuiM1ouPZ8tWW1y02oKWLL2Fy
         8gP5ZK+PeZKz2i6iXlAN2LVlFMbthWcA5tvY8ngUakVuK9u3RC2wEb3rV5/ASwDB+h8S
         0jgQ==
X-Forwarded-Encrypted: i=1; AL+hErEWX8CUBtYGXinGJHi8MlH07EK2BU+WfHx9u46BimJhbNEPzn9OD3lY4gYLKfVqMXD9xsBTVy65rZtP@vger.kernel.org
X-Gm-Message-State: APuU4Z8XsnB4zf67motCFo0lAvSdj0OxJiMpipMyI29E/A8gJnOGIu9U
	w8nKA8jVjIgfqZJ4PSqwzaFFqBjYYXED9uGJnoL1uXGRG6UfurtiBPYM
X-Gm-Gg: AYBFou1pDv4Mz1o6ejYrvSIZJ6BCzlmQ0pxmJFo0JQItIfhEs/EsIXKC4BqQvO2iKta
	rzpFVQBkvjIb7s9wFcJ5zpU3dPTesJ3YY6xcMpd8Vv2KM2/XRIswBb+jqO6SG50k6dZZBHG5mhz
	8v8Lq7pvfD46fqIPS3AAyLq4lLwX4K5BaoOBBqhdsKiQF1F9TI3NPYGC/mdInwEc+0gEJG2uZSd
	L/uKdQNkF4bn0ImbJs3jV6N5K6idUBEJSJ8njEB+j/NNqUnxwhrdvjtZoV5RcPTEqOPJfgeSmq1
	TRZ/ws5n2apOCNyq2FE9Mv87HP5dok/p/PPH4bQFVdlscV54EhT4S2/JI6q0sGtfZ/nX+Jwr55j
	KB/3CUG76Lg4u9Wrd+yL7N6bN9Y77G/Rnnhcmn8Z5DQwu3rMGkFNmRd8oiL4ixDuAPuSLO+uZLa
	AO1zlm+erHFkxNf9IBFWIXyfPxkIIytqtsvKufiLVEZ7fY/d/7AKZ0g86RyLps3n3ekDITDMzoM
	IQJAth0NXadkqJxsM7A/BipGwwY550p8zQVbO9vIHiyOJe0oiASBk8B6tN+Z+55LljelmW19j2y
	Kov/WarQ7uNcoBdAzRwHBgK4JoiYmcnW+2KWhWJBZAyuMuPSd9iJ
X-Received: by 2002:a05:6214:3308:b0:91e:b100:1523 with SMTP id 6a1803df08f44-91eb1001f9emr30869716d6.57.1793992232895;
        Fri, 06 Nov 2026 11:10:32 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a69818sm27622166d6.24.2026.11.06.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:10:32 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] vfio/ccw: Flush notoper_work before returning from reset
Date: Fri,  6 Nov 2026 14:10:26 -0500
Message-ID: <20261106191029.469837-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
the pages covering the range before it returns.  It calls
vfio_ccw_mdev_reset(), which raises a CLOSE event.

On the normal path fsm_close() calls cp_free() itself, so the pages are
unpinned synchronously.  But if the subchannel cannot be disabled or
quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
fsm_notoper() only queues notoper_work, which is where cp_free() then
runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
path, so the callback returns with the pages still pinned.

Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
and taking the host down.  A further CLOSE cannot help either, as both
CLOSE and OPEN are fsm_nop in the NOT_OPER state.

Flush notoper_work after the CLOSE event, as vfio_ccw_mdev_close_device()
already does.  The flush returns immediately when the work was never
queued, so the normal path is unaffected.

Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Point the Fixes tag at 0c11f61a876e, which moved cp_free() into
  notoper_work. v1 named ce4b4657ff18 by mistake.
- Mention that commit in the changelog.
- Rebased on v7.4-rc1.

v1: https://lore.kernel.org/r/20260922164928.477669-1-oss.patchbox@gmail.com/

Found by code review. Cross-compiled for s390 with gcc 14.2.0, W=1 clean,
but not tested on s390 hardware and I have no reproducer.

VFIO_DEVICE_RESET also reaches vfio_ccw_mdev_reset() and benefits from
this flush, ensuring channel program memory is cleanly released before
the reset ioctl returns.

On locking: the flush is not called with io_mutex held.  cp_iova_pinned()
takes and drops it before vfio_ccw_mdev_reset() runs, vfio_ccw_fsm_event()
takes no lock, and the VFIO_DEVICE_RESET path holds nothing.  This matches
vfio_ccw_mdev_close_device(), which already flushes the same work.

 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5ce91285c7d5..8e0a2edbd34a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -25,6 +25,14 @@ static int vfio_ccw_mdev_reset(struct vfio_ccw_private *private)
 	 * and re-opening the mdev, return an error.
 	 */
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * A failed CLOSE leaves the FSM Not Operational and defers cp_free()
+	 * to notoper_work. Wait for it, so the channel program pages are
+	 * unpinned before this returns.
+	 */
+	flush_work(&private->notoper_work);
+
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_OPEN);
 	if (private->state == VFIO_CCW_STATE_NOT_OPER)
 		return -EINVAL;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

