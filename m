Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EFECAAD3
	for <linux-s390@archiver.kernel.org>; Mon, 19 Sep 2022 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiISPtm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiISPtk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Sep 2022 11:49:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA364E0;
        Mon, 19 Sep 2022 08:49:38 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JFiGE2030562;
        Mon, 19 Sep 2022 15:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k5zyy+PzyR1XcIeMTHmS1nBmS8QzqDY6Kobzf54J4Bw=;
 b=dcY8HAutTxSh3a178suKUNvOJgbUerTFuAgKpkxPEzdX0zDOPu4hNwTccWatteXkPUMU
 /FimxP9zUxXPQIfXl3mjUSIurFCSg1ooVs1OV8zTnkcxSH7jh2KblxhQ5Ci5nIo7z5Rs
 vb559W4lbZuvzS9Q8NBtgSdyAJbvxxmPuwAsGKRxMj+tvxcqOptfdeikn+vMa23rQ3Ww
 bB/rCMi4fkXj15WUx5VP7G7mWtJn9Db8mMRomDYrak84bM0Qj9LkNd0YH/3rNnw7sLHt
 INNXjeO0v5ujnsIcuOGej0Pm1DdU6lnKIwN0aV47uv7VerOXvfXy8AjV/G3dWzFiXJMe uw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jpuav05jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 15:49:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28JFb85f020949;
        Mon, 19 Sep 2022 15:49:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8jp1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 15:49:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28JFnV1737945844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:49:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D01EBAE04D;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA4AAE045;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 19 Sep 2022 15:49:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 8078FE02C8; Mon, 19 Sep 2022 17:49:31 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing pavgroup
Date:   Mon, 19 Sep 2022 17:49:31 +0200
Message-Id: <20220919154931.4123002-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919154931.4123002-1-sth@linux.ibm.com>
References: <20220919154931.4123002-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOh-CxPQy2UgRryuA9yFqCrZB07wLxNe
X-Proofpoint-ORIG-GUID: uOh-CxPQy2UgRryuA9yFqCrZB07wLxNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=732 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix Oops in dasd_alias_get_start_dev() function caused by the pavgroup
pointer being NULL.

The pavgroup pointer is checked on the entrance of the function but
without the lcu->lock being held. Therefore there is a race window
between dasd_alias_get_start_dev() and _lcu_update() which sets
pavgroup to NULL with the lcu->lock held.

Fix by checking the pavgroup pointer with lcu->lock held.

Cc: <stable@vger.kernel.org> # 2.6.25+
Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index dc78a523a69f..b6b938aa6615 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -675,12 +675,12 @@ int dasd_alias_remove_device(struct dasd_device *device)
 struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *base_device)
 {
 	struct dasd_eckd_private *alias_priv, *private = base_device->private;
-	struct alias_pav_group *group = private->pavgroup;
 	struct alias_lcu *lcu = private->lcu;
 	struct dasd_device *alias_device;
+	struct alias_pav_group *group;
 	unsigned long flags;
 
-	if (!group || !lcu)
+	if (!lcu)
 		return NULL;
 	if (lcu->pav == NO_PAV ||
 	    lcu->flags & (NEED_UAC_UPDATE | UPDATE_PENDING))
@@ -697,6 +697,11 @@ struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *base_device)
 	}
 
 	spin_lock_irqsave(&lcu->lock, flags);
+	group = private->pavgroup;
+	if (!group) {
+		spin_unlock_irqrestore(&lcu->lock, flags);
+		return NULL;
+	}
 	alias_device = group->next;
 	if (!alias_device) {
 		if (list_empty(&group->aliaslist)) {
-- 
2.34.1

