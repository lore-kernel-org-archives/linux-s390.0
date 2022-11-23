Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310CC4332F
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiKWQHd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiKWQHc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 11:07:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B0BB9;
        Wed, 23 Nov 2022 08:07:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEbDXa002372;
        Wed, 23 Nov 2022 16:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=nRklbZ+rJiirAx94wRklHtjRr/Bmlm9o2s4m9AxA7xk=;
 b=ErArvUOmA1u24QiP1v50szV9IU17qYfwctma0JHAbTcrsV4qjBJwgpeDTE7KcMRrCycU
 4/zSB1BUWaEsJLHHK7bj3UIIlMYei8tKG9UgjbMyvtxdUXUL0/XE0xkab7j/6TWBTR+g
 ziNAlZLIAig+KZsITpwqok9HTEBr7KZtWCAXY0qhq5OU++cym4s6bsnHylRkbciDl+oW
 DmNFsEFh/qy6sXqLH3Gj9hOtyNSlRZL3qRD/oNr8AUpl4B37ZUuBQAnM1Zcd5XjmO7iv
 l/RcmdEvmFpB06W58l5ATlQrmDvAJcCuvC4ILIR7mnokdc13zMM5+CiIo2ZTQseQKLHp Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100t38nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANEbnND005350;
        Wed, 23 Nov 2022 16:07:26 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100t38nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANG7Mra021827;
        Wed, 23 Nov 2022 16:07:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3kxps94rp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANG7KKO57672116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:07:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E609AE064;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D11CAE056;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id E4C30E029C; Wed, 23 Nov 2022 17:07:19 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH 1/4] s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"
Date:   Wed, 23 Nov 2022 17:07:16 +0100
Message-Id: <20221123160719.3002694-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123160719.3002694-1-sth@linux.ibm.com>
References: <20221123160719.3002694-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z_VmGKriz-uTwPnhQL58WKSe2MhmsC9C
X-Proofpoint-ORIG-GUID: dABXkQM0ybOQSAMwakI2KtYxx3ENikX3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20220923132103.2486724-1-colin.i.king@gmail.com
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index d0ddf2cc9786..9327dcdd6e5e 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -401,7 +401,7 @@ dasd_ioctl_copy_pair_swap(struct block_device *bdev, void __user *argp)
 		return -EFAULT;
 	}
 	if (memchr_inv(data.reserved, 0, sizeof(data.reserved))) {
-		pr_warn("%s: Ivalid swap data specified.\n",
+		pr_warn("%s: Invalid swap data specified\n",
 			dev_name(&device->cdev->dev));
 		dasd_put_device(device);
 		return DASD_COPYPAIRSWAP_INVALID;
-- 
2.34.1

