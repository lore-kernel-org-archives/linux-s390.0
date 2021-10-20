Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40444C4321E
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253C460EE9
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhJTLxt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhJTLxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAHEkF012779;
        Wed, 20 Oct 2021 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9mQOgumG51RSHMzvHb2R+mMePYtadAZsyBc4gtls/sg=;
 b=cCMSqpipMqAyT1kaKCKA5ikjoIFioi5K7llogudSy9xG42QLf+lBCvbVVI7R6g5ArOOr
 urrrGZhbbziJokYkYu9Fc5yIJes4P5R2p2PiZ6IeRUnYqLcojZXDdwtli8T9uB0FvQ1y
 PCiMFO3d5DijTx58LIHie0fc/MoXXVdYqHFuhROpU5t6rcpc5F3nRC1soIie7JTAsYh8
 aJ6EemWEo+9jUclc4QQ7tH2+bkvsomvrvj2I9rh208AtU0NHndSFe0QJGYfV4yD7YzV0
 plKc56U7LCF9Neb0XUtqv4EM5Ih6qydHcJaqGYnGBOQno/Ej/Grx8ZAQxCULXB/kUfZJ 6A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bth7ssqx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:31 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBlWht015264;
        Wed, 20 Oct 2021 11:51:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bqpc9sfvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBpPkt60293592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:51:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4308F11C058;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30F0011C054;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 7A505E07E2; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/7] s390/dasd: fix possibly missed path verification
Date:   Wed, 20 Oct 2021 13:51:24 +0200
Message-Id: <20211020115124.1735254-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L2uTfP41v_-Oxdcjwgwu_753L-mZqcj1
X-Proofpoint-ORIG-GUID: L2uTfP41v_-Oxdcjwgwu_753L-mZqcj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

__dasd_device_check_path_events() calls the discipline path event handler.
This handler can leave the 'to be verified pathmask' populated for an
additional verification.

There is a race window where the worker has finished before
dasd_path_clear_all_verify() is called which resets the tbvpm.

Due to this there could be outstanding path verifications missed.

Fix by clearing the pathmasks before calling the handler and add them
again in case of an error.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c     | 9 ++++++---
 drivers/s390/block/dasd_int.h | 9 +++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e34c6cc61983..8e87a31e329d 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2077,12 +2077,15 @@ static void __dasd_device_check_path_events(struct dasd_device *device)
 
 	if (device->stopped & ~(DASD_STOPPED_DC_WAIT))
 		return;
+
+	dasd_path_clear_all_verify(device);
+	dasd_path_clear_all_fcsec(device);
+
 	rc = device->discipline->pe_handler(device, tbvpm, fcsecpm);
 	if (rc) {
+		dasd_path_add_tbvpm(device, tbvpm);
+		dasd_path_add_fcsecpm(device, fcsecpm);
 		dasd_device_set_timer(device, 50);
-	} else {
-		dasd_path_clear_all_verify(device);
-		dasd_path_clear_all_fcsec(device);
 	}
 };
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 15d8731c1eee..8b458010f88a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -1305,6 +1305,15 @@ static inline void dasd_path_add_ppm(struct dasd_device *device, __u8 pm)
 			dasd_path_preferred(device, chp);
 }
 
+static inline void dasd_path_add_fcsecpm(struct dasd_device *device, __u8 pm)
+{
+	int chp;
+
+	for (chp = 0; chp < 8; chp++)
+		if (pm & (0x80 >> chp))
+			dasd_path_fcsec(device, chp);
+}
+
 /*
  * set functions for path masks
  * the existing path mask will be replaced by the given path mask
-- 
2.25.1

