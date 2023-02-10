Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF356C6379F
	for <linux-s390@archiver.kernel.org>; Fri, 10 Feb 2023 00:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBJADL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBJADK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 19:03:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BF5894D;
        Thu,  9 Feb 2023 16:03:07 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319Nfq1J029566;
        Fri, 10 Feb 2023 00:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HvMTKPXRUD+jl4ew3BjwdXHCfazmRAIgGfQfkRA+Rdc=;
 b=Tm1dB/NU+09SYz27KGjkqmq5QJ7/FerMiKLrQ2wwiV+ZI5NCCBjg68Fgn4iDiaKlPj/q
 OoMBmLV2lig2dVZkajq5UM78F0aYlLiKGxKs7Khufu6wl0Q3dQcQWStuz7hk0Sp67iHz
 Db4lpVhOOVjXnQ9YaujR1yv5tpy0IJ0+Pzs0WIB+UUtXf5a6uzUleRKlEFZnGdWtoeqw
 cAwGsuWrw5NsnyOC7940Fw2TwVvLgzdQcMyCQdefT7s634HmZksRfEP7naVQc6+FAZlA
 tIrJYd8dS3MNiCHmUEvLZ2KeS15iDZaR/5Vf60d3FcDsj+vq7j0sYhQU7E+0QlybnAWk vg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnaqu0chc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:03:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319ENlPp015795;
        Fri, 10 Feb 2023 00:02:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06mu9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:02:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A02sPS44040586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:02:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 491242004B;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 374C120040;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id DCFACE1263; Fri, 10 Feb 2023 01:02:53 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH 2/2] s390/dasd: Fix potential memleak in dasd_eckd_init()
Date:   Fri, 10 Feb 2023 01:02:53 +0100
Message-Id: <20230210000253.1644903-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210000253.1644903-1-sth@linux.ibm.com>
References: <20230210000253.1644903-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h8rDoV9zA0BYo7qfwrNH99V28MOnUSW_
X-Proofpoint-ORIG-GUID: h8rDoV9zA0BYo7qfwrNH99V28MOnUSW_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=926 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090217
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Qiheng Lin <linqiheng@huawei.com>

`dasd_reserve_req` is allocated before `dasd_vol_info_req`, and it
also needs to be freed before the error returns, just like the other
cases in this function.

Fixes: 9e12e54c7a8f ("s390/dasd: Handle out-of-space constraint")
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
Link: https://lore.kernel.org/r/20221208133809.16796-1-linqiheng@huawei.com
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 03ecd8846378..1a69f97e88fb 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6954,8 +6954,10 @@ dasd_eckd_init(void)
 		return -ENOMEM;
 	dasd_vol_info_req = kmalloc(sizeof(*dasd_vol_info_req),
 				    GFP_KERNEL | GFP_DMA);
-	if (!dasd_vol_info_req)
+	if (!dasd_vol_info_req) {
+		kfree(dasd_reserve_req);
 		return -ENOMEM;
+	}
 	pe_handler_worker = kmalloc(sizeof(*pe_handler_worker),
 				    GFP_KERNEL | GFP_DMA);
 	if (!pe_handler_worker) {
-- 
2.37.2

