Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0B1DFDA1;
	Mon,  7 Sep 2026 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788757831; cv=none; b=laeXDVmjgwuQJx6qr+IKdBF25ZPFIh3kZK/tKXJqSL49meFvMMZxddE0Q/5UcIbNRe72bKgzaX+z6l62e/P/JO0eW4AaX24ZxNZBmLfiFahgojPpe4/BXKiOFrRSabBm3NroS6MO13g+gEiGxejJLLv8/M/mDKVNWLhafooSxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788757831; c=relaxed/simple;
	bh=bmnJDANLpUcNGGT2T46QLskg1ZZNL2odPUWOoZA8qD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IikV5hSur4yx0OvLQgkQU6dY3YvThgkPe6tgXOZi/8capn49tXQLriMr2Ecm+Sb10Lr5IpuXCdrQbql1N5/EwPW69i2llu+4d3e07PvvawgHLYrscC4yo/Ep8ofY7GHHvDti2cIc5gUU9vMl27D1+wzu8YzASgDbM9v1lRjWWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liw5J4F4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liw5J4F4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68741SYR3104530;
	Mon, 7 Sep 2026 05:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qqrHBPxjaQiR2TkKjCevkakTiutHE1U14JrUXFs3v
	xk=; b=liw5J4F4ojH4Fy4r2SapSHAMPPfDMj/3TzRHFfNWDWvhMw3jY6tbKSDif
	Fy+p8VQQShYM0LAuRyQU4VYUq2rfiSXcatRO9YuWcezsLSrjlW3Qw8+Juy2ykkX1
	tJF6Vl/U0qUIZfR3XXg8pxDRoQoLB1XsqKKO83wzuBVlqtdELVoOXCO2gnGotgt0
	pvKpqkQpKs4yzZ6A5t5hIx7s6KBWlu76zndJm6rihvE0HmR9yuaKtUymsM7P75ub
	0mHXzOcP3o2h9FmtULPEZ0mBmVvlv6k9jA6R326ySUkn/6ogJ6L6r680HZ8Dpu9k
	CwiqBurJB6n6Rm8q83q52Xo1yFh7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjpn4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:10:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6874fGsY002098;
	Mon, 7 Sep 2026 05:10:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq46qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:10:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6875AMLa35062060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 05:10:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E68E20040;
	Mon,  7 Sep 2026 05:10:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CD02004B;
	Mon,  7 Sep 2026 05:10:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 05:10:21 +0000 (GMT)
From: Nihar Panda <niharp@linux.ibm.com>
To: linux-s390@vger.kernel.org, vneethv@linux.ibm.com, oberpar@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: linux-kernel@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        hca@linux.ibm.com, wintera@linux.ibm.com, bblock@linux.ibm.com,
        nagamani@linux.ibm.com
Subject: [PATCH v4] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activates.
Date: Mon,  7 Sep 2026 07:10:16 +0200
Message-ID: <20260907051016.1296884-1-niharp@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -WZmrzjEYO_FcuG3PQcbXiOTffUR1KPk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX6JQt974ryIqy
 Tg9nTrm4k1BvLG5a6HwClLo1sXvNwCHtcFNW85VvlUk3wMAdrOeHYLKFnytxAfF/nXB5SlZxpSU
 aIQtQUCUEnmi3tQTT3pvQ/GTmKBzqeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfXysD/DInnPbOz
 34XEqb1Sp7mUYBGu50/ackfsQDbttdEBdAfHWJ8cCxsmjxSkMmjKR9yPaxfTEHNmXsREXVvYAqx
 0EzmeJxBWFNyjYYQLOipEQIMZ7Pbg6YpYd3AB8runbet1JavtVoDrSo17obLNsjQpU4aWSiBJHg
 3wPW+88uqJZQNe6YTAQNEqysmNJT+zIR/fCzXDROx7J3K0ZhjA5eMHAzrjCqZ6lbXAYvSbPScwA
 ChOdFroDltBZP4N4+FiQoPVhGpRBIGQro6ttGqH0rGOJbWYdXoDRfptvZiJ/7ztUhxihtaVCjhn
 5Cj6NbmYFI2HPXSRpFWept0K/pZYann8fzuAVeiCVYhTu8l8LmkRbg0rcN+IM948L63dwp8n2FM
 wum6bOujHVy/sRf5weBJSmclsM/Bt0tctWDszr3KBKyzqQnBTKfPbF5qFFP3SP7kDXhPIFbVN+3
 l1p6BdzWqFNSKWGnE5Q==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e4744 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ttpyxzfd-gbZmMW_b7AA:9
X-Proofpoint-GUID: -WZmrzjEYO_FcuG3PQcbXiOTffUR1KPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070051

Set QDIO_IRQ_STATE_ACTIVE only if both the subchannel-active bit and
the QDIO-active bit are set in the Subchannel Status Word (SCSW).

The channel subsystem sets the SCSW_ACTL_SCHACT bit in scsw.actl and
scsw.qact = 1 in the SCHIB to indicate that the activate-QDIO-queues
CCW program is running and the queues are ready.

An interrupt-driven approach is not applicable here.
Using CCW_FLAG_PCI on the activate CCW generates an intermediate interrupt
too early, before the firmware sets qact=1.
Therefore, polling the SCHIB via cio_update_schib() is the only way to
reliably detect when the queues are ready.

Signed-off-by: Nihar Panda <niharp@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Nagamani PV <nagamani@linux.ibm.com>
---
 arch/s390/include/asm/scsw.h |  4 +--
 drivers/s390/cio/qdio_main.c | 54 +++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index 56003e26cdbf..bf00d827d72b 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -28,7 +28,7 @@
  * @zcc: zero condition code
  * @ectl: extended control
  * @pno: path not operational
- * @res: reserved
+ * @qact: qdio active
  * @fctl: function control
  * @actl: activity control
  * @stctl: status control
@@ -50,7 +50,7 @@ struct cmd_scsw {
 	__u32 zcc  : 1;
 	__u32 ectl : 1;
 	__u32 pno  : 1;
-	__u32 res  : 1;
+	__u32 qact : 1;
 	__u32 fctl : 3;
 	__u32 actl : 7;
 	__u32 stctl : 5;
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index c1e09fa34e77..821d501efdcc 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -1140,11 +1140,29 @@ EXPORT_SYMBOL_GPL(qdio_establish);
 /**
  * qdio_activate - activate queues on a qdio subchannel
  * @cdev: associated cdev
+ *
+ * This function must only be called when the QDIO subchannel is in
+ * QDIO_IRQ_STATE_ESTABLISHED state (i.e., after successful qdio_establish()).
+ * Any other state indicates either the subchannel is not ready or an error
+ * condition that requires proper recovery through qdio_shutdown() and
+ * qdio_establish() before activation can be attempted.
+ *
+ * Return:
+ * * 0		- success
+ * * -ENODEV	- device is not initialized
+ * * -EIO	- adapter lacks QDIO activation support, or
+ *                the IRQ state changed unexpectedly during activation
+ * * -EBUSY	- subchannel state is not QDIO_IRQ_STATE_ESTABLISHED
+ *                at call time
+ * * -ETIMEDOUT - subchannel failed to become active within the timeout
+ * * other	- standard error code forwarded from ccw_device_start()
  */
 int qdio_activate(struct ccw_device *cdev)
 {
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 	struct subchannel_id schid;
+	unsigned long timeout;
 	struct ciw *ciw;
 	int rc;
 
@@ -1161,7 +1179,8 @@ int qdio_activate(struct ccw_device *cdev)
 	}
 
 	mutex_lock(&irq_ptr->setup_mutex);
-	if (irq_ptr->state == QDIO_IRQ_STATE_INACTIVE) {
+	if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
+		DBF_ERROR("%4x act WS:%d", schid.sch_no, irq_ptr->state);
 		rc = -EBUSY;
 		goto out;
 	}
@@ -1178,23 +1197,32 @@ int qdio_activate(struct ccw_device *cdev)
 			      0, DOIO_DENY_PREFETCH);
 	spin_unlock_irq(get_ccwdev_lock(cdev));
 	if (rc) {
-		DBF_ERROR("%4x act IO ERR", irq_ptr->schid.sch_no);
-		DBF_ERROR("rc:%4x", rc);
+		DBF_ERROR("%4x act IE:%d", irq_ptr->schid.sch_no, rc);
 		goto out;
 	}
 
-	/* wait for subchannel to become active */
-	msleep(5);
+	rc = -ETIMEDOUT;
+	timeout = jiffies + HZ;
 
-	switch (irq_ptr->state) {
-	case QDIO_IRQ_STATE_STOPPED:
-	case QDIO_IRQ_STATE_ERR:
-		rc = -EIO;
-		break;
-	default:
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
-		rc = 0;
+	while (time_before(jiffies, timeout)) {
+		msleep(1);
+		if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
+			rc = -EIO;
+			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
+			break;
+		}
+		/* Query hardware */
+		if (cio_update_schib(sch) == 0) {
+			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
+					&& sch->schib.scsw.cmd.qact) {
+				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
+				rc = 0;
+				break;
+			}
+		}
 	}
+	if (rc == -ETIMEDOUT)
+		DBF_ERROR("%4x act TIMEOUT", irq_ptr->schid.sch_no);
 out:
 	mutex_unlock(&irq_ptr->setup_mutex);
 	return rc;
-- 
2.53.0

