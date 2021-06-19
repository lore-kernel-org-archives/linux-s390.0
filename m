Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C224C2B9F4
	for <linux-s390@archiver.kernel.org>; Sat, 19 Jun 2021 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3685601FD
	for <linux-s390@archiver.kernel.org>; Sat, 19 Jun 2021 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFSKLf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 19 Jun 2021 06:11:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhFSKLf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Jun 2021 06:11:35 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15JA3u5k046752;
        Sat, 19 Jun 2021 06:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=N5uN7fL2W8wsD4fRWosX357FzY+k/1QQqQWJ9ns8alw=;
 b=R8crEZfwHzZaKFXP270kA4KnPdwovgHTE7NmdZt3LJtWZ26gt9ok5KMtzooKO4oSzNp0
 xN73EJUAKSqXhkxcbmIdmGDfUcqc2xlS2Owton4oVfxygINUKNlyiZ9nT1cNdIDuZmNp
 XwQGcr8nOginhXy8W0Dy4KLAeDkEeswcJSE1TgDPDxatp8We+LeX4369C08Co0xZXRKq
 Bun1zeGCnFTWCChoOh03GS1BnkmmcV2KQzGNbHuB/+G878xWUDg472k2PajMCCbRJPMg
 U9kLG9dm5v0x6WYEWsUUWj7GtARLD2HkY8dhtkYhGaVjfbfFhcuPVjXJOW3vqW/oHQeN 1w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 399ee186dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Jun 2021 06:09:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15JA2t5o006515;
        Sat, 19 Jun 2021 10:09:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 399878835j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Jun 2021 10:09:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15JA9H4S32375126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 10:09:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B540F5204E;
        Sat, 19 Jun 2021 10:09:17 +0000 (GMT)
Received: from localhost (unknown [9.171.5.120])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 67CC152051;
        Sat, 19 Jun 2021 10:09:17 +0000 (GMT)
Date:   Sat, 19 Jun 2021 12:09:16 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 5.13-rc7
Message-ID: <your-ad-here.call-01624097356-ext-0352@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nqoF9TORFSUi7k1HF-uNBDQlMxIi76r5
X-Proofpoint-ORIG-GUID: nqoF9TORFSUi7k1HF-uNBDQlMxIi76r5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-19_09:2021-06-18,2021-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106190066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes for 5.13-rc7.

Thank you,
Vasily

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-4

for you to fetch changes up to e73a99f3287a740a07d6618e9470f4d6cb217da8:

  s390/ap: Fix hanging ioctl caused by wrong msg counter (2021-06-16 23:32:02 +0200)

----------------------------------------------------------------
- Fix zcrypt ioctl hang due to AP queue msg counter dropping below 0 when
  pending requests are purged.

- Two fixes for the machine check handler in the entry code.

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/mcck: fix calculation of SIE critical section size
      s390/mcck: fix invalid KVM guest condition check

Harald Freudenberger (1):
      s390/ap: Fix hanging ioctl caused by wrong msg counter

 arch/s390/kernel/entry.S       |  4 ++--
 drivers/s390/crypto/ap_queue.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 12de7a9c85b3..9cc71ca9a88f 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -651,9 +651,9 @@ ENDPROC(stack_overflow)
 .Lcleanup_sie_mcck:
 	larl	%r13,.Lsie_entry
 	slgr	%r9,%r13
-	larl	%r13,.Lsie_skip
+	lghi	%r13,.Lsie_skip - .Lsie_entry
 	clgr	%r9,%r13
-	jh	.Lcleanup_sie_int
+	jhe	.Lcleanup_sie_int
 	oi	__LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
 .Lcleanup_sie_int:
 	BPENTER	__SF_SIE_FLAGS(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index ecefc25eff0c..337353c9655e 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -135,12 +135,13 @@ static struct ap_queue_status ap_sm_recv(struct ap_queue *aq)
 {
 	struct ap_queue_status status;
 	struct ap_message *ap_msg;
+	bool found = false;
 
 	status = ap_dqap(aq->qid, &aq->reply->psmid,
 			 aq->reply->msg, aq->reply->len);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		aq->queue_count--;
+		aq->queue_count = max_t(int, 0, aq->queue_count - 1);
 		if (aq->queue_count > 0)
 			mod_timer(&aq->timeout,
 				  jiffies + aq->request_timeout);
@@ -150,8 +151,14 @@ static struct ap_queue_status ap_sm_recv(struct ap_queue *aq)
 			list_del_init(&ap_msg->list);
 			aq->pendingq_count--;
 			ap_msg->receive(aq, ap_msg, aq->reply);
+			found = true;
 			break;
 		}
+		if (!found) {
+			AP_DBF_WARN("%s unassociated reply psmid=0x%016llx on 0x%02x.%04x\n",
+				    __func__, aq->reply->psmid,
+				    AP_QID_CARD(aq->qid), AP_QID_QUEUE(aq->qid));
+		}
 		fallthrough;
 	case AP_RESPONSE_NO_PENDING_REPLY:
 		if (!status.queue_empty || aq->queue_count <= 0)
@@ -232,7 +239,7 @@ static enum ap_sm_wait ap_sm_write(struct ap_queue *aq)
 			   ap_msg->flags & AP_MSG_FLAG_SPECIAL);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		aq->queue_count++;
+		aq->queue_count = max_t(int, 1, aq->queue_count + 1);
 		if (aq->queue_count == 1)
 			mod_timer(&aq->timeout, jiffies + aq->request_timeout);
 		list_move_tail(&ap_msg->list, &aq->pendingq);
