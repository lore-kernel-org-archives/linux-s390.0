Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbfICNgx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 09:36:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83DXMGH011977
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 09:36:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usqvykqq5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 09:36:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Sep 2019 14:36:43 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
Date: Tue,  3 Sep 2019 15:36:18 +0200
Message-Id: <20190903133618.9122-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

The intention seems to be to warn once when we don't wait enough for the
reset to complete. Let's use the right retry counter to accomplish that
semantic.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..5c0f53c6dde7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 				msleep(20);
 				status = ap_tapq(apqn, NULL);
 			}
-			WARN_ON_ONCE(retry <= 0);
+			WARN_ON_ONCE(retry2 <= 0);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
-- 
2.17.1
