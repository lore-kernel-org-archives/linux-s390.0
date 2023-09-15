Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D625FEE645D
	for <linux-s390@archiver.kernel.org>; Fri, 15 Sep 2023 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjIONKR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIONKQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 09:10:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EEC118;
        Fri, 15 Sep 2023 06:10:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD8Vx5013070;
        Fri, 15 Sep 2023 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=D1/who/gRF5tynefadDJtxhkmRq3wJ6Fe5gZe5wtKFQ=;
 b=UuBma9L2r3MAPsWuuo5zt/3w5PF5TQzYmylWcJUR6qoXwMeM8/lHPPEim1WqZ5asOv7G
 E6VNdnLfmi8gvm7Q10KTfJBQXutLcZwp3Gkphik2aVbjJTEAAg5LM20JoqY/v/HfgPde
 P7wWGFaThE1tSEfDQi6ZZPuqN4UpY0BXJF5PvfCQg6TJqvevg771Du+aRZ1vhO3OJDpZ
 C36EtW7JncX6RgdTB78v3bmJVwAaDJJ1bjVTmu0w1lZBcg8n429QAVhtB5bSFk0m7CCl
 jpId0K8YCBzcj6lw3DlLZmdoAiWKUOsLlvKROwGlB3W7vPSQQkqhcyUzzP1WbJOu0VAM 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8raqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:07 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FD8uGd016566;
        Fri, 15 Sep 2023 13:10:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8rap3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCnjU1011959;
        Fri, 15 Sep 2023 13:10:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2k7fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FDA10e22676078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 13:10:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFF0220049;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE75620040;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 5417FE057B; Fri, 15 Sep 2023 15:10:01 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Subject: [PATCH 1/3] partitions/ibm: Remove unnecessary memset
Date:   Fri, 15 Sep 2023 15:09:59 +0200
Message-Id: <20230915131001.697070-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915131001.697070-1-sth@linux.ibm.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ToChpuVrPblSoy5XBx2DnjxJi18PRI_v
X-Proofpoint-GUID: uHhdvMZeVow8bC5ZajQVW8vQE1DS_gku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

The data holding the volume label information is zeroed in case no valid
volume label was found. Since the label information isn't used in that
case, zeroing the data doesn't provide any value whatsoever.

Remove the unnecessary memset() call accordingly.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 block/partitions/ibm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 403756dbd50d..49eb0e354fc4 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -124,8 +124,6 @@ static int find_label(struct parsed_partitions *state,
 			break;
 		}
 	}
-	if (!found)
-		memset(label, 0, sizeof(*label));
 
 	return found;
 }
-- 
2.39.2

