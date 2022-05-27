Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4AC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 06:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiE0GBw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 02:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiE0GBt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 02:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97828FCB
        for <linux-s390@vger.kernel.org>; Thu, 26 May 2022 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653631304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lynSeVT1NfwEzANWSPivWToMg2lFwBVUR0GD7hlFiwg=;
        b=iiz8C+RHjA4OxZUHeRcz4KtO3gR8F6YwGahbqTN1ElXnWuUwgv6+DSTGo+yNlJxaBzfkJw
        K023Oy6KbPiRMXFfGHRzYj0EAyDZT87WQdqXza2cV/7zrPSFkqKi3THJZ2J7vPm9ukmTQd
        id1k3aOQk4zCYovHAGh70HEub4P8RoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-mZNTa0xxM2Os7yz2KbfjHg-1; Fri, 27 May 2022 02:01:40 -0400
X-MC-Unique: mZNTa0xxM2Os7yz2KbfjHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1B3E811E7A;
        Fri, 27 May 2022 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 608292166B26;
        Fri, 27 May 2022 06:01:31 +0000 (UTC)
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
Subject: [PATCH V6 1/9] virtio: use virtio_device_ready() in virtio_device_restore()
Date:   Fri, 27 May 2022 14:01:12 +0800
Message-Id: <20220527060120.20964-2-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-1-jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

It will allow us to do extension on virtio_device_ready() without
duplicating code.

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
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ce424c16997d..938e975029d4 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* Finally, tell the device we're all set */
-	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
 
 	virtio_config_enable(dev);
 
-- 
2.25.1

