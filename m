Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A1C4167D
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiEEOVZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiEEOVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F425A58C;
        Thu,  5 May 2022 07:17:41 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245EFi7j018546;
        Thu, 5 May 2022 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J/n9h2oxwCOMowRfCot9D/H4NtObJxnp9opzuVMQ8RA=;
 b=KUiGZzkFijbmBQfR8ogpcr/wiBz9Wp2H2eFfU6/2ShSTMVtJ6e7cSEY1Qdtdf5U5CB9c
 5Y3+VJxoZEhsZfxlgVFCsVjKldpQzFTquuIUB5Zuhb1kOYmnet4X7PjVvJeobvy7V4RS
 gTsj7WPH+oBmM0QADAslxLHmtEX7DdUuW5x7KvCOq7Zia1BJvJ7oN0Pt4fXq4K2ocEx2
 a20vfWMcO/801NqBPrgPijmqgiXmyFskvH+nS8lE6HovniWb4aeo5+Jb2iuqVARjwNSD
 C4g/Nk+SOuyRWI9w9LOqfimFsmAhWjRAQ9KXhfIZgpQoWg3WAqsIyXs/dnHny9oDbW3/ rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvg6k01c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EEoKm028340;
        Thu, 5 May 2022 14:17:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fvg610035-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245EHSfK35062226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:17:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ECDD52050;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4C4155204E;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 1195CE03D6; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/5] s390/dasd: prevent double format of tracks for ESE devices
Date:   Thu,  5 May 2022 16:17:30 +0200
Message-Id: <20220505141733.1989450-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SFDzPPO3V7V8Ef6CxOe2li2x4-1h2Bw7
X-Proofpoint-GUID: SFDzPPO3V7V8Ef6CxOe2li2x4-1h2Bw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For ESE devices we get an error for write operations on an unformatted
track. Afterwards the track will be formatted and the IO operation
restarted.
When using alias devices a track might be accessed by multiple requests
simultaneously and there is a race window that a track gets formatted
twice resulting in data loss.

Prevent this by remembering the amount of formatted tracks when starting
a request and comparing this number before actually formatting a track
on the fly. If the number has changed there is a chance that the current
track was finally formatted in between. As a result do not format the
track and restart the current IO to check.

The number of formatted tracks does not match the overall number of
formatted tracks on the device and it might wrap around but this is no
problem. It is only needed to recognize that a track has been formatted at
all in between.

Fixes: 5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE volumes")
Cc: stable@vger.kernel.org # 5.3+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c      |  7 +++++++
 drivers/s390/block/dasd_eckd.c | 19 +++++++++++++++++--
 drivers/s390/block/dasd_int.h  |  2 ++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 76d13c5ff205..d62a4c673962 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1422,6 +1422,13 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		if (!cqr->lpm)
 			cqr->lpm = dasd_path_get_opm(device);
 	}
+	/*
+	 * remember the amount of formatted tracks to prevent double format on
+	 * ESE devices
+	 */
+	if (cqr->block)
+		cqr->trkcount = atomic_read(&cqr->block->trkcount);
+
 	if (cqr->cpmode == 1) {
 		rc = ccw_device_tm_start(device->cdev, cqr->cpaddr,
 					 (long) cqr, cqr->lpm);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e3583502aca2..649eba51e048 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3083,13 +3083,24 @@ static int dasd_eckd_format_device(struct dasd_device *base,
 }
 
 static bool test_and_set_format_track(struct dasd_format_entry *to_format,
-				      struct dasd_block *block)
+				      struct dasd_ccw_req *cqr)
 {
+	struct dasd_block *block = cqr->block;
 	struct dasd_format_entry *format;
 	unsigned long flags;
 	bool rc = false;
 
 	spin_lock_irqsave(&block->format_lock, flags);
+	if (cqr->trkcount != atomic_read(&block->trkcount)) {
+		/*
+		 * The number of formatted tracks has changed after request
+		 * start and we can not tell if the current track was involved.
+		 * To avoid data corruption treat it as if the current track is
+		 * involved
+		 */
+		rc = true;
+		goto out;
+	}
 	list_for_each_entry(format, &block->format_list, list) {
 		if (format->track == to_format->track) {
 			rc = true;
@@ -3109,6 +3120,7 @@ static void clear_format_track(struct dasd_format_entry *format,
 	unsigned long flags;
 
 	spin_lock_irqsave(&block->format_lock, flags);
+	atomic_inc(&block->trkcount);
 	list_del_init(&format->list);
 	spin_unlock_irqrestore(&block->format_lock, flags);
 }
@@ -3170,8 +3182,11 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	}
 	format->track = curr_trk;
 	/* test if track is already in formatting by another thread */
-	if (test_and_set_format_track(format, block))
+	if (test_and_set_format_track(format, cqr)) {
+		/* this is no real error so do not count down retries */
+		cqr->retries++;
 		return ERR_PTR(-EEXIST);
+	}
 
 	fdata.start_unit = curr_trk;
 	fdata.stop_unit = curr_trk;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 07f9670ea61e..83b918b84b4a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -187,6 +187,7 @@ struct dasd_ccw_req {
 	void (*callback)(struct dasd_ccw_req *, void *data);
 	void *callback_data;
 	unsigned int proc_bytes;	/* bytes for partial completion */
+	unsigned int trkcount;		/* count formatted tracks */
 };
 
 /*
@@ -610,6 +611,7 @@ struct dasd_block {
 
 	struct list_head format_list;
 	spinlock_t format_lock;
+	atomic_t trkcount;
 };
 
 struct dasd_attention_data {
-- 
2.32.0

