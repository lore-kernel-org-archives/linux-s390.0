Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129C386C08;
	Mon,  3 Aug 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751654; cv=none; b=ejX3oBHlE6nYxeS4TmGIhekrj1zN12g1v2XjtnO/0khUMuGo8upB+ul1jzaQ8kUF9T0abACDrJ34kKURjf6UQBu/IIjPX0HdgXC1de1JpNbqLwOHEOptAMKQ2CqMFf/qRmDlBUs17vQdmwA+a9U1HwDBYzGRR6UcWa+R5XvDgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751654; c=relaxed/simple;
	bh=WPpYU1JRSBfx+3nWUrNfOWryKLSsdwsCr/qQT8nKpNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SioRXludKSdU8iDhcum4YUS9mpO2/Nh4MhW7lzGlgPiJVezZEC27Zuc4F/XXx6ihD0RHBnut2HrBXpwz9rEddhsIIIIVBO588ENM2SGi7pOgZqfJpcyRYOqLtdhebJvCyZB3pcea6GgD49ucgwya55JD1ocSYQlWJ1Y9EDTEbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nz/H6C6U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nz/H6C6U"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmUAO161465;
	Mon, 3 Aug 2026 10:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZxULG+iMsllEfePWg
	xOi+3Fkqa7qVOEvHsN8hfJXOfU=; b=nz/H6C6UyYEgj5dy72zDiwuZTDVdLYsxE
	GezuMHLB3Pe3FtKo5TivfIU6IeRdJPaBd0KNKfBBTqx5IS00kvOdiRxMDi518xoB
	4TqbdsckwwxJoU6Q5Zf8ERDDLHjzuIRMQjD2n30PU5oRWt/yHLVo/3+eYfu2WYMF
	+IXSn9QFeCYiBUYVt98oXs1y2I0e3Rd2RBxkgRnDI1dGIkY+fBgaeozoutYSsUuf
	ll8m+hBJAmwP8h4HxPATT/YcAI4pdwZyIxdhN2TB8qfWL6sAuX9eqqY12YScsap/
	LLV3aVQEI8vU7RWVnwvCeUU/E9B7dpgfPpmaZUUkRSnO+a/0RJW3w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hg4fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6739uIui013927;
	Mon, 3 Aug 2026 10:07:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jvv2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673A7O3541681250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 10:07:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F39B2006C;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8CF20071;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390/pci: Rework__zpci_event_availability() to remove conditional locking
Date: Mon,  3 Aug 2026 12:07:22 +0200
Message-ID: <20260803100723.2343688-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803100723.2343688-1-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX8LdBP6zxOLsd
 RoKh/a8Xl0PGBmA4ba3eiyFEdyEZpri8Qf+CfX2FNUIGjpc/HILxeTwrK5EAWN7SxKbw+qvFaO7
 Fh14+irsbNh/kUMLdrKrG+/J74RB9lY=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a706861 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=BBtgEbCYtjC8VUYlbdgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX+lXuqSUAkoof
 V7hH8tBQ6AG3gfeKg53nNwSnckUM/q+hCCc/o2UIjAW7wo9dpemQILXpymXmN3HyrXI8CZw3Ux3
 v9+YpicpX41PwFMUCFn6xM5jB24ezdUf43tm9hsa5AEwJl4jvr4ZSWpsp6YhA2enh1KXAYyMoKC
 hbpUJVkb5ILRZwqn3Hwujk0VBhjAus0gGz8Y89jQpJTkJnGyWJHWugPWe1j1NdyFi8q3D0sV+Iu
 Tgs9t0ey27qIVqSkvpNzASLeqLkKL6ezKofMJtU5/jVs9h44CDNmWDmrpIjEZ5l3XacOJpoGpZd
 vEQv5ikZAE0E8R9QLqekQ9Z6vw99gpqUhCaKNmanKB3JQbNahaUWyl0jbC/QtjCAzCvW79HsOaT
 DxwpSYP/kh6EKakdIyPnJCaX8SZRq2W1/76N5cvjDv3DrU2pAVsj4bLT40z4KC65VB3J3aPcoX/
 FIzvkO+PvDtSdL05MKg==
X-Proofpoint-ORIG-GUID: ycbvApULNoc29MMyHrCIfZCLxfs6FhwL
X-Proofpoint-GUID: ycbvApULNoc29MMyHrCIfZCLxfs6FhwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030087

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in __zpci_event_availability():

arch/s390/pci/pci_event.c:402:10: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
  is not held on every path through here [-Wthread-safety-analysis]

Given that code which takes locks conditionally can be considered
suboptimal rework __zpci_event_availability() to get rid of this.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 103 ++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 48fa26dcbee1..37acee2c7d25 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -390,18 +390,21 @@ static void zpci_event_reappear(struct zpci_dev *zdev)
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
-	bool existing_zdev = !!zdev;
 	enum zpci_state state;
 
 	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
 
-	if (existing_zdev)
-		mutex_lock(&zdev->state_lock);
+	if (ccdf->pec == 0x0306) {
+		/* 0x308 or 0x302 for multiple devices */
+		zpci_remove_reserved_devices();
+		zpci_scan_devices();
+		return;
+	}
 
-	switch (ccdf->pec) {
-	case 0x0301: /* Reserved|Standby -> Configured */
-		if (!zdev) {
+	if (!zdev) {
+		switch (ccdf->pec) {
+		case 0x0301: /* Reserved|Standby -> Configured */
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
@@ -409,18 +412,9 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				kfree(zdev);
 				break;
 			}
-		} else {
-			if (zdev->state == ZPCI_FN_STATE_RESERVED)
-				zpci_event_reappear(zdev);
-			/* the configuration request may be stale */
-			else if (zdev->state != ZPCI_FN_STATE_STANDBY)
-				break;
-			zdev->state = ZPCI_FN_STATE_CONFIGURED;
-		}
-		zpci_scan_configured_device(zdev, ccdf->fh);
-		break;
-	case 0x0302: /* Reserved -> Standby */
-		if (!zdev) {
+			zpci_scan_configured_device(zdev, ccdf->fh);
+			break;
+		case 0x0302: /* Reserved -> Standby */
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 			if (IS_ERR(zdev))
 				break;
@@ -428,53 +422,54 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				kfree(zdev);
 				break;
 			}
-		} else {
-			if (zdev->state == ZPCI_FN_STATE_RESERVED)
-				zpci_event_reappear(zdev);
-			zpci_update_fh(zdev, ccdf->fh);
+			break;
 		}
+		return;
+	}
+
+	mutex_lock(&zdev->state_lock);
+	switch (ccdf->pec) {
+	case 0x0301: /* Reserved|Standby -> Configured */
+		if (zdev->state == ZPCI_FN_STATE_RESERVED)
+			zpci_event_reappear(zdev);
+		/* the configuration request may be stale */
+		else if (zdev->state != ZPCI_FN_STATE_STANDBY)
+			break;
+		zdev->state = ZPCI_FN_STATE_CONFIGURED;
+		zpci_scan_configured_device(zdev, ccdf->fh);
+		break;
+	case 0x0302: /* Reserved -> Standby */
+		if (zdev->state == ZPCI_FN_STATE_RESERVED)
+			zpci_event_reappear(zdev);
+		zpci_update_fh(zdev, ccdf->fh);
 		break;
 	case 0x0303: /* Deconfiguration requested */
-		if (zdev) {
-			/* The event may have been queued before we configured
-			 * the device.
-			 */
-			if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
-				break;
-			zpci_update_fh(zdev, ccdf->fh);
-			zpci_deconfigure_device(zdev);
-		}
+		/* The event may have been queued before we configured
+		 * the device.
+		 */
+		if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
+			break;
+		zpci_update_fh(zdev, ccdf->fh);
+		zpci_deconfigure_device(zdev);
 		break;
 	case 0x0304: /* Configured -> Standby|Reserved */
-		if (zdev) {
-			/* The event may have been queued before we configured
-			 * the device.:
-			 */
-			if (zdev->state == ZPCI_FN_STATE_CONFIGURED)
-				zpci_event_hard_deconfigured(zdev, ccdf->fh);
-			/* The 0x0304 event may immediately reserve the device */
-			if (!clp_get_state(zdev->fid, &state) &&
-			    state == ZPCI_FN_STATE_RESERVED) {
-				zpci_device_reserved(zdev);
-			}
+		/* The event may have been queued before we configured
+		 * the device.:
+		 */
+		if (zdev->state == ZPCI_FN_STATE_CONFIGURED)
+			zpci_event_hard_deconfigured(zdev, ccdf->fh);
+		/* The 0x0304 event may immediately reserve the device */
+		if (!clp_get_state(zdev->fid, &state) &&
+		    state == ZPCI_FN_STATE_RESERVED) {
+			zpci_device_reserved(zdev);
 		}
 		break;
-	case 0x0306: /* 0x308 or 0x302 for multiple devices */
-		zpci_remove_reserved_devices();
-		zpci_scan_devices();
-		break;
 	case 0x0308: /* Standby -> Reserved */
-		if (!zdev)
-			break;
 		zpci_device_reserved(zdev);
 		break;
-	default:
-		break;
-	}
-	if (existing_zdev) {
-		mutex_unlock(&zdev->state_lock);
-		zpci_zdev_put(zdev);
 	}
+	mutex_unlock(&zdev->state_lock);
+	zpci_zdev_put(zdev);
 }
 
 void zpci_event_availability(void *data)
-- 
2.53.0

