Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108D380FCA
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845992; cv=none; b=ru05K3LrH11Ipanaiq73IvFv1YUoOtL0nfdR1zb5tc8+1RDqAoyGLqXmpECVTsWrzwm6CHCdUuwLq2FEl47Ik3KorQP9yGoGiP89Bw57B3+5bFYjY5LkiZf+678iUquEnH+XrhLsN0RGsgEOLL6d3m76uko619XffuCLyNyHZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845992; c=relaxed/simple;
	bh=+wdB7PxXXtKvNQ35EUFAY1t6ihDReA2lJ+JGlRl8HqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAYLegAKrusSNmSukltQ0l6RpXamgnT8GsF88X0FS0eUUjqPQCQf5dV65Ge/Nwi4dD1/SPDovw1aH+C6XFAQXv8Bf5YQ+uD2KpJ+ER94GVS2tJlJVGsbtCsb3NyHMSCJ+DIQ7SpASHJ9Ijlvgm1y2iJzAgih5Dd9ENF3oH8LnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy6jspNb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy6jspNb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso40940455e9.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845986; x=1789450786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=dy6jspNbxGAKGG3lIe/bspSeQ5j6q6O7nVNct+gSf+FKrKUULLHhV4YZxLyD0FyzPP
         5hCuizsetB/+39eiGzEi2UYzh/o2UrulEoDzGOEOimzTa7zUE3kIDqj6RdcmykWRNDMs
         XaxvwNCZTh9iAOBYKGR+e9eCCk+LaMpQuppd9go90pCBSfbYMiQoQp6WFlCvE0ojmTI7
         5EfY5SjAJE1+pJlnUwlgKZO9u6lhxwY0Sj1NYKXMko8BRuvXThgKVpdRSQWtILOlovgH
         3UbNOCwk19AmEURMWAFD6nRY2x1FC3lAAHVAnNPos6nLvfItW/9fN5KJMKcMPtNn/DCb
         4GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845986; x=1789450786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=X2jx3aOMrQiMeM3lU+N8KWJ+J/WI/JE6ImAc08KAUNf7siO1i3H3o9EgFDJgKDFZpY
         fQO4FBwttOjznWdtHcJuKpKZ8LIIWlv2HoZvQdAang7nDRQGCqrecAOIhfkJpI93j1lz
         d+ZXTbqgEV/RMKQwUvBhCf2xL3DbZHicJ/KlrzUJYv5qSQBRi6yp9EMAV5KlMZrdVji+
         6zXGXWV0mf3xQIyOlVraJPyfmgGTha/iuWVT5MUF4seo74C1NwYUMKdHJENJcmdr4jXy
         x4Zli6wy/sV8nalnFXyvEr23wDSvx3DVVARUrCZIP0cWgVIsUfikhZvFuKixAdMCxiHt
         XuMQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9V+E9u2KIGQ2eg4QCHJTyWYZ4cNk8GD4RLOFtG5WPi7MaNeTA8/PO2W1YU8IwEZZY0rg7UVe/avyf@vger.kernel.org
X-Gm-Message-State: AFuF++kaQvMX+SJH8YyW5wEs0qvBSCAa5S/epbtqv+oQXuq6r7djo/XH
	kD0ftKuIvc97yFwrOEDSkFSG16+qjhZUdQUlZems8BpHClFkpUbfd7qd
X-Gm-Gg: AYBFou2OHFX1HGwzIUc0V3WghT725rJrVT/f89FMco9Weh68cuQotIfkTOOSeYTNEse
	GgED6OlDK3clZFNsdKjb7mkd0GsVh0hC95gWt6Q9NLAQjAKCwWgCriGXAfeWJjTSRBSONSiK4TX
	JJoyb9/4RHSRtFN1C1h7sIQ+HkVBwMixulFF/AV5G0vA3ufS20ACJStiLMuUauQbU75h6w/cMCc
	tsekbn0+zeEfgmMT4oTZF3SURhoM0q9ybr2hvxM7Uhy+kLox3BX3ddNqtP7+gXda4n3kOk9X9nO
	ha172mt8dilwo/SJGRBzJGtrcJ3u2FzC8P3NjIEr+teatkxTbvp1sOsgzVvhAIZqQjg3tG5pOeK
	y8XbaT1ScvIJrMq/gtB8570Cx8K4U9M+Ijl18EAbFQ1xSDdpA3hLpC9nRBiuxBXqRVsc+bYhGPE
	P5mDAIeZhLOj9tJqpAh/teVZNQ4/KXQb0POyAdoslGDxS1BOmDRLh3H7fUy3Y8dvwsIt/cWVb3m
	mjlIXdhoLrLzlW+flDHoOaPxarIaRdDRYMnss4xc55TbhM5BNnb8L3P2rPONAUL7ewgdazHQISk
	NT8MWOr+aN+5kWR0j7PNFC0A2Gu0oYFU3qPrBaFuNJY=
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr203278645e9.30.1788845986284;
        Mon, 07 Sep 2026 22:39:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 5/6] platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:16 +0200
Message-Id: <20260908053817.26065-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TmFIFO invokes virtqueue callbacks from its FIFO work item under
spin_lock_irqsave(). The core's synchronize_rcu() fallback already
covers those sections.

Implement synchronize_cbs() using the existing per-direction locks
instead of waiting for an RCU grace period. fifo->spin_lock[0] covers
the transmit callbacks, including the callback from the timeout
handler. fifo->spin_lock[1] covers the receive callbacks. Take and
release each lock in turn to synchronize with callbacks running
under that lock.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 3c6408581373..664bec20a7ae 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1135,6 +1135,20 @@ static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
 	tm_vdev->status = 0;
 }
 
+/* Synchronize with callbacks running in the FIFO work item. */
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
@@ -1179,6 +1193,7 @@ static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
+	.synchronize_cbs = mlxbf_tmfifo_virtio_synchronize_cbs,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
 	.get_status = mlxbf_tmfifo_virtio_get_status,
 	.get = mlxbf_tmfifo_virtio_get,
-- 
2.39.5 (Apple Git-154)
