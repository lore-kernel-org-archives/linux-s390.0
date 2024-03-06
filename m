Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F951C02;
	Wed,  6 Mar 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742881; cv=none; b=FGWtQyVNgtaEqvi5ZyDPDt+xmSkaS5nAmPzg6Kv7L2EgeRt3bbb4XsTowImfbkWfMeVGmPzqpuZ5rhwHZ+dIqRnqkdWM7G7z3LK2wr2XcCqVRXewYr/AAAoEvkMb/QRFZ0DZelA1fNbAQKzqGz4jbK2MJIV1Wm+uTLYaQM0bWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742881; c=relaxed/simple;
	bh=YDFtQvnykWjzr/BqqVsI0xzBK5lPiJ3GeO8VXjKdgYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ajm7XlyJphlKFuNY6HYD7B48V24J01NF2gxWMotEMN/d6u97lrgS7ZqYprGCVsQvop/zVlkpP1tTBLaKs41fyevYcasRNWcY7RFt0DAqgOQygV/n80rC/Oph6/MgPtiMrC1AWwM5KS28IQdJS7L5ZSQ3SmcZ9O2RzmA8eRNyWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FN+RrrRw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FN+RrrRw"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426GXhxM001994;
	Wed, 6 Mar 2024 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pY0/RsbWR67QamwUCWgoKM4qBxZZb6lRqPVAzs+azIc=;
 b=FN+RrrRwWD1aYLstnNxa1Ne50PGHiEuVQMnltW9zDZ9giHjFtViBR2aqvRtQdhH7uAE3
 IItdqEp+8n9IzCHr6OpzdRk2Tuka91ZgokE8Ys9IOFGzgCqKTfAYQBsfKPosFfT5GNj/
 LY9WtFJxRa4HQo2qGRyesd31qB+msi3QTttwsA3E8a9zQusrYPoCY/0n1l8debL2q83V
 mCGmxFYmIy2zSs6DLIMpITM+HwDBIiPqzVWKBWctp3L4zhaBRH025kGAlUXi3tQjfeY2
 QVGvMLRrnrqcN3vfm/Q0kELYcwupvaTKQyEfhmOmmHJx+UBdiepB76oU8RA29SJB023Q 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpv3qg17b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:34:27 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426GXjW2002239;
	Wed, 6 Mar 2024 16:34:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpv3qg16w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:34:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426FGMDe025381;
	Wed, 6 Mar 2024 16:34:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyr0aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:34:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426GYLxj34865458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 16:34:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD72D2004E;
	Wed,  6 Mar 2024 16:34:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6D020040;
	Wed,  6 Mar 2024 16:34:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Mar 2024 16:34:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A532CE0332; Wed,  6 Mar 2024 17:34:20 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Subject: [PATCH net] s390/qeth: handle deferred cc1
Date: Wed,  6 Mar 2024 17:34:20 +0100
Message-Id: <20240306163420.1005843-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QsnK8x_X23vOWN_Sre6Z-CERJMYaXulO
X-Proofpoint-GUID: 9XlzyxeUhQ9CVxSV3j1DlfXj95kq9IJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060133

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
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 37 +++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf8506d0f185..66d1683c76e5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1179,6 +1179,20 @@ static int qeth_check_irb_error(struct qeth_card *card, struct ccw_device *cdev,
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
@@ -1220,11 +1234,10 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
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
@@ -1276,6 +1289,26 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
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

