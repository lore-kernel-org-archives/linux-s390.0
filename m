Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D5C0032E
	for <linux-s390@archiver.kernel.org>; Wed, 25 Oct 2023 13:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJYN0I (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Oct 2023 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJYN0H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Oct 2023 09:26:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1B115;
        Wed, 25 Oct 2023 06:26:02 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCeDED018088;
        Wed, 25 Oct 2023 13:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/hYQOsXj7R6YSABua406Pw+3l0JTcqPWppxY1PivYOQ=;
 b=RFINK+Tmik4rRRswxs0xmZJxb+1nFeOi1YMVJmHMsu5WgB3jBTa9Lmpq0ujp0j+RIOE/
 2VQU4jHiV/3TMtpWjW4MDyE0nNvrvMMr6yFbJFM3fsFvRR5hFu7NsRdCkH8PSiSLRNdS
 ViY5mzirjtos/ypogl7YWMJkKbYo/MmJI6OHu9dISO8BGCgnoEyQ7FaXuLpxwDE5PaQA
 9OfToY9HnlGuDFbC3/iPRuvYMZVb2aNS1QzEKFEozKWwjf8Xgoc8Kk0AURUklOPLHpkV
 sQOzr0XNoDJRen+zKyrZzCRu3/tRSAlLLElBqPh3CfOwUTZedTS96cBohXsVUCrmDNjO Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty37r1v6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:26:00 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PDGWFU018719;
        Wed, 25 Oct 2023 13:26:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty37r1ucj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:25:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCVTY3012399;
        Wed, 25 Oct 2023 13:24:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1xatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:24:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PDOcx341812282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 13:24:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA522004D;
        Wed, 25 Oct 2023 13:24:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD1020043;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A0D5DE00BC; Wed, 25 Oct 2023 15:24:37 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH 1/2] s390/dasd: resolve spelling mistake
Date:   Wed, 25 Oct 2023 15:24:36 +0200
Message-Id: <20231025132437.1223363-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025132437.1223363-1-sth@linux.ibm.com>
References: <20231025132437.1223363-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nwVWVbF9RctzOO1vHzJlauJAebwAyF-x
X-Proofpoint-GUID: t46tT2m9dliSdI74RRtK8eKqOSaDBkhx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250116
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

resolve typing mistake from pimary to primary

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Link: https://lore.kernel.org/r/20231010043140.28416-1-m.muzzammilashraf@gmail.com
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8a4dbe9d7741..acdaba55b041 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -283,7 +283,7 @@ struct dasd_pprc_dev_info {
 	__u8 secondary;		/* 7       Secondary device address */
 	__u16 pprc_id;		/* 8-9     Peer-to-Peer Remote Copy ID */
 	__u8 reserved2[12];	/* 10-21   reserved */
-	__u16 prim_cu_ssid;	/* 22-23   Pimary Control Unit SSID */
+	__u16 prim_cu_ssid;	/* 22-23   Primary Control Unit SSID */
 	__u8 reserved3[12];	/* 24-35   reserved */
 	__u16 sec_cu_ssid;	/* 36-37   Secondary Control Unit SSID */
 	__u8 reserved4[90];	/* 38-127  reserved */
-- 
2.39.2

