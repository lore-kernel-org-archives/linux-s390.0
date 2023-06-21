Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1353EB64DC
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFUNt7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjFUNtl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:49:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F019AC;
        Wed, 21 Jun 2023 06:49:38 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDlV2E019809;
        Wed, 21 Jun 2023 13:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sG2s3WxcdS8NobCYP6gIpF3UxcYbwdRKrm80hKW1ipg=;
 b=OuaQfnlVDyETJZj5JcLq38s4O9Zc7Lcu+yBA8FS54kNaULaKi4RFs28hGk0xHaSJnymF
 d2xO/6xULQzBvwgDwQ1Rp85xNcmCnU+raSGjE4T6GkmLcjP6DcaES0ml9rInwzkxFjRP
 wTY3FYVC1Y+ovaGsjb8L3Jw5IhrRsc1toBxdf+gH0Ezt1wmYTQmj6W+ssYNki1MnspC4
 p6KlvyMrxk8UM9JRK5JKj8pi9I6Ewxw/TBoL7mSwqu6KdZzHfvY8jFTDvcg2h3kjjrzU
 0fvJVW2S988Q/uuJ7xyeadTWlbwFo199VFJAVqXEHuWySjTyMLQ7dbWt8/3koLVv5i5s jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g12e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDnSIG027517;
        Wed, 21 Jun 2023 13:49:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g11s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L7uwMc004232;
        Wed, 21 Jun 2023 13:49:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r943e2sw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDnQkm20710052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:49:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E34C02004E;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA2420043;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id 83459E09BA; Wed, 21 Jun 2023 15:49:26 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 3/4] s390/ctcm: Convert sysfs sprintf to sysfs_emit
Date:   Wed, 21 Jun 2023 15:49:20 +0200
Message-Id: <20230621134921.904217-4-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9RoLG3pDj2K0MLcEcLGZUGgMMjTx29H-
X-Proofpoint-GUID: -WBmlKK_CC9nM5wv6aDR-Te5AzCJwrDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Thorsten Winkler <twinkler@linux.ibm.com>

Following the advice of the Documentation/filesystems/sysfs.rst.
All sysfs related show()-functions should only use sysfs_emit() or
sysfs_emit_at() when formatting the value to be returned to user space.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ctcm_sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/ctcm_sysfs.c b/drivers/s390/net/ctcm_sysfs.c
index e3813a7aa5e6..98680c2cc4e4 100644
--- a/drivers/s390/net/ctcm_sysfs.c
+++ b/drivers/s390/net/ctcm_sysfs.c
@@ -28,7 +28,7 @@ static ssize_t ctcm_buffer_show(struct device *dev,
 
 	if (!priv)
 		return -ENODEV;
-	return sprintf(buf, "%d\n", priv->buffer_size);
+	return sysfs_emit(buf, "%d\n", priv->buffer_size);
 }
 
 static ssize_t ctcm_buffer_write(struct device *dev,
@@ -120,7 +120,7 @@ static ssize_t stats_show(struct device *dev,
 	if (!priv || gdev->state != CCWGROUP_ONLINE)
 		return -ENODEV;
 	ctcm_print_statistics(priv);
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t stats_write(struct device *dev, struct device_attribute *attr,
@@ -142,7 +142,7 @@ static ssize_t ctcm_proto_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "%d\n", priv->protocol);
+	return sysfs_emit(buf, "%d\n", priv->protocol);
 }
 
 static ssize_t ctcm_proto_store(struct device *dev,
@@ -184,8 +184,8 @@ static ssize_t ctcm_type_show(struct device *dev,
 	if (!cgdev)
 		return -ENODEV;
 
-	return sprintf(buf, "%s\n",
-			ctcm_type[cgdev->cdev[0]->id.driver_info]);
+	return sysfs_emit(buf, "%s\n",
+			  ctcm_type[cgdev->cdev[0]->id.driver_info]);
 }
 
 static DEVICE_ATTR(buffer, 0644, ctcm_buffer_show, ctcm_buffer_write);
-- 
2.39.2

