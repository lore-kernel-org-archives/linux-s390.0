Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA55111B9;
	Fri,  4 Sep 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561349; cv=none; b=U7jq+Qgv0bkhtkOLhqjGwwRKRlJd/+Ov5K0ZWd3DxP/10cwOFbGcZ4oCr+b9n9Pn9sCtvD7tsLmvUxkfGj4hX9ule2U6ezptDemXfvc2ZRvElwjGPhtBCAnJ+dG0aK2MyKwUyKz6O6wHHq1ky1LHvBUQY4A6eAWY0v8d+XvIpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561349; c=relaxed/simple;
	bh=BF2Xx4GiACU0nziEVVnvj6aLlm7UtavSM+domIxHv7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1keYAbS8P/E+hdgp+W59fL+DXZ2Ys6A5pc8mguoI/iW+QKbxIoQK7fdyr2JX6rNr0EUSkPjKK0J/jHRtmMVDHR0RlN91qIbXnE/KeTxD5RvRqd7fdmmyFNcZyWR5R5pDObEkZBd7AIwEBBoX77f4d8X6mdFxCtCO29AkhJ8mUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZl8b6uW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZl8b6uW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L1aGQ2815577;
	Fri, 4 Sep 2026 22:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uDUF4yo28g5CCD87d
	3y3cHN5gViuqCxCGofwtTuqsJE=; b=NZl8b6uWK7u221dJU8nLxE+LgJ0AiDg9r
	8dUf1pyZ4bHrNluV8qkQjW/Oqjpl2vIt8j5IMW/wLF01HpVP85r2aqkyvzP0vEla
	diU+Fhkk9SuERHa4QjZuZUciCftU2FQQyiKrHjqixf6bmJPXs5YGRihqCaSHOYhD
	rkruzxmI1/9ZdboXF7KMnbyPxb+JLKIL7tHi1VjpzdaIICyIzhZ5iyycpoLks1HY
	b9LXbf2L0QlNv8h2oboB1VYeBXGahfB4nMmLbTcwZRmYG2u4p51CwXgazyjJBmDX
	P2ctLYenyXvrMcVGWh0yYB0ZyCqtcmEg418bR556XFBQ0sJJNCJpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx65m41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MBMZn010196;
	Fri, 4 Sep 2026 22:35:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hyj05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZdKm2556494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA30058056;
	Fri,  4 Sep 2026 22:35:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A8658065;
	Fri,  4 Sep 2026 22:35:37 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:37 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v7 5/6] s390/vfio-ap: fix queue state leakage to guest and host
Date: Fri,  4 Sep 2026 18:35:30 -0400
Message-ID: <20260904223531.1611088-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9b47bd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HKRPhIxKZPI_7FFxOiYA:9
X-Proofpoint-GUID: PIyzCMSHuj5aAtK6S_VZj2h1JObK7B8V
X-Proofpoint-ORIG-GUID: PIyzCMSHuj5aAtK6S_VZj2h1JObK7B8V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX6J0GpZ5X8J7D
 fX6PCIXkIblxSUONyPzBVSQtHenqHX7iwmVk0Bf/VX3MRTxYtMfsfwpU8mc6MG12P8V+qpghxMC
 QZxt+NE7vSB/0bFkQxiXM3mOcInyLj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX2RAL0TanlDDn
 yZ7aV27Qt4PfTROzvDUUstKmli8QxVf5AxW2uI88ok67cYSvpmlKhDUtfnWSGG+E71cKZ4BRutd
 20Z+sC2SPQxytHgjLuVwEWJrDacZlbNYaqJfavyKSSQk4Yf9Fyu/EZ8qNX5RqnSpL7CP3Em+/RK
 5/VmvMI3l7NQXwvFxQZKCNZ8K1fjs+RCMF06VAQkLApfDh40Vqt2bpV7KdbJb1P3OuMPqlPhDRP
 k2+CXBTpvZzfsyqAFZEOluXz+Jnq47AB7jHQXXCX94QchdU+8oqA1kUrihS/cNpSOyB/8nSPXkN
 I2twXdd6q04mflmd5vF2azIiggSwArw/PR9iBosjE0cOXM1vjWCb77j7yBWH5avBp696NpUbQSN
 AuFocIDcNVxcDDhzzsw7uGcC4lI9aQCkVL2lCazIkA529mwK6ZeF/KfEmfEbta8KKYxP8wRqyPk
 0FUYTmBG0nzqT9gJd/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

Commit dd174833e44e ("s390/vfio-ap: remove upper limit on wait
for queue reset to complete") removed the upper bound on the
wait for a queue reset to complete in apq_reset_check(), thus
allowing the function to loop indefinitely. The reason given
was to ensure both the security requirements and prevent
resource leakage and corruption in the hypervisor.

That is a legitimate concern; however, functions initiating the
reset all hold the matrix_dev->mdevs_lock which guards access
to all of the mdevs under the control of the vfio_ap device
driver. Blocking of access prevents a system administrator from
configuring the mdevs (i.e., assigning/unassigning adapters,
domains and control domains via the mdev's sysfs interfaces)
and may hang any guest that is started using one of the mdevs
to supply its AP configuration.

This patch limits the potential hang to the AP_RESET_MAX_WAIT
(2000ms) timeout introduced in the preceding commit, and
prevents leakage of queue state to a guest.

_queue_passable() accepted AP_RESPONSE_DECONFIGURED and
AP_RESPONSE_CHECKSTOPPED as passable states in addition to
AP_RESPONSE_NORMAL. Neither DECONFIGURED nor CHECKSTOPPED
confirms that the queue was zeroized; only AP_RESPONSE_NORMAL
(0) does. A queue that is not confirmed zeroized must not be
passed through to a guest, as it may contain key material from
a previous guest or host operation.

To fix this, _queue_passable() is limited to returning true
only when reset_status.response_code == AP_RESPONSE_NORMAL.
A new helper, apq_reset_finalize(), is introduced to ensure
q->reset_status correctly reflects the confirmed end state
of the queue. It copies the full TAPQ status word to
q->reset_status and sets q->reset_status.response_code to
AP_RESPONSE_NORMAL only when apq_status_check() returns 0,
confirming zeroization via TAPQ status bit verification.
For -ENODEV (DECONFIGURED or CHECKSTOPPED), the non-zero
response code is left intact, ensuring _queue_passable()
correctly returns false.

Additionally, vfio_ap_mdev_probe_queue() now calls
vfio_ap_mdev_reset_queue() and flush_work() at probe time
to guarantee a clean queue before it can be assigned to
a guest.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 63 +++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 672fae69739a..100ec011497f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -785,14 +785,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
 	if (!q)
 		return false;
 
-	switch (q->reset_status.response_code) {
-	case AP_RESPONSE_NORMAL:
-	case AP_RESPONSE_DECONFIGURED:
-	case AP_RESPONSE_CHECKSTOPPED:
-		return true;
-	default:
-		return false;
-	}
+	/*
+	 * A queue is only passable if zeroization was confirmed by
+	 * apq_reset_check() via TAPQ status bit verification. This is
+	 * indicated by reset_status.response_code == AP_RESPONSE_NORMAL (0).
+	 * This is to protect against leaking the internal state of the queue
+	 * to the guest.
+	 */
+	return q->reset_status.response_code == AP_RESPONSE_NORMAL;
 }
 
 /*
@@ -2107,6 +2107,30 @@ static void report_aqic_resource_leak(struct vfio_ap_queue *q)
 
 #define WAIT_MSG "Waited %dms for reset of queue %02x.%04x (%u, %u, %u)"
 
+/**
+ * apq_reset_finalize - store final TAPQ status and free AQIC resources.
+ * @q:      the vfio_ap_queue
+ * @status: the final AP queue status returned by PQAP(TAPQ)
+ * @ret:    the return value from apq_status_check()
+ *
+ * Copies the full TAPQ status word to q->reset_status so that all status
+ * bits reflect the confirmed end state of the queue. If ret == 0,
+ * zeroization was confirmed and the response code is overridden with
+ * AP_RESPONSE_NORMAL so that _queue_passable() returns true. For
+ * ret == -ENODEV (DECONFIGURED or CHECKSTOPPED), the non-zero response
+ * code is left intact so _queue_passable() correctly returns false.
+ * AQIC resources are then freed.
+ */
+static void apq_reset_finalize(struct vfio_ap_queue *q,
+			       struct ap_queue_status *status, int ret)
+{
+	memcpy(&q->reset_status, status, sizeof(*status));
+	if (!ret)
+		q->reset_status.response_code = AP_RESPONSE_NORMAL;
+	if (q->saved_isc != VFIO_AP_ISC_INVALID)
+		vfio_ap_free_aqic_resources(q);
+}
+
 static void apq_reset_check(struct work_struct *reset_work)
 {
 	int ret = -EBUSY, elapsed = 0;
@@ -2129,7 +2153,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 			 */
 			vfio_ap_free_aqic_resources(q);
 			return;
-
+		}
 		if (elapsed >= AP_RESET_MAX_WAIT) {
 			/*
 			 * Zeroization confirmed (ret == 0): the TAPQ status bits
@@ -2143,8 +2167,10 @@ static void apq_reset_check(struct work_struct *reset_work)
 			 * queue cannot generate interrupts, so the NIB page is
 			 * no longer a DMA target and it is safe to free it.
 			 */
-			if (!ret || ret == -ENODEV)
-				goto done;
+			if (!ret || ret == -ENODEV) {
+				apq_reset_finalize(q, &status, ret);
+				return;
+			}
 			/*
 			 * Timed out without being able to verify zapq completed.
 			 *
@@ -2174,7 +2200,10 @@ static void apq_reset_check(struct work_struct *reset_work)
 			 * apq_reset_check() will re-issue the ZAPQ.
 			 */
 			q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
-
+			return;
+		}
+		if (!ret || ret == -ENODEV) {
+			apq_reset_finalize(q, &status, ret);
 			return;
 		}
 		if (ret == -EBUSY) {
@@ -2191,14 +2220,9 @@ static void apq_reset_check(struct work_struct *reset_work)
 			    ret == -EAGAIN) {
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
-				continue;
 			}
 		}
 	}
-
-done:
-	if (q->saved_isc != VFIO_AP_ISC_INVALID)
-		vfio_ap_free_aqic_resources(q);
 }
 
 static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
@@ -2698,8 +2722,9 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
-	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
+	vfio_ap_mdev_reset_queue(q);
+	flush_work(&q->reset_work);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -2791,8 +2816,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_unlink_queue_fr_mdev(q);
 
 	dev_set_drvdata(&apdev->device, NULL);
-	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
+	kfree(q);
 }
 
 /**
-- 
2.53.0

