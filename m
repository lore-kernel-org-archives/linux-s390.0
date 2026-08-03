Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62071F1537;
	Mon,  3 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767357; cv=none; b=gtkg+ZnnjXRN3Og0q/7H88QKmvnIBZ4GqsRfnMVzgE+pytI2rEsy+ddrkTRFsaW7sRdCm+eOQw3GXmwYeZGS+LDSq27senWNVQlDRsdQeDJaKFK75aq+akaSZ6BXVGOg+sbE7Qoza3XajmR3Px/fxvysNwyIL+3+cV7nvw4XWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767357; c=relaxed/simple;
	bh=beUFEsrq0hzFEnjL/+rqERJNky4pwzxgF7zPSiF4qqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhTUOcNkD0UNVGfuGVHzqujdSyZT5oLfZaBdnJuTs8pwYKj2OVvXbxx/094veQs5++Op5A8x/4Pz42lCy1KDmeGzU1PReNe+Hu+fNUEqEfErTwW8ROLF3AURbHv2ihN3+wEXQLFzE9yYXknhUO4lWNfKq1YhRLcvK/tmfbhD03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMmoLx6g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMmoLx6g"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIQGZ2342295;
	Mon, 3 Aug 2026 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9tXzDKhyISs/qElBn
	EJb4B/9nmHKL0PWuDli8MYqL38=; b=FMmoLx6gHkHIhkPi8hFrRWacBBW61xO0K
	m/ZFwDmHEG8ASYR7IEJ6w/ODOMkIFA1YovgWCn8CuExfjQuH/MCnMhFY5IvihxOd
	mMKnWUPE5LS/NrCd4sv6Kq2Cpa0xcT6KUBXNKHUsYFAU03IS/eObRHiVeCJxs+OJ
	D3paKgFbKqNhwF4MU5a9hvUAKRVqKuE6jbl387dmKpX1agy81hoDof1cCIpHAh7P
	ZthDDXmIdir05GcystQiXjqqI126s/makYbYEiRxQQTXdMrKJ0GWyUEnxTdxeuZu
	CCYAZwVjHolTCVm8uQccCAfrmFsPeSx+x8kmnKmT3miUDxWKjw8ug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eugwjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EDNTt029830;
	Mon, 3 Aug 2026 14:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwsr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673ET8AC25952798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BEEC2004B;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76FDF20043;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] s390/pci: Rework__zpci_event_availability() to remove conditional locking
Date: Mon,  3 Aug 2026 16:29:06 +0200
Message-ID: <20260803142907.1771509-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803142907.1771509-1-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0-hs2zUGHg7ovT1toytK9XDfUnDs0gYi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX8Tol8I5oaNuC
 8DCKi8SXr7PW/uM1VISAzkJpo2q8WBtUP8yVXuFp5Pk6tRTIZS59zwmWUZlvkYVefEHOiKL2fVh
 s4BR7B3scaK6AilVI0SsyeFC3QmY5pU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX6QmtUYw/UwiU
 qhmUiyhEDNpyumPXR+53mUWMQL/zCgVGUkvfgNkq8+X5aa7jvUuCF3rvtbgKFWQXM4eT11N27GG
 IuECAgBe8ON1LzInXdieaRZwQxeV9n4PsIZnDDgRHWFgj5WBTg2BL4d4FhOZV+sLpWLvpwbPrHd
 tsSZtUFYrWuZqomZjjuKuo5IjLKyEWJrd97ghrBaOXhv4h9doeHnvG+9GM6XvhzVl/gwDZV0QXO
 GRPwI3zWTO1KWDRxYGIqrtymuaj43U7Wzqdzf41r/Bgd8STLTVIquXGNZrcey7RhhFgC64VrN36
 KrbEYoqfhE8mEpFooHOl56J30Wj2/YBnNA4EsC/CCAxE+z9mTN8unXUdtLj7g6zQEqp7dG+tqOM
 5qOHfSefSPaxNf08xqba65bdReg6vMjGgGBwOqn4Dhlqca7F5kSTTKgiORzUcxu6O3sIlLhRrKg
 ateEU5RfYEagNBOx6bw==
X-Proofpoint-GUID: 0-hs2zUGHg7ovT1toytK9XDfUnDs0gYi
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70a5b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JSI3kJYzbkUK55s_vuQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030128

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in __zpci_event_availability():

arch/s390/pci/pci_event.c:402:10: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
  is not held on every path through here [-Wthread-safety-analysis]

Given that code which takes locks conditionally can be considered
suboptimal rework __zpci_event_availability() to get rid of this.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 108 +++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 48fa26dcbee1..f96ee87405f9 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -389,19 +389,25 @@ static void zpci_event_reappear(struct zpci_dev *zdev)
 
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
-	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
-	bool existing_zdev = !!zdev;
+	struct zpci_dev *zdev;
 	enum zpci_state state;
 
 	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
 
-	if (existing_zdev)
-		mutex_lock(&zdev->state_lock);
+	/* 0x0306 - No handle or fid stored */
+	if (ccdf->pec == 0x0306) {
+		/* 0x308 or 0x302 for multiple devices */
+		zpci_remove_reserved_devices();
+		zpci_scan_devices();
+		return;
+	}
 
-	switch (ccdf->pec) {
-	case 0x0301: /* Reserved|Standby -> Configured */
-		if (!zdev) {
+	zdev = get_zdev_by_fid(ccdf->fid);
+
+	if (!zdev) {
+		switch (ccdf->pec) {
+		case 0x0301: /* Reserved|Standby -> Configured */
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
@@ -409,18 +415,9 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
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
@@ -428,53 +425,54 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
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

