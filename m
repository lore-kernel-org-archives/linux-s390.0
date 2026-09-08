Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3337E5F5
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845987; cv=none; b=Ywi8Duu1u8h3oi+R4/eH7m1Fl/yrY2mGvygmzhhRuwSBbL8LKsHEGGySqKpN1UMBMTJlvrywUX9czTtiqwfFHWzhxmsODusCx5bbcR1LqsdB+eG7Ok5parKm/+T3RrATyY2DU8IR21tUkTZcsuHfKireLi4alVa9HX6jnwDcwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845987; c=relaxed/simple;
	bh=aHcAwCFI8yTOgrqgZxZPyZpx9kC63bQn/NwjoFN18eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PR95abXfHj7+vy34OVNc0T2D1hBjedrEw7c48kJPdajMbPaJyBQoh7htECipLl/WESJZZFSnCTYi+23aAIxs7GRuR2SIm4jgsR6CEmOsJ9bkFfH/oy4LkVYVr8ZOJ4AHi+Aw+h6ZKBBKiiuJNNNhEhVQfwuRWGn4CZL/vCnE9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaSVNzwj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaSVNzwj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso37197825e9.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845981; x=1789450781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=SaSVNzwjc/QkT/T8KwoXzG+8FahuRTRm3nYoWB5hzA1LJomjd3MSZ/fGAXSsM9inIh
         r+P6z+Y4jLr8e8Z22g2f4ST2/kVfIcze+g+Q1YwgMgXvVI4udoYC5gE4MbcggeyR0J25
         Vhcc76tjaplrJ5hHHdDoVz4u78ZHWjS0mII5RJZ1YZJKOx8ThoySSjTO1XQlWCX9x1ZW
         oN/cy4uMbbZin85U94JAeAN3oeLa2kqTilU8meMyL7ObquYLLSk35BESg4DK873fh089
         41SQt4dfSmv6+jhis2z/jXd/Dt8HTxBKI1gjBW9l2JMjXe+DGuUdGqKoAwQK+T5uTHn6
         loaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845981; x=1789450781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=nqdILSH5lBC1q42yKpDYTcKcRWXg8YbII7P95hd6M4hxUdIY5gbrk3dl/CSIDWYBXR
         UM2r9lDtUHQBVAR1hKrit/FIkLKOsNItQF0fyIAoY/ABxVcaLcVvOeRaK5LqKeKhEh8C
         W+ZWppOEumK9WA8TvHodhuH1FMROjYcIY9PcY/bU1IMIt4kjCMFdbX6dIC5GDZKl/jVx
         ixfp+Po46Nhi0dYUX7HCmyB8ngsVrIOQogX2SyHp4JaS6JLB2oslZHSfqgOZuAhgMqub
         ohK5Opx0K0GGrhiBR2gJkudYFbYfo1xYBcVe3hsYMWSPI5BHyIjHOXbcWo+rYJo34/WX
         CzIg==
X-Forwarded-Encrypted: i=1; AKwUvByhzNy0KmCDKGfh74/wt44OKMqLM7j19IRY4ASfcwmKYyy9DXkDdeYG1U+I/IFzs4fomWK3atmc7ppJ@vger.kernel.org
X-Gm-Message-State: AFuF++ntFKE5eu8VH2rso8MK7SoKQ6rQJm+R61QdxK0SpsNGVEoIsNZW
	3QrSIpJTqn8ccoi5OLBHCtc5pKRD3gNG6MzVl1n86vwH7fwtHz6Et2pC
X-Gm-Gg: AYBFou2BaXf1Ey+XWmMbdBEt8u9Ojtiv92tLMSZ9g4acCdvY9oFJ6IdP0Dx23cNttJh
	eM0PnUflQ0UMxhuYRqBQRQv0d7SqLXSY8ToAGdSH3z1C0DaFv6Ram/yzvGnkHVJfT4lZ7YDJXic
	HLmXY3nFxksUBeYoVfvjGcRe5pP637Eml5DnP16um4iEAR2a9w2SLpsSzO8+hHvjQB0cFm4DP1A
	dA1hZobs1ztv0hqtpMoyBCOig0Llat71xHpahDhRYMUqTOj7YEQQAHY3Fx4mqej5snLMtB9kVBp
	IwkLODipTVIDCZYjQyh581HyHAnkLl+F1LwV4HemmHiE0esNIXWi+MFwrSeIirf3fYwarvfKOIs
	OxDERmDW0+1CbsTlljvlySnA8jX2KwCl/tJZfhKx9GzuvuESFiSiGrEOUiA2DOvEluj7WXmYMUx
	1AZ94hAqoBPi7PaCGl3+F+w10LHvhQ0yBmrhGCHlD53x2RQEUpwwP9N91l/6nplaYZso3kyUjRW
	EuAAFgr4tbBJe+HFOi7qbvXJ/1XnA/e3SkZ48aODfyS4GxiRlSzcjhZt9b3wYMOVhBE0z285jIW
	uDQ3tkM9x0g4kbG9Z3MHDzHeJ5wwkaE=
X-Received: by 2002:a05:600c:3b21:b0:49c:ee01:8c53 with SMTP id 5b1f17b1804b1-49cf820ab3dmr263600185e9.2.1788845980825;
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
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
Subject: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic interrupt handler
Date: Tue,  8 Sep 2026 07:38:13 +0200
Message-Id: <20260908053817.26065-3-kmehltretter@gmail.com>
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

virtio_ccw_int_handler() takes vcdev->irq_lock around its
vring_interrupt() calls only when VIRTIO_HARDEN_NOTIFICATION is enabled.

The virtio shutdown path calls synchronize_cbs() even when notification
hardening is disabled. virtio_reset_device() now does so after the
transport reset too.

For classic interrupts, synchronize_cbs() takes vcdev->irq_lock for
writing, but the interrupt handler does not take the matching read
lock in that configuration. synchronize_cbs() can return while a
callback is still running.

Take the read lock unconditionally so the write side can synchronize
with the callbacks.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b90299205698..552d77998012 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
 	 * disabled here.
 	 */
 	read_lock(&vcdev->irq_lock);
-#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
-#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
-- 
2.39.5 (Apple Git-154)
