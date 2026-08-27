Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC334746B7;
	Thu, 27 Aug 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837103; cv=none; b=D5J8rN8T/wLYVgt+b7ZlySN3NBa9fBdp0FNR74a+4gtFbYIqXlkz9atl09nlu8P7f8v2OLl8FyRNeXxosyf5SGjyHNPRxA5llm/toANvIJk9A2VPQ+vBVnfubiQWvugaT/Oi0Hkx0rmYsDiQMDmxRCfUAX4viGHHUqhW9bhJJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837103; c=relaxed/simple;
	bh=4n+c3ea4Xo1jTF8SUOiroQOh0rJvWjGxWW5Oqm15EPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCLpsAp2U5giNFA9HboAsyoaHIQY/uvKcIrArDYEZnVyECvn3ZWjldjWGycChSb1rBCbX5SRH/3fOdLKllHID8wDeeH4k8JfRabOD9hZtrhoDqlE+aS/E5ib1XT3mEhiXineKoKZVc3WgC13BbopC5ZAnt7aHljmsvaxOmEb+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CdGe59cA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CdGe59cA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVmQD2892086;
	Thu, 27 Aug 2026 13:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gIqAPNMmMJOHw8XI4
	ucbyIGPlYtT2uZxL1KAuxc+bx0=; b=CdGe59cAODjKPqohWS0mPW/L4fL6oKB34
	DFofks/O1cCCtKjCrXyDfoohejik37IFcLLJOtLa9oxyD6E1kTnHnIsBdxjEWpm3
	+c2kVqmQ+bdx90ZVhIdEcl2NbljFwqOD5J0a+EGnNsgqowYiN6ZxSh3c7NoDnO6d
	252DhqigvJ7/ESFAH5JfZ+t4tJTwwrdDWFO6cNQ3AiCdHjBhQ11EIgiMyqY7f53V
	oaq5bU5f+0aSDZ3XkFS8um6E+8PeWQb6TZJLx9l1XfPO1Klz2hvTRHw6pHqCA45O
	CUhNquDU2I7Mq+hwJsc5bivQFqcS51ntuaAhnjmFMki+HYrBPIEgg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j5n5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDBKM3025548;
	Thu, 27 Aug 2026 13:24:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgg3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDOj7n23527980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:24:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0344758059;
	Thu, 27 Aug 2026 13:24:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47C158058;
	Thu, 27 Aug 2026 13:24:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.15.38])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:24:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable/disable()
Date: Thu, 27 Aug 2026 09:24:27 -0400
Message-ID: <20260827132441.555866-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827132441.555866-1-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX8OEJPMxPYWOI
 gWFbVZD+fpeIZ5iOzYCHcmm8bzY8me2Swan/Swhgwi+7u0Y3xkTJc4aiTy9Yhl3hL6D4//wFWyV
 B14/Sypa4I1jQc6QjJQ8YVguLYd0KTU=
X-Proofpoint-GUID: fPpZXE62gu-LVm433UvXSvvIIssa0c7y
X-Proofpoint-ORIG-GUID: fPpZXE62gu-LVm433UvXSvvIIssa0c7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXxpvuuKXywMKQ
 pmeAGBxPQc5X5nmzknsK2dVv9p9Ea50x3P4u0v553F0VXv+oKcc2HongbAhc67F9oeLgxnUs0Zd
 i7T5YiL5eQkbBZxlZfW/Vuy9wch7jCajJg7jiioX/UmRDnMqXlQZmh0Eev103hpreB7Wh2MpO+K
 Dn/DMhFjJjsM6a4m2yrkZD1hKMu/jp4Em37adk+CyhzUF8VnWTCdqGNfEWMnekvFAmrQB9LmmL8
 NJn5g/wpdCGJ9OskGFLkHbBRjLoDbbruMYerSQvMsVQb+YG0OqkLsxRFsI6TGzfNDoPH55Fcfda
 NUomY+q3S/1/qgPaz8/PtQKGIZTGxGb0R86zZ756ph4jVNJCakvDoTnhSCZqR0xH2cxfXXTjtM1
 Ut7ekEo8pTN1sPuqh8/gaGhadthpWO/kFM34IqlhnQP7d4dB17auDdbbAoqOQlJ5ELL3vvq2U9p
 3fb7D53pprI7ty3Fppw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a903a9f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pD7fxfrtpoTVUSxl-N4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109

The vfio_ap_irq_enable() and vfio_ap_disable() functions execute the
PQAP(AQIC) instructions to enable/disable interrupts for an AP queue.
A switch statement is used to examine the status response code returned
from the instruction to determine whether it succeeded or failed and react
accordingly.

vfio_ap_irq_enable()
~~~~~~~~~~~~~~~~~~~~
For the default case, the vfio_ap_irq_disable function is invoked to
disable interrupts for the queue and clean up the AQIC resources (i.e.,
unpin the NIB and unregister the NISC). There are a number of problems
with this:

1. Neither the q->saved_iova nor q->saved_isc has been set, so the
   AQIC resources - assuming those values have been previously set - will
   be the NIB and NISC resources from a prior call; the NIB and NISC from
   the current call are therefore leaked.

2. Interrupts may never have been enabled. Sending a disable instruction to
   a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
   DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
   a further WARN_ONCE from inside vfio_ap_irq_disable's own default.

3. The hardware just rejected the new ap_aqic() enable attempt with an
   unexpected status. Disabling a previously-working IRQ config - assuming
   that is even possible - as a reaction to a failed enable attempt does
   not make sense; it is actively destructive, tearing down something that
   was working for no valid reason.

The fix is to unregister the NISC and an unpin the NIB in the default case
of the switch statement.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
There are two problems with the way this function handles the response
code returned from the PQAP(AQIC) instruction:

1. For response codes AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED,
   a call is made to vfio_ap_wait_for_irqclear() which waits for the IR
   bit - indicates whether interrupts are enabled (1) or disabled (0) - to
   be cleared. That function does not return anything, so there is no way
   to determine whether it succeeded or not. The vfio_ap_irq_disable()
   function then frees the AQIC resources. This is a problem because the
   hardware may still write to the NIB resulting in a use-after-free kernel
   crash.

   The fix for this is to add a boolean return code from
   vfio_ap_wait_for_irqclear(). This will be checked in
   vfio_ap_irq_disable() and if clearing of the IR bit could not be
   verified, the AQIC resources will be allowed to leak. This is
   preferable to a kernel crash.

2. For response code AP_RESPONSE_INVALID_ADDRESS - indicates the NIB
   address passed to PQAP(AQIC) is not valid - as well as the default case,
   the vfio_ap_irq_disable() frees the AQIC resources. Since the AQIC
   disable was rejected, the IRQ is still enabled and the hardware still
   holds the NIB address, so freeing the NIB could result in a
   use-after-free kernel crash.

   The fix for this is to allow the AQIC resources to be leaked. This is
   preferable to a kernel crash.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 97 ++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..64d6a8f8fa96 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -226,16 +226,24 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
+ * vfio_ap_wait_for_irqclear:
+ * Waits for the IR bit to clear thus indicating IRQs are disabled for a queue
+ *
  * @apqn: The AP Queue number
  *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * Repeatedly checks the IR bit for the status of a queue device by calling the
+ * PQAP(TAPQ) instruction every 20ms until: the IR bit is cleared; the response
+ * code from the PQAP instruction indicates the queue is not available or
+ * not operational; or the loop has executed more than 5 times.
+ *
+ * Return:
+ * - true if the bit is observed clear or the AP is non-operational (in which
+ *   case no further interrupts can be generated)
+ *
+ * - false if the IR bit is still set after all retries are exhausted, meaning
+ *   the hardware may still write to the NIB.
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static bool vfio_ap_wait_for_irqclear(int apqn)
 {
 	struct ap_queue_status status;
 	int retry = 5;
@@ -246,7 +254,7 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return true;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -257,12 +265,13 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return true;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out verifying interrupts disabled for %02x.%04x\n",
+		  __func__, status.response_code, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	return false;
 }
 
 /**
@@ -317,8 +326,21 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
-			goto end_free;
+			/*
+			 * AQIC disable was accepted (NORMAL), or the queue was
+			 * already disabled or a prior async request is still
+			 * completing (OTHERWISE_CHANGED).  In both cases, we must
+			 * wait until interrupt processing has been disabled
+			 * before proceeding.
+			 *
+			 * If it could not be determined whether interrupts
+			 * have been disabled, do not free the AQIC resources: the
+			 * hardware may still write to the NIB, so leave it pinned
+			 * to avoid a use-after-free. The resources will be leaked.
+			 */
+			if (vfio_ap_wait_for_irqclear(q->apqn))
+				goto end_free;
+			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -326,18 +348,46 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
 		default:
-			/* All cases in default means AP not operational */
+			/*
+			 * The AQIC disable was rejected; IRQ is still enabled
+			 * and the hardware still holds the NIB address. Do not
+			 * free resources.
+			 */
 			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 				  status.response_code);
-			goto end_free;
+			goto end_fail;
 		}
 	} while (retries--);
 
 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 		  status.response_code);
+
+end_fail:
+	/*
+	 * We are here either because of a failure to verify that
+	 * interrupts have been disabled, or because the AQIC instruction
+	 * failed to disable them. The AQIC resources - the pinned NIB page
+	 * and the registered guest ISC - cannot be freed here. The hardware
+	 * may still write to the NIB; freeing the pinned page would result
+	 * in a use-after-free kernel crash. The resources will therefore be
+	 * leaked. This is preferable to a use-after-free.
+	 */
+	return status;
+
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational, in which case interrupts
+	 * can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts
+	 * so they will not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -495,7 +545,12 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		q->saved_isc = isc;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * IRQ control is already set as requested or a prior async
+		 * request has not yet completed; in either case, this response
+		 * comes with CC=3 indicating the new NIB and ISC were not accepted by
+		 * the hardware, so clean them up.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
@@ -503,9 +558,12 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
+		/* We could not modify IRQ settings: clear new configuration */
+		ret = kvm_s390_gisc_unregister(kvm, isc);
+		if (ret)
+			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
+					 __func__, ret, isc, q->apqn);
+		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	}
 
@@ -635,7 +693,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
-- 
2.53.0

