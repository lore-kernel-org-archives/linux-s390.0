Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA5384CC2;
	Mon, 24 Aug 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608581; cv=none; b=iGMtUvPpvgyFx4KHfvb2VLL2N3kP5YFAN2igLbcNlSMPZa2S5W9ffvwe2RNG4HoBCYBK7QNrfbCOk6pRTgVttrMOIidQVrUKCsPWJBExLh0gEyt9ukp+6oohblzAsjfpTdSIXO2BxV+VYcIbxP7MvO0zOTJv9ZUpPKbWhTmUm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608581; c=relaxed/simple;
	bh=/UlVtfTIQxqU57CW4NDAlN32GL20/n/BAIqXvgZOLfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzu3xXtsQ8KTNNeoYjSfloBilIX0yB7KSebzBCqiwZjMbLfgrVhlbTD5btD/JSZbwoRSumGPtr9Kw1Xw7TuGS7Cous7RInCJ5ycBZllilJgm+/lK2xQxllugpg8TZHG6e4PxO+WbGhbHFMUxYQ45pY36Xq1On7kqT2UR5E6SI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHO8ii0E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHO8ii0E"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVTCW2836508;
	Mon, 24 Aug 2026 21:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bgcSHbVr7rPYmHcI1
	KU+SingjOpIVb4nyHY1r9vXUpY=; b=qHO8ii0EIXUU6GiNG/snykPCt74D0lyOp
	kSbQAK1oHjnLDzQrqxRhb/CV65MjiSqoKDC0jCELJns0DU/xYJJN+mC9SqGvhsnB
	DKAUjMl9jfYso4Ng+JaEwKQGMb3SV/V/yBQQYochaSrOMl7t5vhGZnQySxkHSj9q
	Xp9/7iwPYMJAyRw/vBx89J+9OudYOm3mIVCuA7OSZite1npEywNsb9EYC8HO7YqU
	8mHnNV7n+lJjAAjLa9b+mzh91QtWx/g+OoJQ6rx6kpicQmdlCQHtiKYgLwR+ITOD
	RwshgcVjI40H6MEayvfgZga1Xn/q6oiqZB7E00t2iLab4DLRp4OmA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393vf4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLfJvB023999;
	Mon, 24 Aug 2026 21:56:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw0tu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OLu8gZ31785726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:56:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F8A58053;
	Mon, 24 Aug 2026 21:56:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30EC58043;
	Mon, 24 Aug 2026 21:56:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:56:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable()
Date: Mon, 24 Aug 2026 17:56:00 -0400
Message-ID: <20260824215603.819379-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824215603.819379-1-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vyou1FdRmdlTHh5S3QGHeljXi0Dnzae3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX+JtBa/HMPmLT
 zUzJ+ZylQIy5vVZHe/lj/qVGgyz/zjEWraFqXDwiUn0h3Xw9cTIPsdt+bptDvo+GAI02Srs6KfA
 NY3Yb4C9sazD1bbPBwgkLyZIHryOsF/Qt72r+JHCXLEMCvdBXmH+/9TCva9B4WdEDRZ3TC6iFrv
 jJEVD2fFuuDm8YW7eWWwhjdSurmbwMMyoJRViJ/DPuWLChWw2ZaNfGT3o15lZXGJEjBjWzILj+H
 TFROV4tkvSKCBwrV59823EZSq8rRL/GmgLlx/KpOK4TLsIwTtGPRsIS7BE5OwCPjhaKRLFJguor
 Q49MN5+dGZmwzmYH1h2IPTrsgbo+QsqHzRZ8wJE6ks3O0sqT8A6yxIO3zmxYrmBIQ/JMus8/Uuf
 fIAr+1I6CLZqBDgMqnF8sl0nA204rTNrW6VN8vcE2weAvEf/EVE7JEBalBnslPten1yiSobV3Kp
 coXwdhbUTubdppnRmag==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8cbdfa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hmEx05nRRPonxVd58HoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX1kzlzegLkAsH
 uO6mpuZ9fG5o0mbcOZkq5+hu6nfpBkenMtYyv3ULHXz+eYr91cbmk/5tE+KKg7uXo2VZf6P75Am
 yyA2Fif3lDqcVRSyoKZqLWg0ulmo0YM=
X-Proofpoint-ORIG-GUID: Vyou1FdRmdlTHh5S3QGHeljXi0Dnzae3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182

The vfio_ap_irq_enable() function executes the PQAP(AQIC) instruction to
enable interrupts for an AP queue. A switch statement is used to examine
the status response code returned from the instruction to determine
whether it succeeded or failed and react accordingly. For the default case,
the vfio_ap_irq_disable function is invoked to disable interrupts for the
queue and clean up the AQIC resources (i.e., unpin the NIB and unregister
the NISC). There are a number of problems with this:

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

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..22a6ceaa7b56 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -503,9 +503,12 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
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
 
-- 
2.53.0

