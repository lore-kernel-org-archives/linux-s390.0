Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFB63131;
	Thu,  7 Mar 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804321; cv=none; b=rdaMhHU+WqiFN6sluWW1Xe1OBpdL2UuAb/1Y1Jlz6yaqqCypmk/1CqIo7wuZNfZtiKmLaw0lXIli7l5NxaJ8syEz12hZEniiFC8d/5bNCg7o7ilqjtfoim8sYZgoxdaOrpkaMHTD1ImBXhGMrTm2lBcDi/c1VKO2qv1QqmipOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804321; c=relaxed/simple;
	bh=xTNG64NUeu3Pi0ukeRGdAHjZW+GOBxINbviyFE3CpJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGV7MAsDRuyx2VEw6nQIDtxObZIqgRfhPXfAz8XipwIWrp9pb7C7qFzn8SirZjviEnyC+gtHHB8t0EO4gKM3YSwZ0sCdvmAM6cLgtse3LwABMqVp4ZYj4rlqjS1gVhwhEW3190oHu0UoTQN494NJykvNkYg8oUCFdvMf0NjNM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SeBuudHd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SeBuudHd"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279Zods024906;
	Thu, 7 Mar 2024 09:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yIF8fgJn/2EXgV/JqKdS0P4gJ8Q++q59OerkCFc6Jlo=;
 b=SeBuudHdRJr9qI5X4aR9dxuzzuipIQp8GQ3FyB+3ObPhgUsp9Cd0ANHOJJiP+NFow2RI
 EVYdi6mjNlGwvscm5WVOpBYOa1/4GlUaw+FmfjSYGZymsMbtKDee8tFe7djMAT3L0fnC
 MPnzJoKDAdQPa6Pr5V7Am8BtfQXwFAE+s599mshGIGAGv+mtHLT04oksi0EVa35tFDPE
 M3rpCRe5nu4E6iVGsYCA2ekUZLnRVntUh7XYgBQCcJmQMB7M499tr2teqD0S7KDzBH76
 7dNHcyRk1BEKB8u6ul+4gsQafSMDdiiJdPgMfxoG0SgLLLTomwXRwgXhe68fvIn+vSv9 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqakhrm3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:36 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4279aNRE027801;
	Thu, 7 Mar 2024 09:38:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqakhrm31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4279FcNq010898;
	Thu, 7 Mar 2024 09:38:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52m7vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4279cTVJ28246574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 09:38:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B7772004D;
	Thu,  7 Mar 2024 09:38:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A7D720043;
	Thu,  7 Mar 2024 09:38:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 09:38:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id E5082E01AE; Thu,  7 Mar 2024 10:38:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Subject: [PATCH net v2] s390/qeth: handle deferred cc1
Date: Thu,  7 Mar 2024 10:38:27 +0100
Message-Id: <20240307093827.2307279-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: livEwX96MRIYDaRIWbvP0jfokhyybLPV
X-Proofpoint-ORIG-GUID: 54_21jW5VardP6FxG9k0yZQ8q2RD-l7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070069

The IO subsystem expects a driver to retry a ccw_device_start, when the
subsequent interrupt response block (irb) contains a deferred
condition code 1.

Symptoms before this commit:
On the read channel we always trigger the next read anyhow, so no
different behaviour here.
On the write channel we may experience timeout errors, because the
expected reply will never be received without the retry.
Other callers of qeth_send_control_data() may wrongly assume that the ccw
was successful, which may cause problems later.

Note that since
commit 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
and
commit 5ef1dc40ffa6 ("s390/cio: fix invalid -EBUSY on ccw_device_start")
deferred CC1s are more likely to occur. See the commit message of the
latter for more background information.

Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
Reference-ID: LTC205042
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
v1->v2: correct patch format

 drivers/s390/net/qeth_core_main.c | 36 +++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf8506d0f185..bc6f3f1f25ba 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1179,6 +1179,19 @@ static int qeth_check_irb_error(struct qeth_card *card, struct ccw_device *cdev,
 	}
 }
 
+/**
+ *	qeth_irq() - qeth interrupt handler
+ *	@cdev: ccw device
+ *	@intparm: expect pointer to iob
+ *	@irb: Interruption Response Block
+ *
+ *	In the good path:
+ *	corresponding qeth channel is locked with last used iob as active_cmd.
+ *	But this function is also called for error interrupts.
+ *
+ *	Caller ensures that:
+ *	Interrupts are disabled; ccw device lock is held;
+ */
 static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		struct irb *irb)
 {
@@ -1220,11 +1233,10 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		iob = (struct qeth_cmd_buffer *) (addr_t)intparm;
 	}
 
-	qeth_unlock_channel(card, channel);
-
 	rc = qeth_check_irb_error(card, cdev, irb);
 	if (rc) {
 		/* IO was terminated, free its resources. */
+		qeth_unlock_channel(card, channel);
 		if (iob)
 			qeth_cancel_cmd(iob, rc);
 		return;
@@ -1276,6 +1288,26 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		}
 	}
 
+	if (scsw_cmd_is_valid_cc(&irb->scsw) && irb->scsw.cmd.cc == 1 && iob) {
+		/* channel command hasn't started: retry.
+		 * active_cmd is still set to last iob
+		 */
+		QETH_CARD_TEXT(card, 2, "irqcc1");
+		rc = ccw_device_start_timeout(cdev, __ccw_from_cmd(iob),
+					      (addr_t)iob, 0, 0, iob->timeout);
+		if (rc) {
+			QETH_DBF_MESSAGE(2,
+					 "ccw retry on %x failed, rc = %i\n",
+					 CARD_DEVID(card), rc);
+			QETH_CARD_TEXT_(card, 2, " err%d", rc);
+			qeth_unlock_channel(card, channel);
+			qeth_cancel_cmd(iob, rc);
+		}
+		return;
+	}
+
+	qeth_unlock_channel(card, channel);
+
 	if (iob) {
 		/* sanity check: */
 		if (irb->scsw.cmd.count > iob->length) {
-- 
2.40.1

