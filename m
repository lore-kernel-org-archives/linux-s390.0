Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D16C433FE
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380512AbiEEOVW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380516AbiEEOVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79E5A2E3;
        Thu,  5 May 2022 07:17:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245C31CO023383;
        Thu, 5 May 2022 14:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=PG+QRM6m4qQLCd82DTltcTGFTuWGN27P9ufETESp5k8=;
 b=lzUh0uGN2X3HmbIwUOxEKMjX8xocouoL+EzF8T/9+PymOSJxAD13dQ69wcXRGlP+JZR+
 mEGTKic2ODOG69GA+EO9IXcLU03lZtbk++oi/8H9vmIBfhmbUkm9k6vQm0bTimBKDgWz
 YBSTf0Ft37pn9JEgcrvph+b1frLymYmP0o9X4RgLloCvBd87G42wzpVBB9+ZfUoBCenR
 QIGb1jMuT7WB0b9V8s2BT7ajjMwMPupposUra02X1jEHvqmTHY7eUA6Ac4cG9Bj1acn+
 bAJ/eQ7TM8ojlMCK7F2CFKtQm5htZwdXpKSdY28wc8DjIX66AU1aGxb6zQJqUhIEEqRw dA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fve8cay89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EEXnl015560;
        Thu, 5 May 2022 14:17:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3frvr8nw3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245EHSVd23789986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:17:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6264952052;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 502D15204F;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 163BBE03FE; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/5] s390/dasd: Fix read inconsistency for ESE DASD devices
Date:   Thu,  5 May 2022 16:17:32 +0200
Message-Id: <20220505141733.1989450-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BzLPlQX9nYFOAmVRaPZPDNBWlIN_HoLT
X-Proofpoint-GUID: BzLPlQX9nYFOAmVRaPZPDNBWlIN_HoLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=950 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

Read requests that return with NRF error are partially completed in
dasd_eckd_ese_read(). The function keeps track of the amount of
processed bytes and the driver will eventually return this information
back to the block layer for further processing via __dasd_cleanup_cqr()
when the request is in the final stage of processing (from the driver's
perspective).

For this, blk_update_request() is used which requires the number of
bytes to complete the request. As per documentation the nr_bytes
parameter is described as follows:
   "number of bytes to complete for @req".

This was mistakenly interpreted as "number of bytes _left_ for @req"
leading to new requests with incorrect data length. The consequence are
inconsistent and completely wrong read requests as data from random
memory areas are read back.

Fix this by correctly specifying the amount of bytes that should be used
to complete the request.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org # 5.3+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d62a4c673962..ba6d78789660 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2778,8 +2778,7 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
 		 * complete a request partially.
 		 */
 		if (proc_bytes) {
-			blk_update_request(req, BLK_STS_OK,
-					   blk_rq_bytes(req) - proc_bytes);
+			blk_update_request(req, BLK_STS_OK, proc_bytes);
 			blk_mq_requeue_request(req, true);
 		} else if (likely(!blk_should_fake_timeout(req->q))) {
 			blk_mq_complete_request(req);
-- 
2.32.0

