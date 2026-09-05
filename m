Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8949EC75
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621688; cv=none; b=E6Z7Q40K6KWEzzqIJXgTCjqFtWcu1B8PQ33wOALI2Lq+gf72R38qP9owO2UcNkpBr0wBeMKRZNTJqLHyyCgLSY96Di1O6cmw8ADJSwNyPQaC0LSVqJm+3ReyqKpISFGaHbNkcNHwbX/Z+2mIYDah8smrSMidxcpa6LpyREjimzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621688; c=relaxed/simple;
	bh=jI2gGbzI+HUajhKyE8y1MbUEO4Zymfd1MC5nDoUrAZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFGnCPI0nW11qkqzidhRU6pOJad6pekaWXSRbQa6zESQ+Er0DB/B3lw3jy15GatxI11+2EMnI5u8Gi8T1BB0lCp9ePNg/F/b4YhSG/dQcUHUo46gyu1P+eOaQfH4sQYDqLOVRTHqRIzL0UJTppJ8tN6+OeP60QpvbwufEXNJ0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFXtyyGo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFXtyyGo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b965570d7so23706945e9.0
        for <linux-s390@vger.kernel.org>; Sat, 05 Sep 2026 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621681; x=1789226481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mqo0BMx1ifj9a2kCuZrCJMvmSnufIkatqKGeQLf7b/s=;
        b=qFXtyyGoJs5rHpXjQFSVCdscc8B1IjaAIJKlgWg3Q/fFWuEVFc0/SgQUtx32CDtJ88
         okSfUNnQg76FWheoT0eWdWNdN+wfuk1fRK4BZt2Uk4F1WDTFVRXKz5wyY/UHPlDVC5H8
         CDfAstFm+wutQxh514nLe+IVZW91HvGrPlJcyg8myWGi5pa9DFnuQMiLgvh8fE40+M/8
         eWqqhIZx6gXmPOXGQVFgXWxUsRp4fPHlYQHCuyGSWoXMSSSTPumeXx7sbT57dTRSt4Jt
         U/gCaFRGcz2rI0inTgS1xAtxfXjv2D/CF/JXq6xvIb7Shd19bh/v0gnFtV5pAi1ss+F+
         oS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621681; x=1789226481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mqo0BMx1ifj9a2kCuZrCJMvmSnufIkatqKGeQLf7b/s=;
        b=hJ91QfQIZTqPIqkB3vX/5NqpTyZNjW0ANWDNTFDVc9hxH5Fg9fFe6ee+xrWtrfRDcg
         g11KxmLEEUG/RAVmEL6y3VohFdmaUh6hOBxg9BwbblJHfXKvnPJEpqwXE3zBr77SoV6+
         PmEpDdew0EF5MT6PVwjsYr9pcbkxMIxpW3PJB6zrmISAwPbH0OvOxWyF3QXUHjuAS9hU
         nmE84DB3lHOj9Nc0pua9bnbeVrnAQmbuCu0Hc5P+rogV+KbMeh5lCOsmoJz3yIjzJJ9+
         eYsFOp50OFnQC9UnSvczki1gy7oXtoUXP9Upm/9KWmHmi9xVlfimmnj0TaQs3ffpdb17
         DSrQ==
X-Forwarded-Encrypted: i=1; AKwUvByAkKA8m4xjFrWeIbRuIIYTw/oBSmcQ3QAw/rmI7iLQT1hQhY2F17pyLNUhw9f9892iPmUNhmozia5L@vger.kernel.org
X-Gm-Message-State: AFuF++n9aBB9ygQ+DsCI/JoYDYTakPVxyqWVLlgHnGROpIwBPnkbfR1q
	x/uXpGubYBQwDizWYh2EmAH9t+HIHWA2GS81ufeTr8236MXvR1ZPoEtQ
X-Gm-Gg: AYBFou0ljd602TSwBqci6lTf3DL0eAkNwL1dvfMuDLucB9D/eroVSD0Yej5X38LyNw0
	28uDmof+MLKDQNxN0jDVlRU2ouXwTxAs+pDxo2c67lW1VjxA3ok+oZSz0WMhmLyhVnxU8rked6L
	QBq5TRqrpmCElmhj9O+Ets1HixlGh3KOwHzD4Ql797L+AKUdb/iQtkNlamUawjhxaN4e2UPVtXm
	GmMIvuSmCr7a5OLjPVaucv7Z/5rcJ9C1148+JxPMCG8vQVFKuextIIfMBHM62lGe+xPxVsRCqO/
	ww9k4Mwi2jB88Ok3vA3LKqq+RYbVcUXuN7bQsUfrvAMeK/NX00GkezKyzZbbcF1C06+fe5Sxvmv
	Rc4PDg4JIM9+X27XDXYXoTl6wBtI4EhJ82uNgFvMiyKb8IemRcrZZSxNs144X2QEwuLYwKZ483A
	0BRlq850+pTvKKJyKvifQnUJUmriBRlVsJi7ZiEeoGouakyYIMmCLGezA5UFTDFvNKTn7Q+L/sq
	4zIYNCmxOLgKCdKbXfA4nz9cBt2GFCTwNjR0lVsAEHeTQtRyhW0DHP+ZHiijaUmpExKpZGitLbi
	bCh0g0zVxsTQhm6SwMKh/QBOLM+fIhD/vk2Q0RoJERSPzH0UZ9YDdDv3OiPMmZFBtrY=
X-Received: by 2002:a05:600c:1d2a:b0:49b:12c2:104f with SMTP id 5b1f17b1804b1-49cf81e52e8mr117561445e9.1.1788621680621;
        Sat, 05 Sep 2026 08:21:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] virtio: implement synchronize_cbs for remaining transports
Date: Sat,  5 Sep 2026 17:20:59 +0200
Message-Id: <20260905152059.89560-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() now calls synchronize_cbs to wait for running
callbacks. Its synchronize_rcu() fallback does not cover workqueue or
sleepable callbacks.

Add the missing hooks. UML waits for its shared IRQ; TmFIFO takes the
existing per-direction locks held around vring_interrupt(). Virtio-vdpa
uses a per-device rwlock around its callbacks, which must already be
hard-IRQ safe.

Remoteproc callbacks can run in hard-IRQ or process context, and rpmsg
callbacks can sleep, so use one SRCU domain per rproc. Enter it before
looking up the queue. Initialize it in rproc_alloc(), returning NULL if
that fails, and clean it up at final release. cleanup_srcu_struct() can
sleep, so document that rproc_put() and rproc_free() may sleep when
dropping the last reference.

These hooks wait for callbacks already running. UML, TmFIFO and
remoteproc still allow new callbacks after reset.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/um/drivers/virtio_uml.c             | 10 ++++++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
 drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
 drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
 include/linux/remoteproc.h               |  3 +++
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141..baca6b09e9ac 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -20,6 +20,7 @@
  *
  * Based on Virtio MMIO driver by Pawel Moll, copyright 2011-2014, ARM Ltd.
  */
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -869,6 +870,14 @@ static void vu_reset(struct virtio_device *vdev)
 	vu_dev->status = 0;
 }
 
+static void vu_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
+
+	if (vu_dev->irq >= 0)
+		synchronize_irq(vu_dev->irq);
+}
+
 static void vu_del_vq(struct virtqueue *vq)
 {
 	struct virtio_uml_vq_info *info = vq->priv;
@@ -1121,6 +1130,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.reset = vu_reset,
 	.find_vqs = vu_find_vqs,
 	.del_vqs = vu_del_vqs,
+	.synchronize_cbs = vu_synchronize_cbs,
 	.get_features = vu_get_features,
 	.finalize_features = vu_finalize_features,
 	.bus_name = vu_bus_name,
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 3c6408581373..c260e3a1544e 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1135,6 +1135,19 @@ static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
 	tm_vdev->status = 0;
 }
 
+static void mlxbf_tmfifo_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
+	struct mlxbf_tmfifo *fifo = tm_vdev->vrings[0].fifo;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fifo->spin_lock); i++) {
+		spin_lock_irqsave(&fifo->spin_lock[i], flags);
+		spin_unlock_irqrestore(&fifo->spin_lock[i], flags);
+	}
+}
+
 /* Read the value of a configuration field. */
 static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
 				    unsigned int offset,
@@ -1179,6 +1192,7 @@ static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
+	.synchronize_cbs = mlxbf_tmfifo_virtio_synchronize_cbs,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
 	.get_status = mlxbf_tmfifo_virtio_get_status,
 	.get = mlxbf_tmfifo_virtio_get,
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1ed406714849..1b139d25ab2b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2410,6 +2410,7 @@ static void rproc_type_release(struct device *dev)
 
 	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
 
+	cleanup_srcu_struct(&rproc->vq_srcu);
 	idr_destroy(&rproc->notifyids);
 
 	if (rproc->index >= 0)
@@ -2507,6 +2508,11 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc)
 		return NULL;
 
+	if (init_srcu_struct(&rproc->vq_srcu)) {
+		kfree(rproc);
+		return NULL;
+	}
+
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
 	rproc->elf_class = ELFCLASSNONE;
@@ -2571,6 +2577,8 @@ EXPORT_SYMBOL(rproc_alloc);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: May sleep if this drops the last reference.
  */
 void rproc_free(struct rproc *rproc)
 {
@@ -2586,6 +2594,8 @@ EXPORT_SYMBOL(rproc_free);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: May sleep if this drops the last reference.
  */
 void rproc_put(struct rproc *rproc)
 {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d5e9ff045a28..ecc022e354db 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/kref.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 
 #include "remoteproc_internal.h"
 
@@ -89,14 +90,19 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
 {
 	struct rproc_vring *rvring;
+	int srcu_idx;
+	irqreturn_t ret;
+
+	srcu_idx = srcu_read_lock(&rproc->vq_srcu);
 
 	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
 
 	rvring = idr_find(&rproc->notifyids, notifyid);
-	if (!rvring || !rvring->vq)
-		return IRQ_NONE;
+	ret = rvring && rvring->vq ? vring_interrupt(0, rvring->vq) : IRQ_NONE;
+
+	srcu_read_unlock(&rproc->vq_srcu, srcu_idx);
 
-	return vring_interrupt(0, rvring->vq);
+	return ret;
 }
 EXPORT_SYMBOL(rproc_vq_interrupt);
 
@@ -242,6 +248,13 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
 	dev_dbg(&vdev->dev, "reset !\n");
 }
 
+static void rproc_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct rproc *rproc = vdev_to_rproc(vdev);
+
+	synchronize_srcu(&rproc->vq_srcu);
+}
+
 /* provide the vdev features as retrieved from the firmware */
 static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 {
@@ -330,6 +343,7 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.find_vqs	= rproc_virtio_find_vqs,
 	.del_vqs	= rproc_virtio_del_vqs,
 	.reset		= rproc_virtio_reset,
+	.synchronize_cbs = rproc_virtio_synchronize_cbs,
 	.set_status	= rproc_virtio_set_status,
 	.get_status	= rproc_virtio_get_status,
 	.get		= rproc_virtio_get,
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index de2af696de6c..4f9e70c1332e 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -27,6 +27,7 @@
 struct virtio_vdpa_device {
 	struct virtio_device vdev;
 	struct vdpa_device *vdpa;
+	rwlock_t callback_lock;
 	u64 features;
 };
 
@@ -123,8 +124,24 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
 static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 {
 	struct virtqueue *vq = private;
+	struct virtio_vdpa_device *vd_dev;
+	unsigned long flags;
+	irqreturn_t ret;
 
-	return vring_interrupt(0, vq);
+	vd_dev = to_virtio_vdpa_device(vq->vdev);
+	read_lock_irqsave(&vd_dev->callback_lock, flags);
+	ret = vring_interrupt(0, vq);
+	read_unlock_irqrestore(&vd_dev->callback_lock, flags);
+
+	return ret;
+}
+
+static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
+
+	write_lock_irq(&vd_dev->callback_lock);
+	write_unlock_irq(&vd_dev->callback_lock);
 }
 
 static struct virtqueue *
@@ -439,6 +456,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.reset		= virtio_vdpa_reset,
 	.find_vqs	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
+	.synchronize_cbs = virtio_vdpa_synchronize_cbs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
@@ -472,6 +490,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
 	vd_dev->vdev.map = vdpa->map;
 	vd_dev->vdpa = vdpa;
+	rwlock_init(&vd_dev->callback_lock);
 
 	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
 	if (vd_dev->vdev.id.device == 0)
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index a44368737b39..ad6bccbdfabc 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/virtio.h>
 #include <linux/cdev.h>
 #include <linux/completion.h>
@@ -230,6 +231,7 @@ enum rproc_features {
  * @rvdevs: list of remote virtio devices
  * @subdevs: list of subdevices, to following the running state
  * @notifyids: idr for dynamically assigning rproc-wide unique notify ids
+ * @vq_srcu: SRCU domain for virtqueue callbacks
  * @index: index of this rproc device
  * @attach_work: workqueue for attaching rproc
  * @crash_handler: workqueue for handling a crash
@@ -276,6 +278,7 @@ struct rproc {
 	struct list_head rvdevs;
 	struct list_head subdevs;
 	struct idr notifyids;
+	struct srcu_struct vq_srcu;
 	int index;
 	struct work_struct attach_work;
 	struct work_struct crash_handler;
-- 
2.39.5 (Apple Git-154)
