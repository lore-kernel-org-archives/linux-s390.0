Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86418377ECA
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845992; cv=none; b=ak2u9kM6bQdi9U+qd3oZhysvebWnAqWfcjEd4weCknctK91zFdTP+iIxP00AdFmngE9DgwP2TP1rPC+bMRqxQjzxsSiXtQu9sC5+oY4vX2zfIvUmUul9By7WPXvx9j/dkLQUNorBPR10X6dc77WAz0KlH1EkAKXPuV+zHzM1d+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845992; c=relaxed/simple;
	bh=+h/0zeWFw84evQw0JV7uXbRDUk9bZb6gKcvHxLChX5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vcuui1LjzMuvQ8N2tyCmfSQhZiNAxOEfpWFu528kbNhaO1rz9QgTnjz+PDtd+grYiY1gmYJgrXI9Fra4r+n9VcxEMOLJnCkhAuihHEwEJ2zySVq31+ka90vqP1mssgV58QG7go2SahJWOj9RueMi9LmfCXLY7OAhThzVoyQCRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHuwC9Bh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHuwC9Bh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so40296845e9.1
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845985; x=1789450785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=sHuwC9Bhp5zJInWrqmBxu6nKmmuz8oCAYfjUDOdy+MzmmMCZ8BHmkemWSq/lpT3/p9
         djM+Fl9wI7+/uBR55wakXcithRh+RYU3GLhiQAs/ALwVNRmOrfNZlTOT7830giOknf7n
         AuJ2oPRDiDHok8eRz2Kob1oyQoaWiOPZJ+8OObXzXpiz14+TaJfJjC8be2dZ1P2QBpF+
         V8gHXAlvqTd8RyEQACUeakK5nOOXhw85zHlE1u/0FdKWylSd1Y2JLrTt23fxYTaCqyA6
         ua4V5hqMpEUfUe02pFlhWgIiMzAhFmhp+202aXNx5q2OYFXkzBzrts9Z4DO0mEb8Jl92
         DmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845985; x=1789450785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=KJfIOJ2b2414knHusyW/pD9RckBsZwrE9V53xrubRtB3y1fTnlX3aHyCEfQhcZoBvQ
         AquTegVX4tXFKmDtyvYDSNfnutrjuRsY+4kldue0N2kYX5Rcjzl/ikgtb79T/PsTmr1G
         eRdwCdHoz9tj0gAcP3+p8FiDuQxEK27xoy6kBpTFTDgFZTZ3w/X0sC/Ef8zW6Vh8WKo1
         Hf5Zs6UzHnh6590wYseSYtONA7TGXxthWsuedpB4sV2hBJLgFBn4HIh6GN4oJDiVUcNs
         4J5fZZiVn1GUe2VgmAqYOEP5Sl0xjLBWPv/OkOaHh/CV50g98gKW1CnMhf5a4Gm7K1SZ
         pS+g==
X-Forwarded-Encrypted: i=1; AKwUvByQcmc+m17tvk1a1xNx+TcNcKsiyqWE6HeReBJIwC9CxmBxnnXDk88tIPpvGDSX1lzWQBkI+CSQpDJn@vger.kernel.org
X-Gm-Message-State: AFuF++mBAbRAKstdG5WgC+OW/Ph7lulbSQA64KWEzJA1BTkGX9G3HSF0
	kRwUTvhR7qW1eCU58edDjZXMNk95pEceVZh1XJ0EONKCGgtE/sOKKbY+
X-Gm-Gg: AYBFou1KsOXlSWSVXMediqRezE0lTaIXik69aNcHug6T89pMj5sBxoifJTyAYF0Ynro
	UQzqtfxImeg+OAHyeMd24A0le884kRIXmkzbRbjg108hQGavYniy3wt1mdi2uQditaRZW193jid
	3fe6EvGD4+xRRyyz5R354EtqVtEEf+WmhfajivzwxMoe6nTxF714zc0QAD7z9CO+90CBoBqdCcC
	DqJCeXuKyif4+w0gg/exPDvVPaiHNb+NxxjVedKn9qwMJUcxB+z8TgAH/S9+rVK/beYPhvIuJA4
	VF5cMoVFR+3qC5mFzvIJ5EcC4STsMotUzhU2IrIyCbXOjV+mDkzkPrSqgEFdroZhwKoXlxcnrql
	TMGM18DI6fa3ADg2bDSrS35XutrOfHrzxhSHefJwp0W5zD0xKFpZkQe8LUbyentZ/baTlwpKAMy
	OEWL6luMUMjZDAr4lT8T+0qLAwgF9eKlxlzAC2UraSEWYW/jYfHmKH8Db6QFs2s5CnWcno8sFVQ
	FQ6A2G+kmRZrqP9/adQhOaY5oWOkZHy/o3hdOrXADSfpihJK1JIUmDfWboe5iHIRA+obiE5mYE6
	GOEuM06HLfHqHaB2XignjxqTfAX2C5E=
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr470253545e9.4.1788845984552;
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
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
Subject: [PATCH v3 4/6] um: virtio_uml: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:15 +0200
Message-Id: <20260908053817.26065-5-kmehltretter@gmail.com>
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

virtio_uml invokes virtqueue callbacks from vu_interrupt() and
vu_req_interrupt(), which share vu_dev->irq. The core's
synchronize_rcu() fallback already covers these IRQ handlers.

Implement synchronize_cbs() with synchronize_irq() to synchronize with
that IRQ instead of waiting for an RCU grace period.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/um/drivers/virtio_uml.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141..1f2e62e29a27 100644
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
+	if (vu_dev->irq != UM_IRQ_ALLOC)
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
-- 
2.39.5 (Apple Git-154)
