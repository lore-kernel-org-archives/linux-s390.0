Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FBC761A6
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 14:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjDEOVt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjDEOVi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 10:21:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30CE6591;
        Wed,  5 Apr 2023 07:21:05 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Dv5VN027503;
        Wed, 5 Apr 2023 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oO/WWFon1xEc/499ljDCIN0LhnqF+enDYRtqKIaPLzs=;
 b=Ph1kL5W/6pyqj4uIVrSsiNYCX2t79fqmtb1UIhp2nKEyKmLMxSRROc9h3IBbF1AV9/qz
 s2Qe0WSb3uOGkaI9adAT3fM9J/GP1dEjZOzJHxFVvRydzzpg1/NlcxIBjzgknPQa1ZP4
 lGQxqBXz0c+8TWnMt0aiY8P68Tb1n9oD5JTjY10kJkKuuX4/32EGDEWRUi4S0m8ribAN
 pcksheFWKWS53MoOJ65GTMUfSJaqGehd8b6Rqolt5tKieuSgO+ZpcpnL3cOS5+9gyV4W
 lY0IyliqfNXiqG7u0jiocnCvdw1IiBx6/Dr02HOjmAnOvPBKKuDs75RKTXbbCMAPZ9Gy LQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psaamrrfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:23 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3354Poux020782;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ppc86thtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKHpn24249064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC2E2004B;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAAEA20040;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 7CFBCE085C; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/7] s390/dasd: remove unused DASD EER defines
Date:   Wed,  5 Apr 2023 16:20:11 +0200
Message-Id: <20230405142017.2446986-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vOKtZevdVHmqUS0oYUWkI13AnheXMUOg
X-Proofpoint-ORIG-GUID: vOKtZevdVHmqUS0oYUWkI13AnheXMUOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove definitions that have never been used.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 97adc8a7ae6b..47cad999fc2a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -444,17 +444,7 @@ struct dasd_discipline {
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
 
-/*
- * Notification numbers for extended error reporting notifications:
- * The DASD_EER_DISABLE notification is sent before a dasd_device (and it's
- * eer pointer) is freed. The error reporting module needs to do all necessary
- * cleanup steps.
- * The DASD_EER_TRIGGER notification sends the actual error reports (triggers).
- */
-#define DASD_EER_DISABLE 0
-#define DASD_EER_TRIGGER 1
-
-/* Trigger IDs for extended error reporting DASD_EER_TRIGGER notification */
+/* Trigger IDs for extended error reporting */
 #define DASD_EER_FATALERROR  1
 #define DASD_EER_NOPATH      2
 #define DASD_EER_STATECHANGE 3
-- 
2.37.2

