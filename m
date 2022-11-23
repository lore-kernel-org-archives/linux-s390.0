Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D07C46467
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiKWQHj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiKWQHf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 11:07:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99DE6A;
        Wed, 23 Nov 2022 08:07:30 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANFvRwP018007;
        Wed, 23 Nov 2022 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i2n+yCT8g7dE+juF0JcPtVakNLBitiv+qwBSY21j/sA=;
 b=beZT5s7OqxIgGkPcSOzyFLrZwPCIhEM/Jqn6+7kDdlb6RT+hZ0CP7RNGRdsZGT9OPdr/
 bBXN/9jj21FX2YhzLRenSiBcRNgg+GHMoYfVhmD5AHZBdXwyJ6F2jGfv1yVUZc6ZKd8r
 BlojIVEgWvoDnFaCvqnLf3Efsj9CyYQ0XGkyWYek7qSpHZJYKEBktTrhZFs1vON2WZgE
 FOOrFe4KRJ/H9n90wQocAuXoY3k4GU2ojVIuBt9SQZNNwG3HorlxJMczUNGDqaH8B9z5
 vLXorG85YqRLqq0LmxDjIvpTsQpXTNdjP5ai/NpW+xcQdMx/kKrMS1qHAE54d4wyD356 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10w60twk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:28 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANG24s6000354;
        Wed, 23 Nov 2022 16:07:28 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10w60tvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANG6mwR004928;
        Wed, 23 Nov 2022 16:07:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kxps8xfhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANG7KQE52298070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:07:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45589AE06C;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B0DAE05F;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id ECA5AE08BB; Wed, 23 Nov 2022 17:07:19 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH 4/4] s390/dasd: fix possible buffer overflow in copy_pair_show
Date:   Wed, 23 Nov 2022 17:07:19 +0100
Message-Id: <20221123160719.3002694-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123160719.3002694-1-sth@linux.ibm.com>
References: <20221123160719.3002694-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zy0Q1Egd2lia6b5laxw2CTUutA86pKLN
X-Proofpoint-ORIG-GUID: uaM_BThmGqrUYeO46_Kt5IFjNA4XuB3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

dasd_copy_relation->entry[] array might be accessed out of bounds if the
loop does not break.

Fixes: a91ff09d39f9 ("s390/dasd: add copy pair setup")
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index cb83f81da416..df17f0f9cb0f 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1954,7 +1954,7 @@ dasd_copy_pair_show(struct device *dev,
 			break;
 		}
 	}
-	if (!copy->entry[i].primary)
+	if (i == DASD_CP_ENTRIES)
 		goto out;
 
 	/* print all secondary */
-- 
2.34.1

