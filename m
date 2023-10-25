Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B0AC25B47
	for <linux-s390@archiver.kernel.org>; Wed, 25 Oct 2023 13:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjJYNdb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Oct 2023 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJYNdS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Oct 2023 09:33:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE0199D;
        Wed, 25 Oct 2023 06:32:44 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDSqtm009664;
        Wed, 25 Oct 2023 13:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=F2aN9wBBi6Q/sQIdXOXRkiu2NmNaxRh+DjjbnGQLVLs=;
 b=Eg11o90AudjhBbQyin+paJUOSmqLqFUE7Djq2ZSg8O4vVrBWMft5FnXsHfclyrxgM5Id
 DWL15MO9OtJfWBods/z9iDnomoMJMjCkMnvjK5RJez+DIxqJs9jWzwOah/LW9C2xueab
 m2SuR7BI8+ExAb0PHETpPgFflF61sXfzG5Wl1AkByxVvdv046tzW/IoNgz6a5KsYCjSE
 RzFtUXAsPIxSTICQtpL0vtUt+o4yvSxN1mkRFkVpUWh4jIVoVHQa0nGW0KrF0rjendDT
 p6EWtGOsvwIM50QMAbXY5Nw8xsNks+zfrBHvhkqTqf2DgrSMPY6QEzhIK1Oemgz1cqDe eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3tm0beb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:32:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PDTUC9013747;
        Wed, 25 Oct 2023 13:32:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3tm0bdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:32:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PB0R2d026878;
        Wed, 25 Oct 2023 13:24:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsynxs5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:24:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PDOc1x9372302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 13:24:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0736620040;
        Wed, 25 Oct 2023 13:24:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA3CE20043;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 13:24:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A135DE03CF; Wed, 25 Oct 2023 15:24:37 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH 2/2] s390/dasd: protect device queue against concurrent access
Date:   Wed, 25 Oct 2023 15:24:37 +0200
Message-Id: <20231025132437.1223363-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025132437.1223363-1-sth@linux.ibm.com>
References: <20231025132437.1223363-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RN_EeiTbJu2irplFj9RtUcX4bcdSk66y
X-Proofpoint-ORIG-GUID: mmY6sWcVE1kffTED7a5PMNf-USpgGcLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250116
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

In dasd_profile_start() the amount of requests on the device queue are
counted. The access to the device queue is unprotected against
concurrent access. With a lot of parallel I/O, especially with alias
devices enabled, the device queue can change while dasd_profile_start()
is accessing the queue. In the worst case this leads to a kernel panic
due to incorrect pointer accesses.

Fix this by taking the device lock before accessing the queue and
counting the requests. Additionally the check for a valid profile data
pointer can be done earlier to avoid unnecessary locking in a hot path.

Cc: stable@vger.kernel.org
Fixes: 4fa52aa7a82f ("[S390] dasd: add enhanced DASD statistics interface")
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 215597f73be4..5b11ee923457 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -674,18 +674,20 @@ static void dasd_profile_start(struct dasd_block *block,
 	 * we count each request only once.
 	 */
 	device = cqr->startdev;
-	if (device->profile.data) {
-		counter = 1; /* request is not yet queued on the start device */
-		list_for_each(l, &device->ccw_queue)
-			if (++counter >= 31)
-				break;
-	}
+	if (!device->profile.data)
+		return;
+
+	spin_lock(get_ccwdev_lock(device->cdev));
+	counter = 1; /* request is not yet queued on the start device */
+	list_for_each(l, &device->ccw_queue)
+		if (++counter >= 31)
+			break;
+	spin_unlock(get_ccwdev_lock(device->cdev));
+
 	spin_lock(&device->profile.lock);
-	if (device->profile.data) {
-		device->profile.data->dasd_io_nr_req[counter]++;
-		if (rq_data_dir(req) == READ)
-			device->profile.data->dasd_read_nr_req[counter]++;
-	}
+	device->profile.data->dasd_io_nr_req[counter]++;
+	if (rq_data_dir(req) == READ)
+		device->profile.data->dasd_read_nr_req[counter]++;
 	spin_unlock(&device->profile.lock);
 }
 
-- 
2.39.2

