Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F5C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C21F61354
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJTLxr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229941AbhJTLxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KBGxJu006872;
        Wed, 20 Oct 2021 07:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=SYv8y71Z8opMvvG94FVDEfYcwldHwNsp12tHpD7l1xA=;
 b=PNBIY5rkraNlS2OO3KEu/cB2LYlOEP5SdYPRYKU6YPObvGPJcDfSe+yz7jKXj+pc5PM1
 WDxJXwEKdU3vFSA+JlUOGPIOMeZEO8af5kbPHsnlJcRCWX6+9GOlfls5hi0D7lo3AIBK
 cK7NmpyJ1npfBfmkv2GoKs3jO5gUQu4sFVxr3d4qlKqlM46OkDkfgtmNO0ETMjXz2oOt
 JbE+XKLDosRYkV7yyiQhHsf43kAAGalCRG5jNRvmEY+xnCBonCcHcAnYMwOkA2BhHuDx
 juZ/cxsFo4zJ378ZKOx1iUgP0ts7xTFsrpqrsGRRF4oQt/ITHKNROdDh6jqb2GWf4shS Pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3btj3s8naq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBmHhl015399;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bqpcav0xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBjV0n34013502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:45:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E538E42042;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06E442052;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6EDC4E0765; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/7] s390/dasd: fix kernel doc comment
Date:   Wed, 20 Oct 2021 13:51:19 +0200
Message-Id: <20211020115124.1735254-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VczITx3R-3kCyZjLp2aSc3o_UPwcJDxB
X-Proofpoint-GUID: VczITx3R-3kCyZjLp2aSc3o_UPwcJDxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=764 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

Fix this:

drivers/s390/block/dasd_ioctl.c:666: warning:
 Function parameter or member 'disk' not described in 'dasd_biodasdinfo'
drivers/s390/block/dasd_ioctl.c:666: warning:
 Function parameter or member 'info' not described in 'dasd_biodasdinfo'

Acked-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 468cbeb539ff..95349f95758c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -650,8 +650,8 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 
 /**
  * dasd_biodasdinfo() - fill out the dasd information structure
- * @disk [in]: pointer to gendisk structure that references a DASD
- * @info [out]: pointer to the dasd_information2_t structure
+ * @disk: [in] pointer to gendisk structure that references a DASD
+ * @info: [out] pointer to the dasd_information2_t structure
  *
  * Provide access to DASD specific information.
  * The gendisk structure is checked if it belongs to the DASD driver by
-- 
2.25.1

