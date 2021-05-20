Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02504C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 11:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0E66100A
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 11:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhETLio (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 07:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241436AbhETLgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621510507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kDItSm8+8o3sO4OmrJFnk4qK9G/voUO8JK5SZMKiGU=;
        b=e/PpAnxheVK9GUA94dlv7n5m2PRWE32HlBeN0jbXsIaGo2RMgo8lF5Sa5vK1q0zydd1pUw
        cV4aKzXIKisvgRwLP1A99VrRHzXce358HwdZW6jZPwbTlhDY9xeTNvsBJi/e4Ci8ySwKV5
        tqLIxnsdZik1dLzi8OGr0tO+/6i/Q3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-TK4VJ8iQNha_3HHoNYtr7g-1; Thu, 20 May 2021 07:35:03 -0400
X-MC-Unique: TK4VJ8iQNha_3HHoNYtr7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 036AD1923787;
        Thu, 20 May 2021 11:35:02 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-166.ams2.redhat.com [10.36.113.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F53910013C1;
        Thu, 20 May 2021 11:34:57 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 2/3] vfio-ccw: Reset FSM state to IDLE inside FSM
Date:   Thu, 20 May 2021 13:34:49 +0200
Message-Id: <20210520113450.267893-3-cohuck@redhat.com>
In-Reply-To: <20210520113450.267893-1-cohuck@redhat.com>
References: <20210520113450.267893-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Eric Farman <farman@linux.ibm.com>

When an I/O request is made, the fsm_io_request() routine
moves the FSM state from IDLE to CP_PROCESSING, and then
fsm_io_helper() moves it to CP_PENDING if the START SUBCHANNEL
received a cc0. Yet, the error case to go from CP_PROCESSING
back to IDLE is done after the FSM call returns.

Let's move this up into the FSM proper, to provide some
better symmetry when unwinding in this case.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-Id: <20210511195631.3995081-3-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 1 +
 drivers/s390/cio/vfio_ccw_ops.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23e61aa638e4..e435a9cd92da 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -318,6 +318,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
+	private->state = VFIO_CCW_STATE_IDLE;
 	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
 				      io_region->ret_code, errstr);
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 491a64c61fff..c57d2a7f0919 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -279,8 +279,6 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 	}
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0)
-		private->state = VFIO_CCW_STATE_IDLE;
 	ret = (region->ret_code != 0) ? region->ret_code : count;
 
 out_unlock:
-- 
2.31.1

