Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A549E141;
	Fri, 25 Sep 2026 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340385; cv=none; b=nReI5kvptUO+BIy1kklnDocVUZSlhukTU+qGrYDKga2g7v7MlCrp4BayNPvS8jGX6rocOwLxWIqbRi6dISjwzqaZ5dvdibLPTihcR8e9msM6vGnWQts5SF4wDtIBoPysic7KmRBI64RJCwT+i1+G8moXNc4atA4EZgXK6T+KOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340385; c=relaxed/simple;
	bh=XQsChNS2X/278RaM72O+Vww+5glPuUrq+JG+2Bfg2Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7JdFeALA1cy1t17n/lXI3bi2OWUZtaX/F/y0fW+XGL5glcKUoDPtKo35L703PJ8R2LnSPl9ZcjofgfivDy2xGMGCxLIAE3m3fntO3g23jHquMYUvRNc4t5TMvoevCxhaKOnwdCN8p3BmMe/7Ul/+tz9879eBXgSDasZDJH9r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbPFJUHC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbPFJUHC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aiZU103383;
	Fri, 25 Sep 2026 12:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=teAkEoOojljyG8oZ9
	JAqfRA4CmODV2YS2q0KV2Fkr7U=; b=pbPFJUHCirQJ79vmfc+Ht0Z+A9S+lKqhg
	/wrflnxu3m3RScDBn2qP72kSkan6XiQqzwbWVHXEkSdWvemWtR2ioRK5w7PC6HMf
	pqvome7F60OHZOGhhU00cetsz9P7xGt7XEUvHsfB1Q9WfqKY82XdXstPvOy3qbUE
	AewtwCRP6CGv6HCNKf7baLOmWEAzAkxhENa941P68xlgHNlwjMK4ngLRA225HaQN
	KjzsvfTOQj+0tR4dTEMR44eoIx5G4sJMkinnvC7+NT12J0FOFHNIOHDSvjKsFKQB
	PNFke4uNcnvX2ZufSojLAYocp2F5aBmJ7pxBjdEaYCvAOiAoz9JPA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvp2su-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA1cSu3298414;
	Fri, 25 Sep 2026 12:46:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2e8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCk2w41639260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:46:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2A4758063;
	Fri, 25 Sep 2026 12:46:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A816A5805A;
	Fri, 25 Sep 2026 12:46:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:46:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v8 6/6] s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings
Date: Fri, 25 Sep 2026 08:45:51 -0400
Message-ID: <20260925124551.665448-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925124551.665448-1-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 16IOTR6tJGWphnoqp6-kmJ_W6W4EaowY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXwXn+NaBK5Hnj
 yoUdussCobp/LV3f7oeP/wBDcVhFbtuNlD/f91GNFjeI4TGuleFd32A832GBWCNKvFzD02/Z8uC
 DAPGbMjhkFO2IOYmZi79ooKalvaZjUU=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab66d0c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SMWzy2rGiXtFoilLqd4A:9
X-Proofpoint-GUID: 16IOTR6tJGWphnoqp6-kmJ_W6W4EaowY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX9HgtoYLTUV0o
 pOrbV7Qyy+u0X5TogOYheB8okkBjMT+lk/4x1X1cmZAfcvytKLTkHYpTKsK2Hhu1GgP979FhIWa
 ypTg3jlD7gRcQ9WMIflQ/zyXBCZBEvWiBGSegLVgzXNZx7+bd+4PPbCqd1/jXC92b24f5sxgIrG
 M/UxEJXM0FELnA829GAH758xL4tBcuRhde1kTyp/7ptbC/kaMG+fRjUp2/InTsYVscpKCW9CzwO
 w9Ea21oTqb9wS85TtozTbpmi91wI/msf4+85+1RLcVdoj44QRxbsmEvbWREtVSoretWs3yyyZ1i
 qCwqNJfQixdCm2xnDeChqsPlYT72JyJ2UxZDfYil60N0+i/YD/hLlkdh6whYfRkxI1Vu/LbMgUz
 IXknOKkTncF7UxqI+g8uW1mLdmEd48v56ya/GZh8YdOivCCYqC5O82MYDbuRMGSRoiyki9/sU69
 BJa6urgHO0cJFy75Kmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250050

WARN and WARN_ONCE macros in code paths reachable by a guest
can be triggered repeatedly by a malicious or misbehaving guest,
flooding the kernel log and potentially impacting system
stability. Replace all WARN and WARN_ONCE calls reachable from
the guest AP interrupt enable/disable and queue reset paths with
ratelimited warning functions. When the queue is assigned to
an mdev, dev_warn_ratelimited() is used so the mdev device name
(which includes the UUID) appears in the message. Otherwise,
pr_warn_ratelimited() is used.

Five reporting functions are introduced:

report_tapq_rc() - reports an invalid or unexpected response
code from PQAP(TAPQ). Used in vfio_ap_wait_for_irqclear() and
apq_status_check(). The signatures of both functions are changed
to accept a struct vfio_ap_queue pointer instead of an apqn so
the queue's mdev context is available for reporting.

report_irqclear_timeout() - reports a timeout waiting for the
IR bit to clear after a PQAP(AQIC) disable in
vfio_ap_wait_for_irqclear().

report_aqic_disable_error() - reports a failed PQAP(AQIC)
disable operation in vfio_ap_irq_disable(). Replaces three
WARN_ONCE calls covering the non-operational queue, rejected
disable, and retry exhaustion cases.

report_zapq_rc() - reports an invalid response code from
PQAP(ZAPQ) in vfio_ap_mdev_reset_queue().

report_gisc_unregister_failure() - reports a failure to
unregister the guest ISC due to the fact that
q->matrix_mdev or q->matrix_mdev->kvm is NULL.

The VFIO_AP_DBF_WARN() calls in vfio_ap_irq_enable() and
handle_pqap() are retained but augmented with companion
dev_warn_ratelimited() or pr_warn_ratelimited() calls.
VFIO_AP_DBF_WARN() writes only to the s390 debug feature
ring buffer, which requires a sysadmin to know to look in
/sys/kernel/debug/s390dbf/ to find the messages. The companion
dmesg log entries ensure that warning conditions are immediately
visible in the kernel log without requiring familiarity with
the s390 debug feature infrastructure.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 186 +++++++++++++++++++++++-------
 1 file changed, 142 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cd4a436c4319..4b6e64daed25 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -226,6 +226,58 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 	return NULL;
 }
 
+static void report_tapq_rc(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(TAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(TAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_irqclear_timeout(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(TAPQ) timed out waiting for IRQ clear on %02x.%04x: rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(TAPQ) timed out waiting for IRQ clear on %02x.%04x: rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_aqic_disable_error(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) disable for %02x.%04x failed with rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(AQIC) disable for %02x.%04x failed with rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
+static void report_zapq_rc(struct vfio_ap_queue *q, u8 rc)
+{
+	if (q->matrix_mdev)
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(ZAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), rc);
+	else
+		pr_warn_ratelimited("PQAP(ZAPQ) for %02x.%04x failed with invalid rc=%#02x\n",
+				    AP_QID_CARD(q->apqn),
+				    AP_QID_QUEUE(q->apqn), rc);
+}
+
 /**
  * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
  *
@@ -256,14 +308,16 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
  *
  * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
+static int vfio_ap_wait_for_irqclear(struct vfio_ap_queue *q,
+				     struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
-		status = ap_tapq(apqn, NULL);
+		status = ap_tapq(q->apqn, NULL);
 		memcpy(tapq_status, &status, sizeof(status));
+
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
@@ -276,8 +330,6 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
 			return -ENODEV;
 		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 		case AP_RESPONSE_ASSOC_FAILED:
@@ -289,23 +341,53 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
 			 * since that would happen anyway if we continued to
 			 * execute the TAPQ.
 			 */
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
+			report_tapq_rc(q, status.response_code);
 			return -ETIMEDOUT;
 		default:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
+			report_tapq_rc(q, status.response_code);
 			return -EIO;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
-		  __func__, status.response_code,
-		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	report_irqclear_timeout(q, status.response_code);
 
 	return -ETIMEDOUT;
 }
 
+static void report_gisc_unregister_failure(struct vfio_ap_queue *q)
+{
+	if (q->matrix_mdev) {
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "APQN %02x.%04x: Failed to unregister guest ISC %c\n",
+				     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+				     q->saved_isc);
+	} else {
+		pr_warn_ratelimited("APQN %02x.%04x: Failed to unregister guest ISC %c\n",
+				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+				    q->saved_isc);
+	}
+}
+
+static bool verify_free_aqic_resourcers(struct vfio_ap_queue *q)
+{
+	bool verified = true;
+
+	if (q->saved_isc != VFIO_AP_ISC_INVALID &&
+	    !(q->matrix_mdev && q->matrix_mdev->kvm)) {
+		report_gisc_unregister_failure(q);
+		verified = false;
+	}
+
+	if (q->saved_iova && !q->matrix_mdev) {
+		pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page %08x\n",
+				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+				    q->saved_iova);
+		verified = false;
+	}
+
+	return verified;
+}
+
 /**
  * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
  * @q: The vfio_ap_queue
@@ -316,17 +398,13 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
  */
 static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
-	if (!q)
+	if (!q || !verify_free_aqic_resourcers(q))
 		return;
-	if (q->saved_isc != VFIO_AP_ISC_INVALID &&
-	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
-		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
-		q->saved_isc = VFIO_AP_ISC_INVALID;
-	}
-	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
-		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
-		q->saved_iova = 0;
-	}
+
+	kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
+	q->saved_isc = VFIO_AP_ISC_INVALID;
+	vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
+	q->saved_iova = 0;
 }
 
 /**
@@ -373,7 +451,8 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			 * wait until interrupt processing has been disabled
 			 * before proceeding.
 			 */
-			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			ret = vfio_ap_wait_for_irqclear(q, &tapq_status);
+
 			if (ret == 0 || ret == -ENODEV)
 				goto end_free;
 
@@ -420,8 +499,7 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
 			/* AP not operational; no further interrupts possible */
-			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-				  status.response_code);
+			report_aqic_disable_error(q, status.response_code);
 			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
 		case AP_RESPONSE_INVALID_GISA:
@@ -433,14 +511,12 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			 * and the hardware still holds the NIB address. Do not
 			 * free resources.
 			 */
-			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-				  status.response_code);
+			report_aqic_disable_error(q, status.response_code);
 			goto end_fail;
 		}
 	} while (retries--);
 
-	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
-		  status.response_code);
+	report_aqic_disable_error(q, status.response_code);
 
 end_fail:
 	/*
@@ -569,7 +645,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	if (vfio_ap_validate_nib(vcpu, &nib)) {
 		VFIO_AP_DBF_WARN("%s: invalid NIB address: nib=%pad, apqn=%#04x\n",
 				 __func__, &nib, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: invalid NIB address %pad\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), &nib);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
 	}
@@ -584,7 +663,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		VFIO_AP_DBF_WARN("%s: vfio_pin_pages failed: rc=%d,"
 				 "nib=%pad, apqn=%#04x\n",
 				 __func__, ret, &nib, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: vfio_pin_pages failed rc=%d\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), ret);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
 	}
@@ -607,7 +689,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	if (nisc < 0) {
 		VFIO_AP_DBF_WARN("%s: gisc registration failed: nisc=%d, isc=%d, apqn=%#04x\n",
 				 __func__, nisc, isc, q->apqn);
-
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x: GISC registration failed rc=%d isc=%d\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn), nisc, isc);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
 		return status;
@@ -651,9 +736,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		 * ISC that were prepared for this (rejected) request.
 		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
-		if (ret)
+		if (ret) {
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "PQAP(AQIC) enable for %02x.%04x: GISC unregister failed rc=%d isc=%d\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn), ret, isc);
+		}
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	}
@@ -667,6 +757,11 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 				 aqic_gisa.zone, aqic_gisa.ir, aqic_gisa.gisc,
 				 aqic_gisa.gf, aqic_gisa.gisa, aqic_gisa.isc,
 				 q->apqn);
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "PQAP(AQIC) enable for %02x.%04x failed with rc=%#02x\n",
+				     AP_QID_CARD(q->apqn),
+				     AP_QID_QUEUE(q->apqn),
+				     status.response_code);
 	}
 
 	return status;
@@ -751,7 +846,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
 		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=0x%04x, eca=0x%04x\n",
 				 __func__, apqn, vcpu->arch.sie_block->eca);
-
+		pr_warn_ratelimited("PQAP(AQIC) for %02x.%04x: AIV facility not installed\n",
+				    AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		return -EOPNOTSUPP;
 	}
 
@@ -760,7 +856,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!vcpu->kvm->arch.crypto.pqap_hook) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) hook not registered with the vfio_ap driver: apqn=0x%04x\n",
 				 __func__, apqn);
-
+		pr_warn_ratelimited("PQAP(AQIC) for %02x.%04x: hook not registered with the vfio_ap driver\n",
+				    AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -773,6 +870,9 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		VFIO_AP_DBF_WARN("%s: mdev %08lx-%04lx-%04lx-%04lx-%04lx%08lx not in use: apqn=0x%04x\n",
 				 __func__, uuid[0],  uuid[1], uuid[2],
 				 uuid[3], uuid[4], uuid[5], apqn);
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: mdev not in use\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -781,6 +881,9 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		VFIO_AP_DBF_WARN("%s: Queue %02x.%04x not bound to the vfio_ap driver\n",
 				 __func__, AP_QID_CARD(apqn),
 				 AP_QID_QUEUE(apqn));
+		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
+				     "PQAP(AQIC) for %02x.%04x: queue not bound to the vfio_ap driver\n",
+				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
 		goto out_unlock;
 	}
 
@@ -2084,7 +2187,8 @@ static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
 	return q;
 }
 
-static int apq_status_check(int apqn, struct ap_queue_status *status)
+static int apq_status_check(struct vfio_ap_queue *q,
+			    struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
@@ -2146,10 +2250,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		return -EAGAIN;
 
 	default:
-		WARN(true,
-		     "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
-		     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
-		     status->response_code);
+		report_tapq_rc(q, status->response_code);
 		return -EIO;
 	}
 }
@@ -2219,7 +2320,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 		msleep(AP_RESET_INTERVAL);
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
-		ret = apq_status_check(q->apqn, &status);
+		ret = apq_status_check(q, &status);
 		if (ret == -EIO) {
 			/*
 			 * TAPQ returned an invalid response code indicating a
@@ -2343,10 +2444,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		 * would corrupt the new owner's memory which could crash or
 		 * compromise the host kernel.
 		 */
-		WARN(true,
-		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
-		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
-		     status.response_code);
+		report_zapq_rc(q, status.response_code);
 	}
 }
 
-- 
2.53.0

