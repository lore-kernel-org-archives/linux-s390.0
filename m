Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D451C43219
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380523AbiEEOVX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380519AbiEEOVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C95A585;
        Thu,  5 May 2022 07:17:40 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245E5eEA023423;
        Thu, 5 May 2022 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A9FO4rGpiKu+NJHDhwiIsa3Jthrv6Dd5NFWQHWYbd8A=;
 b=pyrc6nTYw7e722zWQeJd7jJmk+kD3L/mamwXefK7D/lSNsXeNClV7lcYNSloZUt7DcmK
 37RH4j11QhFwLYlkdntjmXKKvbxe2Itd7BUzqyPaKGcL9A21AVH4RESA3YmVVzPKJ4rQ
 YHivz5YpC3Tl4oJk1QCW7cWgTtU8nYW7wRapVa1wfrKn4y4ftCBixz/al0H4xOfl4ojr
 oaB3h3UjZTJF3xgwfh1zsVKeVCG9An8UqEGCAK0Z8aEkJLfWowS6PszTau/DYdgN1SSJ
 Nuz90XOF+lMHgLwz1H1StlQK4LUhWJep29UsYM7k6gUdVduKyXGcDNHiMNiBvb21onTl dg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fve8cay8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EEM4N015387;
        Thu, 5 May 2022 14:17:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3fttcj36m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245EHXJF56295812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:17:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB3FBA404D;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97D7CA4040;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 18932E040D; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/5] s390/dasd: Use kzalloc instead of kmalloc/memset
Date:   Thu,  5 May 2022 16:17:33 +0200
Message-Id: <20220505141733.1989450-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cYqld-nGdH4NhIB9xAdRS7NcZu4SOCbo
X-Proofpoint-GUID: cYqld-nGdH4NhIB9xAdRS7NcZu4SOCbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=886 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Haowen Bai <baihaowen@meizu.com>

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e46461b4d8a7..836838f7d686 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1480,7 +1480,7 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
 {
 	struct pe_handler_work_data *data;
 
-	data = kmalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
+	data = kzalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
 	if (!data) {
 		if (mutex_trylock(&dasd_pe_handler_mutex)) {
 			data = pe_handler_worker;
@@ -1488,9 +1488,6 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
 		} else {
 			return -ENOMEM;
 		}
-	} else {
-		memset(data, 0, sizeof(*data));
-		data->isglobal = 0;
 	}
 	INIT_WORK(&data->worker, do_pe_handler_work);
 	dasd_get_device(device);
-- 
2.32.0

