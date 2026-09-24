Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB4388E55;
	Thu, 24 Sep 2026 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226195; cv=none; b=dAcoljYtyZxtwE5VoQuHyjnwBqVcbkpVmwppiwYjw4Hw/+Y+lKcRMXTaeu7Tnt23slpLmup3YG4vitUm2LLo/MgrTA9iPH+3dLKAG3uIzQUK3LIxVQH+qWQXuuqbJYk01UnXXC0R7NWC5cRlg1aj4e0GBoo8Q3ghimY3ibRtTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226195; c=relaxed/simple;
	bh=O+rArNluDXcd40QGkOAfZYwx2V4j9z/6s3Tyw9U/1bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SASKqXr/plW0C5GfIW7SXw5vnfVJdYLoXrN5kJi6xXyo7h+SLArm2DUATfPbdwoyv/zAUiOHSjd6BnKqdrJDXo897tULVs/CiIvFcPiLzfjZBqOR7musVvCzhMMhqvv2WSlvQ80km8Vqm/Bj/yTl+lLsAPLKM0hXJ+HuX3b9VW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NiQfDITQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NiQfDITQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2a3SR939420;
	Thu, 24 Sep 2026 05:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M6pdNpPdF23qdJ9Uo
	U6DdT51J/jARvov6El8/cZ7DOs=; b=NiQfDITQrZBmtUkHMHbPsIZW/nYdNWu37
	6IFVou3nrFdCMaW7gX2KZq0jJ+ayMaFcawkQWGNptszd72v4QYuZgb/6avWmtDPn
	4dEWORY2awodZcFD8uxTxIwcMDA+9710GGlO4dud7/Vhp7D1EtasNhFtRp0bHmKJ
	x55eXaybsvHSDLn1GzAXscHpJzMlDtiDGCfd1TT02VrIDHpWd0NDekPqX5HUhmVo
	v+SsvKaRknK1rZ6KrdCyUiw+n7CBOGRz42A4XLib3rxVxQ+Y+X8Hq96+Yeg5TWNG
	JJ3gkcBdyIPMOInWxGUR2NOUlgvQPsRhfGOEiE6AS6SSfpXYC+9lA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsf2bk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:03:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2Ikth1332834;
	Thu, 24 Sep 2026 05:03:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qm6ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:03:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O537Xs24052442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 05:03:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2074F20043;
	Thu, 24 Sep 2026 05:03:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16AB2004D;
	Thu, 24 Sep 2026 05:03:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 05:03:06 +0000 (GMT)
From: Nihar Panda <niharp@linux.ibm.com>
To: linux-s390@vger.kernel.org, vneethv@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        hca@linux.ibm.com, wintera@linux.ibm.com, bblock@linux.ibm.com,
        nagamani@linux.ibm.com
Subject: [PATCH v5 1/1] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activates.
Date: Thu, 24 Sep 2026 07:01:36 +0200
Message-ID: <20260924050217.2583852-2-niharp@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924050217.2583852-1-niharp@linux.ibm.com>
References: <20260924050217.2583852-1-niharp@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4af10 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ttpyxzfd-gbZmMW_b7AA:9
X-Proofpoint-ORIG-GUID: hX0guK2CiNEXAEQxFnOHFV6zIGidtWXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfXxaLzzrmPtZfE
 73Myeu84cVm3Ug3WRvYmKkVNbWxYeG7BBUXLu/ydXOBhaoxzrT3dCzTZxWOwscAPJrN2jhzVIsO
 YCIZLh9E/kdNulw5zHsqKOLSb1wRQ2Pm3/nA6q8ZgVABLq3OEwX/4NSb7yCZw+7KKZ1tXMq5GkV
 vHSukDdF8zKwF7BGCgCxBHUVEJCcv3uOeSWt64foDOdaha+e8AHyTufwn9ha6Xl2zn2b1zgfMO3
 FRR9553j1ChdxrefbNWUT/HetCbA2LysxfJE4fzC+/9UuYjQRBwQtXI7vhWKKH2W5rWYk6KhwsI
 //BcuNgqPCeMFsCJthzHQlrkYVXx8+cYg8WamOKg+v4PvcDrlclkUkEAihxchDC5AwVCgqET+la
 F/9Z1WVurYi5dETzmqw9rAf1R3tSEKFuqIchD16SWhli/fePw9d2L0PKBtlu1AS+95aXGR8pQwQ
 2dcnWfNIzk9E2udfLUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX70GFwwGr6EyN
 tB7IOlwon1RyYVifrl84RS10MJorwTnxzCp1KJDCJqqSw5QT2JqvVUkfl7tR5Z/P1SNqAtECuoy
 euLYU15B3GBgfphJcolL6JMPD8MXvm0=
X-Proofpoint-GUID: hX0guK2CiNEXAEQxFnOHFV6zIGidtWXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240020

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
 drivers/s390/cio/qdio_main.c | 59 +++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 16 deletions(-)

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
index c1e09fa34e77..0f58ae1175ee 100644
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
@@ -1178,23 +1197,35 @@ int qdio_activate(struct ccw_device *cdev)
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
-	}
+	do {
+		msleep(1);
+		if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
+			rc = -EIO;
+			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
+			break;
+		}
+		/* Query hardware */
+		spin_lock_irq(get_ccwdev_lock(cdev));
+		if (cio_update_schib(sch) == 0) {
+			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
+					&& sch->schib.scsw.cmd.qact) {
+				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
+				rc = 0;
+			}
+		}
+		spin_unlock_irq(get_ccwdev_lock(cdev));
+		if (!rc)
+			break;
+	} while (time_before(jiffies, timeout));
+	if (rc == -ETIMEDOUT)
+		DBF_ERROR("%4x act TMOUT", irq_ptr->schid.sch_no);
 out:
 	mutex_unlock(&irq_ptr->setup_mutex);
 	return rc;
-- 
2.53.0

