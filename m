Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbfKNKUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:20:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAJ6wO037241
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:20:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92b9drjj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:20:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/11] s390/qeth: clean up error path in qeth_core_probe_device()
Date: Thu, 14 Nov 2019 11:19:18 +0100
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Message-Id: <20191114101924.29558-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_core_free_card() is meant to be the counterpart of
qeth_alloc_card() - but unfortunately was also picked as the place
to free the QDIO queues.

This gets messy when qeth_core_probe_device() fails during
qeth_add_dbf_entry(). At this point the card->qdio.state is not initialized
yet, so qeth_free_qdio_queues() ends up operating on uninitialized data.

Luckily for now, the whole qeth_card struct is zero-allocated and the value
of the QETH_QDIO_UNINITIALIZED enum is 0 as well. So there's no real impact
from this bug at the moment, it's just really fragile.

Clean this up by moving the qeth_free_qdio_queues() call up one level in
the hierarchy. This way it doesn't get called from the error path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 08185f76a727..f1f56e354516 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4855,7 +4855,6 @@ static void qeth_core_free_card(struct qeth_card *card)
 	qeth_clean_channel(&card->data);
 	qeth_put_cmd(card->read_cmd);
 	destroy_workqueue(card->event_wq);
-	qeth_free_qdio_queues(card);
 	unregister_service_level(&card->qeth_service_level);
 	dev_set_drvdata(&card->gdev->dev, NULL);
 	kfree(card);
@@ -5768,6 +5767,8 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 		qeth_core_free_discipline(card);
 	}
 
+	qeth_free_qdio_queues(card);
+
 	free_netdev(card->dev);
 	qeth_core_free_card(card);
 	put_device(&gdev->dev);
-- 
2.17.1
