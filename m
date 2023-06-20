Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D108AEB64DB
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 08:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFTIfN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjFTIfA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 04:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4410D0;
        Tue, 20 Jun 2023 01:34:59 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8UU5v012680;
        Tue, 20 Jun 2023 08:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MMH4Lgq8WyBy9SKH9qqzTpow3QRzpbVBTnaiqIfkAII=;
 b=UnJLAmyxUL+K9Q11k2Iy0QgLy1gLFOWmRXfvTcV6pTyIDDO7gUP04x3reddlc6PS0IiY
 8Vhi+KgW5Qn33pe+Yv5Zv2VdID0oXCh2gbs4VjtmMiRzLomowFKrfGoVs8hCpSHl7bZX
 mpLaE3NFhpjmvb40K2GNslThIzJo4Pau0lLn7HzrLi+yYttZqYScZF5N5acEZmZUJHFd
 VOluYQXLqUA4dDq3/mpMIsyxDk2yExAG2jai6/8hsIOaxvYiw82UAX+ZDAcDPmezqodO
 29KG5EJ3dkQ7vnBSftQmoREkoh9Pov/U14R8jqg/akIfuF/2cb1cs0IotgzJh3aqNJer Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb8nfr5bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 08:34:46 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35K8VijY016360;
        Tue, 20 Jun 2023 08:34:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb8nfr588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 08:34:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35K5pYZ5030800;
        Tue, 20 Jun 2023 08:34:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f59xmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 08:34:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35K8YdUQ50790838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 08:34:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A922004B;
        Tue, 20 Jun 2023 08:34:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAB420043;
        Tue, 20 Jun 2023 08:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Jun 2023 08:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id 9BB69E0652; Tue, 20 Jun 2023 10:34:38 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Joe Perches <joe@perches.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next 1/4] s390/lcs: Convert sysfs sprintf to sysfs_emit
Date:   Tue, 20 Jun 2023 10:34:08 +0200
Message-Id: <20230620083411.508797-2-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620083411.508797-1-wintera@linux.ibm.com>
References: <20230620083411.508797-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4u9uplsA-b7QNWUlwGA2DnYKDcnpJqdE
X-Proofpoint-GUID: GuZ74cyx8sMU5eVJFYS63d6mNI5bS3n8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Thorsten Winkler <twinkler@linux.ibm.com>

Following the advice of the Documentation/filesystems/sysfs.rst.
All sysfs related show()-functions should only use sysfs_emit() or
sysfs_emit_at() when formatting the value to be returned to user space.

While at it, follow Linux kernel coding style and unify indentation

Reported-by: Jules Irenge <jbi.octave@gmail.com>
Reported-by: Joe Perches <joe@perches.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/lcs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 84c8981317b4..bd3d788e5f2d 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1901,14 +1901,14 @@ lcs_open_device(struct net_device *dev)
 static ssize_t
 lcs_portno_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-        struct lcs_card *card;
+	struct lcs_card *card;
 
 	card = dev_get_drvdata(dev);
 
-        if (!card)
-                return 0;
+	if (!card)
+		return 0;
 
-        return sprintf(buf, "%d\n", card->portno);
+	return sysfs_emit(buf, "%d\n", card->portno);
 }
 
 /*
@@ -1958,7 +1958,8 @@ lcs_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!cgdev)
 		return -ENODEV;
 
-	return sprintf(buf, "%s\n", lcs_type[cgdev->cdev[0]->id.driver_info]);
+	return sysfs_emit(buf, "%s\n",
+			  lcs_type[cgdev->cdev[0]->id.driver_info]);
 }
 
 static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
@@ -1970,7 +1971,7 @@ lcs_timeout_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	card = dev_get_drvdata(dev);
 
-	return card ? sprintf(buf, "%u\n", card->lancmd_timeout) : 0;
+	return card ? sysfs_emit(buf, "%u\n", card->lancmd_timeout) : 0;
 }
 
 static ssize_t
-- 
2.39.2

