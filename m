Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB247C43334
	for <linux-s390@archiver.kernel.org>; Wed,  6 Jul 2022 22:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiGFW0Z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiGFW0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 18:26:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CF2AE30
        for <linux-s390@vger.kernel.org>; Wed,  6 Jul 2022 15:26:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266KpqvH000789
        for <linux-s390@vger.kernel.org>; Wed, 6 Jul 2022 22:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=M2v2kxX2W7zaedy0sz/UcSyKi8ja8yPLO18tmv+3yko=;
 b=YvnNgDWeCp8t/dcsK4WNdSvMLE9c1jGGXo8ATUfx4hZoCOM28lIXEv2NcEnKGjAFs1B/
 /M/t6r1hnOmycU+Ogf9zYWFaHH0n9Dw9cKAP9xXp2cHesDctW83a2UStpOcwaZI0i3n4
 vTARJ0VOyuuHNivnUvfb+nZvlKGqcgIpYLOyOS+qgr39YT5eKgNEnrUh3RCTvwJTjfv3
 O6fP/dSoBMGceMJcnuHQFdyyLEG492i3N6bHpUl/rV+4QUPNauXXIlxFlcVPcHWI0L7z
 qy9OgSlxuLdh/yNzkuV2v13UIst7Y+qRJ7WrzqoHZPb4iMsGxkbTzFp88fh8Eq4OLUPb Zg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5ht8su4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Jul 2022 22:26:23 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266MKaH3020195
        for <linux-s390@vger.kernel.org>; Wed, 6 Jul 2022 22:26:23 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3h4uqy107h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Jul 2022 22:26:23 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266MQLxK35848602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 22:26:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B40D96A04F;
        Wed,  6 Jul 2022 22:26:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D2B6A047;
        Wed,  6 Jul 2022 22:26:21 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.65.200.23])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 22:26:21 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH] s390/ap: fixes bug in the AP bus's __verify_queue_reservations function
Date:   Wed,  6 Jul 2022 18:26:19 -0400
Message-Id: <20220706222619.602094-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CKRNMO3ab_vMIFRObMwScJMNqqvUunbM
X-Proofpoint-GUID: CKRNMO3ab_vMIFRObMwScJMNqqvUunbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060083
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The AP bus's __verify_queue_reservations function increments the ref count
for the device driver passed in as a parameter, but fails to decrement it
before returning control to the caller. This will prevents any subsequent
removal of the module.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reported-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 5c13d2079d96..0a9045b49c50 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1435,7 +1435,7 @@ static int __verify_queue_reservations(struct device_driver *drv, void *data)
 	if (ap_drv->in_use) {
 		rc = ap_drv->in_use(ap_perms.apm, newaqm);
 		if (rc)
-			return -EBUSY;
+			rc = -EBUSY;
 	}
 
 	/* release the driver's module */
-- 
2.31.1

