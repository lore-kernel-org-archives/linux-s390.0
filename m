Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50215C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 18 May 2022 04:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiEREEx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 00:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiEREEv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 00:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 075DF13F1CA
        for <linux-s390@vger.kernel.org>; Tue, 17 May 2022 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652846497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3j8V/vEI/36ghefVupR/9lhtH3fLXscz8V5BpOvUSdM=;
        b=CYq2JXty3zorFH0XM+BapMt9O/yfaOxlp5H9XOO0jMfuDUxxLBD350/CbSHQTfOfAvIpPa
        aeCHeV3ZTbuz5QbwVuQgKmBVfVijczzYuoco0QOzn8RRqq/oMzGxGyUwpYHgCDuL5QzyIz
        RUS4HUhP2zNXTeGJCWDqkde5CXoM7s4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-bndQIv7dNaKHzYhwome3TA-1; Wed, 18 May 2022 00:01:33 -0400
X-MC-Unique: bndQIv7dNaKHzYhwome3TA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D56868039D7;
        Wed, 18 May 2022 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-27.pek2.redhat.com [10.72.14.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F015B1121314;
        Wed, 18 May 2022 04:01:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH V5 5/9] virtio-mmio: implement synchronize_cbs()
Date:   Wed, 18 May 2022 11:59:47 +0800
Message-Id: <20220518035951.94220-6-jasowang@redhat.com>
In-Reply-To: <20220518035951.94220-1-jasowang@redhat.com>
References: <20220518035951.94220-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Simply synchronize the platform irq that is used by us.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..4a3b66e4e198 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -345,6 +345,14 @@ static void vm_del_vqs(struct virtio_device *vdev)
 	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
+
+static void vm_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+
+	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
+}
+
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name, bool ctx)
@@ -541,6 +549,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
 	.get_shm_region = vm_get_shm_region,
+	.synchronize_cbs = vm_synchronize_cbs,
 };
 
 
-- 
2.25.1

