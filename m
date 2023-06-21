Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ADAC0015E
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFUNuA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjFUNtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:49:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531A199C;
        Wed, 21 Jun 2023 06:49:43 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDcRGo015105;
        Wed, 21 Jun 2023 13:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pMcLak2rYx8SqLhHblPC3QQT5hY7ikWpfdeBTuFjxio=;
 b=K9Rg52vZD6jWM0I8tDYgfcBC/12vFVnJ39HxBC9ELSEa8oWF7h0rLfvi2XRrlcEIC5M/
 rEcRGvs9lpVEIsY3oTcqzGMImtJyW/Ud+j+Rb1VrPgqKPGC25ve1ev5PvnSBmBZ8bW+8
 bQJk5Zxb52UxQYdq5M/Jl46o5BVjQNMlaZoo2p4e3vwwghPoW67trUpCUMLWD11veGHX
 x+mVM4QI5lWhGEsi1TNVYt4rVJaQIpcrRks++ecG1RORg+rj21gGON6tdKvOCPKoxiH8
 6ptLM9gOffVKsdI2tj6JuFWCPOA17GQCgO77iydG9HRFkrz/0rQFPqzEwZhMJeiauclZ +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc29408tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:33 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDcdI3015385;
        Wed, 21 Jun 2023 13:49:32 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc29408st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L2m5Cx016438;
        Wed, 21 Jun 2023 13:49:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5astw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDnQfS42991892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:49:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D17562004B;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF94720040;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id 7C236E08F9; Wed, 21 Jun 2023 15:49:26 +0200 (CEST)
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
        Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 1/4] s390/lcs: Convert sysfs sprintf to sysfs_emit
Date:   Wed, 21 Jun 2023 15:49:18 +0200
Message-Id: <20230621134921.904217-2-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uO5ev5n7hmNGjY87CbGQ_smvjDbl5Cgh
X-Proofpoint-GUID: _Z42iq72mdLbb8njR9cFM_J8I9RT7Yxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210114
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
Reviewed-by: Simon Horman <simon.horman@corigine.com>
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

