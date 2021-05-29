Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C46C47082
	for <linux-s390@archiver.kernel.org>; Sat, 29 May 2021 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50FF611AC
	for <linux-s390@archiver.kernel.org>; Sat, 29 May 2021 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE2JQa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 29 May 2021 05:16:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhE2JQa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 29 May 2021 05:16:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14T9Cn4L147985;
        Sat, 29 May 2021 05:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=BXl3gP/J6zeqy0oCp5OcjpMM7MF0KDhdFjodYFP7JHM=;
 b=pg7ucbqM9OQhN9832jq0FM+kiE0foIYgvTJPF8GRF2fMwkeSZLfFIgmMS7PG7ElvZrVj
 830it1+d7AOX/FfRrTGQap58nzwg26yEjY5tThokGEDX/dCsByLfvqvYLzoSVLsRRrwT
 CTRL7osR4Qt/eo17Fx7vSpyXtONKJRZMfi7rakyPaOv/VZBRW9nyJqAZ2w7SDBuF0gao
 HmUPmGGY76R2FXAeRINTlpRs+vjw1t3U+k4UF6cc5t/+CGpEFP0rkQ0SsKMQHkXSmr+F
 5/Ym8Lhx7N4XZn+Mm2L7vpS4wcyqdifQEqXIhNbesUT5/Ov0CWTec1/rBBImVhg3ypCO 9g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38uhxf0phq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 May 2021 05:14:53 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14T9CVrP030123;
        Sat, 29 May 2021 09:14:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh8353-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 May 2021 09:14:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14T9Eg5o24248756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:14:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8120411C04C;
        Sat, 29 May 2021 09:14:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35F3F11C04A;
        Sat, 29 May 2021 09:14:42 +0000 (GMT)
Received: from localhost (unknown [9.171.82.234])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 May 2021 09:14:42 +0000 (GMT)
Date:   Sat, 29 May 2021 11:14:40 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.13-rc4
Message-ID: <your-ad-here.call-01622279680-ext-7982@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nqGmWQLNA4rVn72UBBQvUu62KOb3-13I
X-Proofpoint-GUID: nqGmWQLNA4rVn72UBBQvUu62KOb3-13I
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-29_05:2021-05-27,2021-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105290070
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.13-rc4.

Thank you,
Vasily

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-3

for you to fetch changes up to ffa99c436aa70c0c0980866523a6ae1023c96768:

  Merge tag 'vfio-ccw-20210520' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes (2021-05-26 23:46:34 +0200)

----------------------------------------------------------------
- Fix races in vfio-ccw request handling.

----------------------------------------------------------------
Eric Farman (3):
      vfio-ccw: Check initialized flag in cp_init()
      vfio-ccw: Reset FSM state to IDLE inside FSM
      vfio-ccw: Serialize FSM IDLE state with I/O completion

Vasily Gorbik (1):
      Merge tag 'vfio-ccw-20210520' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes

 drivers/s390/cio/vfio_ccw_cp.c  |  4 ++++
 drivers/s390/cio/vfio_ccw_drv.c | 12 ++++++++++--
 drivers/s390/cio/vfio_ccw_fsm.c |  1 +
 drivers/s390/cio/vfio_ccw_ops.c |  2 --
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index b9febc581b1f..8d1b2771c1aa 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -638,6 +638,10 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
 	int ret;
 
+	/* this is an error in the caller */
+	if (cp->initialized)
+		return -EBUSY;
+
 	/*
 	 * We only support prefetching the channel program. We assume all channel
 	 * programs executed by supported guests likewise support prefetching.
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 8c625b530035..9b61e9b131ad 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -86,6 +86,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	struct vfio_ccw_private *private;
 	struct irb *irb;
 	bool is_final;
+	bool cp_is_finished = false;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	irb = &private->irb;
@@ -94,14 +95,21 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
+		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
 			cp_free(&private->cp);
+			cp_is_finished = true;
+		}
 	}
 	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
 
-	if (private->mdev && is_final)
+	/*
+	 * Reset to IDLE only if processing of a channel program
+	 * has finished. Do not overwrite a possible processing
+	 * state if the final interrupt was for HSCH or CSCH.
+	 */
+	if (private->mdev && cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
 
 	if (private->io_trigger)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23e61aa638e4..e435a9cd92da 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -318,6 +318,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
+	private->state = VFIO_CCW_STATE_IDLE;
 	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
 				      io_region->ret_code, errstr);
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 491a64c61fff..c57d2a7f0919 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -279,8 +279,6 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 	}
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0)
-		private->state = VFIO_CCW_STATE_IDLE;
 	ret = (region->ret_code != 0) ? region->ret_code : count;
 
 out_unlock:
