Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907276;
	b=w36qjFw7lStqEsluqsxjrtMbzu/5wYmiVdGjgDXy2BaqTMV+StuD26F0m3X4zcn+/qne
	 KugdVedTZOGQ60cfe5ep+ug/BPqj0zQvv2N6XOtYnaq+mKa3N5YxSXRJ7Grj0LzbgG1mV
	 JOuBh4zjLPck07hupW2Zi+kbDZUP4kytmkW2+MgZnkhCyXkusf7GIEq3KuMA2e6g+EBLQ
	 cCXknYAiNpYyaTTqoyAAiJaMYm1xl7iZ6kqNklIjOFYC+OHiGk0z6lHYmdAk+J1drsyoC
	 ndggE6Z8c3zfoWOLRQsR74Y58R3GjKgRp0Fk9RSQaDk7IqwF3osQuc7m/GhpGB2yUHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
	b=JO77SXtIbVvWZI6gO9Cf0S/BoTic6lw5KmxNAj6YMGpqm3KWNS45MAo1o+pS374iPLyV
	 K34PL53PJJIH1DGjlL4wL2PeDTmDcauYpOsDLG2LfgzYDLLBRmfVpoU3cxby2YSjqhOn6
	 +d6nUcNKnfQ9ZMvs66sdYyZ6lf3F2AXLJHay8M8q3svYIS6V1ipuCzTC2qXd08CrHhmlk
	 oiYG6V/m1SHNXXzQ3AaPZH6zCfwtR9YX128M1ch0/C5erxSZrqGsy1snn5wWFtVtYr8hD
	 fI8ViX65iKQ82XxGzfIhKoRwJPZzmy0JOsCCxoJ5Cd3FcY73DH1wCDBPbxHWq249ADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eSebgop;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE21606C8BC
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 19:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE21606C8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eSebgop
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490a0e72588so1071050f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907275; x=1794512075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=0eSebgopJbfvwGFwpkTBWKFxy2P8hra9DfVseWNcJrheNgo0V1fHi3IP66QKikans9
         lU6e2quJM4cMs3ira4yk4pDtdlnShLb5KYkooDfqOALLqzYnj8dce4kuM/rSsw95Rp3l
         e9ZpSnfnyY64zP8lgQV9f6gtE/zcvvte2ccuHIi0aRYFywk1oTyCJAvHqyy2a2JPTofV
         gMidB2s+gddvQp+GO9qeUomeMxY6WYkPD9l2b/ZxYn+aoUnT+auviQ+NDnphAzMKFx9t
         5hOEP4ht+GliWUvbvr9rtcHa9P2f/QpWpI4mMAjibkwkZUCll44j+7lcw4mlLynUduOY
         KmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907275; x=1794512075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=FB4jTBGrvqE8JXEpRsRwZfCJyG2ZNgcJSubl+awL10DtMUtkcJSYmX4K+dOrW+se0Y
         U78JO6VAi1Jo/N8msrc2d92mXwTlTxRGWPch6CQkKc70wmF6inysdPgcCnjHK7bCXpsF
         3kD24Qk+YjudFXFxSTUb9KZMvuF+ysvLs2hJEoeFazsmPVf3nazC1p4UzIFC+YfdUbW/
         RCINPq3MoVYCqFNAaKET5UZGNXp8bzkHjwPeCkd1ht8dTGp88+gQPjagkB2+FWFRMHlZ
         dqX8aqc3RMf7Yn8xJJxtPDfRiFXltqNhbWdt42MwWd69d3ZI6qC8+EYlr/75V3A2wjj8
         e8Tw==
X-Forwarded-Encrypted: i=1; AKwUvBwWMeB1kBhd3oTC6lXoxEf8lnbgDLL/g4DfB3tVHZYEqAJZGArxS7Kc+/tLtZ5wWLKOiQAwdJZBqaqO@vger.kernel.org
X-Gm-Message-State: APuU4Z9URSr3F1yURDuT0M5ubPxDRdh2BEJkhhCSEk0uKjUw8RqiTXnZ
	i2FZWNz7/7bpJAqPQeOO8CJkT/38jRO+Q3iiSQYGsvu4LuBDOzi1+PSY
X-Gm-Gg: AYBFou1P9LEQTKzWwN69B1ULy8fVW55O4mbQWV7IILmij9uOuRha8SAKBK4Fc2Exfvj
	kwk7HoXTetIDxGQ/YXX725MaWwiVj9AGuhChoeUsu4QOaJZWZTYJqt5IwFxTsU0/aDeor1/pBYG
	SabQ2cbY22UQq6Cwafx0jKCmhu5RzCaas/zIkpWgNT6lxfsVxlwPp27O4ppJDbKfMoEfpsCeRl0
	7nAob9Y2lNWZF/1qYnFnn1oFV+Pkao4T7X/XYmtOXK4h8aJi66l2LZYpbDrQI0ojYbSCPavd97Q
	gebuzZnYoMqSWjgXIhJGGiaL5zxbJeyJZDr9G/jZQoP21R8obBZyVBR8a27Lhjmgd8WS2yE5Pg1
	/cwBvIJmHaKnQh0QkqAUhYY9MEJUr3WGQAHnVinMvubz0kIU7lXw4L01/5pP4GnK+pYpjOdJIXE
	fJctSYO89GB6tfIuhgYVO2y6nM/ABgFuZpEsCuBh1ntRA0eDSkfP+EdxauDgfXiR6O+z3O6DiMi
	nnJdqPr6Xr71nnsrg9m2ZNURF4NUBm8r78zcYaFqqvFf/jwYSKMoeej8ML+T1CRgizMKGlYQkaI
	ck1bkQp1N2+w8cqwkG0uGD/uLLDjmn6X6gObIPFrqbe/mzoXucZIbjV0RpS674ampo3Z9WqfGZ1
	1
X-Received: by 2002:a05:6000:2f83:b0:48c:4553:790b with SMTP id ffacd0b85a97d-4927fb63ecfmr790286f8f.48.1793907274442;
        Thu, 05 Nov 2026 11:34:34 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:452b:db14:9bf:f8a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm12092866f8f.6.2026.11.05.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:33 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
Date: Thu,  5 Nov 2026 20:34:25 +0100
Message-ID: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
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

vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
on any failure, so the error returned from vring_alloc_queue_split()
is lost and turned into -ENOMEM. This is especially misleading if
vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
queue size is not a power of two):

  virtio_blk virtio0: Bad virtqueue length 100
  virtio_blk virtio0: probe with driver virtio_blk failed with error -12

So the error points whoever debugs it at an allocation failure that
never happened.

Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
or vring_alloc_queue_packed(), or -ENOMEM when allocating the
virtqueue itself fails. Make the callers, virtio_pci (modern and
legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
with IS_ERR() and pass the error on. The error path in virtio_ccw
deletes a non-NULL vq, so clear vq there before taking it.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
Tested on x86_64 with a virtio-mmio virtio-blk device offering a
100-entry queue: the probe now fails with -22 instead of -12, and a
128-entry queue probes as before. The other transports are only
compile-tested (x86_64, ARCH=um, s390 with clang, W=1).

No Fixes: tag, since the error has been -ENOMEM since 2010 and nothing
regressed.

This conflicts trivially with patch 07/12 of Alexander Graf's "virtio:
support devices that own their virtqueue memory" v2:
https://lore.kernel.org/virtualization/20260818211425.91009-1-graf@amazon.com/
---
 arch/um/drivers/virtio_uml.c       |  4 ++--
 drivers/s390/virtio/virtio_ccw.c   |  5 +++--
 drivers/virtio/virtio_mmio.c       |  4 ++--
 drivers/virtio/virtio_pci_legacy.c |  4 ++--
 drivers/virtio/virtio_pci_modern.c |  4 ++--
 drivers/virtio/virtio_ring.c       | 12 +++++++-----
 drivers/virtio/virtio_vdpa.c       |  4 ++--
 include/linux/virtio_ring.h        |  6 +++++-
 8 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 881c34098a74..8b645523277f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -984,8 +984,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
-	if (!vq) {
-		rc = -ENOMEM;
+	if (IS_ERR(vq)) {
+		rc = PTR_ERR(vq);
 		goto error_create;
 	}
 	vq->priv = info;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 552d77998012..c5a30f0a2bc2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -590,10 +590,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 				    vdev, true, may_reduce, ctx,
 				    notify, callback, name);
 
-	if (!vq) {
+	if (IS_ERR(vq)) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
-		err = -ENOMEM;
+		err = PTR_ERR(vq);
+		vq = NULL;
 		goto out_err;
 	}
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e2ec0ec01d67..c403a025006e 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -396,8 +396,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	/* Create the vring */
 	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
 				 true, true, ctx, notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 8115aa39e01e..9d94fffff344 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -130,8 +130,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
 				    vp_notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 922e2df027de..28ccb2130e27 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -720,8 +720,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
 				    notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..6dd4a7651bde 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1421,13 +1421,13 @@ static struct virtqueue *vring_create_virtqueue_split(
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
 				      may_reduce_num, map);
 	if (err)
-		return NULL;
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_split(&vring_split, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
@@ -2671,15 +2671,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
+	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
-		return NULL;
+	err = vring_alloc_queue_packed(&vring_packed, vdev, num, map);
+	if (err)
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
 					context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_packed(&vring_packed, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f9559b6b2e0b..c1b6134b2267 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -208,8 +208,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
 					notify, callback, name, map);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..c808ca7e8d58 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -66,6 +66,9 @@ struct device;
  * may_reduce_num is set, then this may allocate a smaller ring than
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
+ *
+ * Returns the virtqueue or an ERR_PTR() on failure: -EINVAL if num is
+ * not a valid ring size, -ENOMEM if the ring could not be allocated.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 unsigned int num,
@@ -80,7 +83,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 
 /*
  * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue mapping operations.
+ * virtqueue mapping operations.  Returns the virtqueue or an ERR_PTR()
+ * on failure, like vring_create_virtqueue().
  */
 struct virtqueue *vring_create_virtqueue_map(unsigned int index,
 					     unsigned int num,

base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0

