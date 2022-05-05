Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F70C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380519AbiEEOVY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380518AbiEEOVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A645A580;
        Thu,  5 May 2022 07:17:40 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245E0obc004627;
        Thu, 5 May 2022 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=U68aVaBS6ep9bJLNH+OSlvyhggDEkDtlzDbBUUiyW/o=;
 b=o5lwTRk8bNKCJLYusRgNXksylUsk+cDfUgWtIg0vp5SuBfTwawnT2F97zGza4PdL4+kp
 L+aJE8spiC07saIScR4flPLScF3sa/2sbVomKjNhWsiJW55B+JuuOxvEofLajRvWrBUJ
 btckapG5SIfWIUe6487pxyI8mMkvn4fO46jF6ovU7iSJQAJaCd8sMSvKOjTJK/Jr98Kk
 QEwRbFrqGFbnEK1z6tNvYkdcotEwqbp+jEt6wlhdQRPspa53I2ZZD0GCwB1kK20ShEQY
 pByXNkmSOa6QKAqOh0dhRl48P1fGfzapximRv6e/FqQmVJKuc+iS3IiY/CeWOiDO9dhc zg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvfykre9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EHRlJ011685;
        Thu, 5 May 2022 14:17:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fv6g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245EHX4956230340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:17:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3B7A4055;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57270A4051;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 13EECE03FA; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] s390/dasd: Fix read for ESE with blksize < 4k
Date:   Thu,  5 May 2022 16:17:31 +0200
Message-Id: <20220505141733.1989450-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4UGgD0-UmrBF0lYP4WF4xxyPKPNtI8VR
X-Proofpoint-GUID: 4UGgD0-UmrBF0lYP4WF4xxyPKPNtI8VR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205050103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

When reading unformatted tracks on ESE devices, the corresponding memory
areas are simply set to zero for each segment. This is done incorrectly
for blocksizes < 4096.

There are two problems. First, the increment of dst is done using the
counter of the loop (off), which is increased by blksize every
iteration. This leads to a much bigger increment for dst as actually
intended. Second, the increment of dst is done before the memory area
is set to 0, skipping a significant amount of bytes of memory.

This leads to illegal overwriting of memory and ultimately to a kernel
panic.

This is not a problem with 4k blocksize because
blk_queue_max_segment_size is set to PAGE_SIZE, always resulting in a
single iteration for the inner segment loop (bv.bv_len == blksize). The
incorrectly used 'off' value to increment dst is 0 and the correct
memory area is used.

In order to fix this for blksize < 4k, increment dst correctly using the
blksize and only do it at the end of the loop.

Fixes: 5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE volumes")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 649eba51e048..e46461b4d8a7 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3285,12 +3285,11 @@ static int dasd_eckd_ese_read(struct dasd_ccw_req *cqr, struct irb *irb)
 				cqr->proc_bytes = blk_count * blksize;
 				return 0;
 			}
-			if (dst && !skip_block) {
-				dst += off;
+			if (dst && !skip_block)
 				memset(dst, 0, blksize);
-			} else {
+			else
 				skip_block--;
-			}
+			dst += blksize;
 			blk_count++;
 		}
 	}
-- 
2.32.0

