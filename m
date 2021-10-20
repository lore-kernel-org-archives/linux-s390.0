Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E167C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3462061361
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJTLxw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJTLxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K9HsAQ008042;
        Wed, 20 Oct 2021 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ErnjFKuSEgeFJkqh9PqDDDAhYIB9h+HYjpCXRKGDDf0=;
 b=Qkr0K2gwQhYF0vRl0zmp4Rke1f5IuvyJvN5fuqUkmTOpPZj9k1q15tFBTafOMXHWmv+h
 yCoKBFusF7GcQiaBmH2wU4sjHEGhm/5Tq5MBCPKDKs1hfjzq4VfAMp3eIj+FkJxEcjVo
 yQRmWiK0Kv1fNTx8wzkvYMAuGZxm79IbUnc5w1WNX4iFS5ow+crpyCdllJLf2RhZvDDD
 RoU0afhwfQ2pe13IfGJLVkwGsKs3kfota7l4GvwTFicTIQHSaSy05NY14XI5oKrkCWJ7
 eEmGFwMG5gGdJmpk5dwZnJcT3TbMtqG0ISVoeV4lskwsWWMueNq4ZSCnTlH6TqKvj3ZH EA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btgbv2wpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBmMAl005008;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3bqp0k9g45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBjVCB58392920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:45:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E138D42056;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD94E4204B;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 73672E079A; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/7] s390/dasd: move dasd_eckd_read_fc_security
Date:   Wed, 20 Oct 2021 13:51:21 +0200
Message-Id: <20211020115124.1735254-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7qELstQfIyHVEd5Py3Eo48lmPo33reqR
X-Proofpoint-ORIG-GUID: 7qELstQfIyHVEd5Py3Eo48lmPo33reqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

dasd_eckd_read_conf is called multiple times during device setup but the
fc_security feature needs to be read only once. So move it into the calling
function.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index f6ff26472936..248006291c29 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1189,8 +1189,6 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 		}
 	}
 
-	dasd_eckd_read_fc_security(device);
-
 	return path_err;
 }
 
@@ -2101,6 +2099,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	if (rc)
 		goto out_err3;
 
+	dasd_eckd_read_fc_security(device);
 	dasd_path_create_kobjects(device);
 
 	/* Read Feature Codes */
@@ -5788,6 +5787,8 @@ static int dasd_eckd_reload_device(struct dasd_device *device)
 	if (rc)
 		goto out_err;
 
+	dasd_eckd_read_fc_security(device);
+
 	rc = dasd_eckd_generate_uid(device);
 	if (rc)
 		goto out_err;
-- 
2.25.1

