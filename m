Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FE320CD1
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621684; cv=none; b=Bhi467MrDXoI47XywKJ2YAs89SmlYILeNLG5VlLuAOGN16UDg+bciG5FAWh8U9N3uTAdBpORjIFLDzkmBSrznD+6pHNWGbI+qvRhYKrOBVyCrh8UpFxaXtavVReDusPRUWjd/9RR8jA+IlLkyB49qsZgIVhTuLHF65jUsKRr+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621684; c=relaxed/simple;
	bh=eXG5r4mV6mtliuq56rwsHZv1ZiQbQWPta1t7fNcCzjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5EN5T4bhjqmjFYrIJosFpPUUzwY4J3VJkedc0rup+llB1V8RQ2BN/1CDFfZS7zFq5Z67DyKTwHY/Zs8XJCJJvrtjRft+qMopo/l7xHmIMC3PaqtdS5br2BS2NRqRkFGbJrZY8p+zCoLh3fp1w8Epv5vn8sjpGzfzjjxsnVmUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKwDBaR+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKwDBaR+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so18117965e9.1
        for <linux-s390@vger.kernel.org>; Sat, 05 Sep 2026 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621679; x=1789226479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=KKwDBaR+xVoJNuPew2OPxzm00SvEId9Hgpcslag6yAa1f+7i34VUFHTw5Z5mpCZYF2
         00KfOp+vgRP5EYe/z6D4Myq+2L2nZAWMygqyMpDtcMMDUaqZ/rjDsQg2xTyRV7OwzplS
         EL140uDju05eBMwgpSzR5x4sqtSDz/kxs282bJX1sUWzdt/Z1t0oHjy3AHOsDZiF+GjS
         QzQe4t0iW/YjAwBQm3zoEDNIEaO9B8LFs3uSLVKq9aQtZ1zr0WkYNz5jYdONYF+BkkAZ
         SuxVrZZSE9yvdy4zeudQ+xYJxtSlhu8pqC3bjoh16ZiZ1YNSlYswHhHQkydbdi8NmiiC
         lGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621679; x=1789226479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=ZNHxl80/2XiFUoFDu3ikjfCoh8UfeXTDd/gn1UtFTqtedBOXE5Krdsb6XemoWD+DZ/
         7jP1igX5lAym5V/IV7Fff5kQG47uPnWya+X9BkQjgeG/sQdtexU9AdcdX8wAokYbFfmy
         yhwWOvCZUvbjkNP+aqWIEAJbOjiBUwNSKdVBclpR63raN/MTONBYTurnL1M0d9vwYKOl
         g9wIU0o2pdS1qL8SSB3lTF0fUXQ+FRMd/1m88rtwyGYRJTSNWXygKDesYCHKptV/wud5
         Jj5A7rghEfjQqXWbG2AVjMILmIpzDOwKwm4b7fPy/4DiaQbtc3l6CXJ/p6H8GCNpdm/C
         swxA==
X-Forwarded-Encrypted: i=1; AKwUvBxQjQicoJsfWh//FNLAI71dkq2zcRHNX40lAM7PzbEL1rOOY6UwWQpu5dJAl+Za6tEYIkY8PJKQYWPz@vger.kernel.org
X-Gm-Message-State: AFuF++nn0h6ZEc/P9FzjOFpC7Qya8O85fglFH0uWgmy+Bw4XS1nrHMD8
	kgnDwddqsuuJ5pBnX2X8lXY55K9/9hviwHhykOPvksgu5/CpkMHBqSGT
X-Gm-Gg: AYBFou1aVQBJJ/GlGch+Lc9alEyTtCF5KDhw5WdNvT/iij9VBdzOpmX8ALvffYabWdd
	noHwkdrqbdrUP/GFWCihN5OLcpD46V7ZvjbXW18HdAAsOw/CUl9hWWuZYKXjmr0VDc0jYvlEYs9
	T5IT3nhSwTIYLZZvGHFgm/JXu6+B0OaAeb0/riaxVs4EWyylv7VGwFplmTH9aSj1Gdo1L6KX7Ey
	M7q+PbLuVEgSL8hS3VZK8ro5gQxQ1Tpr4Arfv9yEWdUyvpRWoklefNP+NAW9EriJoCnXYIgkG2e
	gHo9O1p1338Rb0QPsBPeV0f0CUz/DoLVfAvU/cgCuLhGWHq4y5h2ZnRzyJGUsI6zsw9zBDmywFe
	fR2cjyp19s0Ga8j7PWmCM0JCD+dihGZO9BG8t3Fi5j141SzJJ2IwKoCSgT2dVz0R2nLWGFM0bY5
	Sl1Fn0EYfJFxFPIKBlN6PE5NrKbQBE6WxVYV8pSpHinfzqLjMjt3oAb8Rue7JerxJO2SuGQCPve
	YbnpsnkZHe8UEx3nPhLT0UTmhK+dluuFN3IxcXOlDrP5mHkDOaTj4U1gaghqwnyDNi7xX//WsY1
	YtCN4+Mp53lrJxxYiO0/wKEOPHwrIZciTXkD2r6yu31ZK9NYJUAOLf6ofL83OuFgH50=
X-Received: by 2002:a05:600c:64c8:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49cf81f692bmr245105885e9.7.1788621678914;
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
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
Subject: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering input device
Date: Sat,  5 Sep 2026 17:20:58 +0200
Message-Id: <20260905152059.89560-3-kmehltretter@gmail.com>
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

virtinput_remove() unregisters the input device before resetting the
virtio device. virtinput_recv_events() drops vi->lock around input_event(),
so clearing vi->ready does not stop a callback that passed the entry check.
It can still use vi->idev, requeue buffers and kick the queue.

Reset first, as virtinput_freeze() already does. With the preceding core
change, reset waits for callbacks before input_unregister_device() can
free vi->idev. Recheck vi->ready after taking the lock again: keep draining
completed events so an input packet is not truncated, but stop requeueing
buffers and kicking the queue.

With evdev attached, input_unregister_handle() currently waits for an RCU
grace period, which also waits out IRQ callbacks. This masks the lifetime
bug on PCI and MMIO, but does not protect sleepable callbacks on other
transports.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..7b654af0a42c 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				continue;
 			virtinput_queue_evtbuf(vi, event);
 		}
-		virtqueue_kick(vq);
+		if (vi->ready)
+			virtqueue_kick(vq);
 	}
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
@@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
-	input_unregister_device(vi->idev);
+	/* Callbacks use vi->idev. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)
