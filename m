Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF92C21FF;
	Mon,  3 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767355; cv=none; b=Wr6FffAW+aVP8mOgerlNBn26+gFt8inhf1yHb2CHOu0rODwzQAXvViSxCgznSpCWlvvMGlrV6D/LW/8n/fw+JwfxM+9du1TNHZYwRFqBM/41/RR3FfRiFawxchfHVEB8xywlddru2+6K8J2GpTPu1mbknSNC02Q7A7efa1OS40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767355; c=relaxed/simple;
	bh=l8VHo3beb+c1Ya5TU1gZOZ/9kYIgeg3YtqpughHy37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjP1ztIeMZDAm58MM1zrMQqxcmSCnIHvykWC//w+xf8HHWrbmpGPsCpUJk58r4BcqikCAhWMMd4KDckACejES+cFVnuxurbavi10XTkTTVIs1Qee5yjRkb4aN92F4sRVLvq1xahg4Gk6QF9W/P8/YZZ7lSV7W725ZSVvLyYEneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJKiROfK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJKiROfK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHv532206416;
	Mon, 3 Aug 2026 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KAPt8yphSUrRziQzp
	GGyIEBbbgEz71A+Y8k1zEJtR2s=; b=fJKiROfKdk9H5I7hkaIqTduKVLYS3NvQx
	dW5QLFI3EWSctBHK7y9b4brbLmx5Rsk09/TsMa5Bnsh0lBo7LlCTuYm40lnCUSl2
	Cuy/KbO5uFbuym00G+WiI87Gs6TMLKPALDRGxeEo9GE6vYDF+SazBi1LnQUemeY7
	cS+vcC5Bd29vsKRJ/p3oSQVnxw6Vr+sEkcuRuLhOeeUJ9KBSWmMjsPMcdxWBGBzA
	XuoPTlc9fYh6C36SrvG3YH2KoH8chWZiIxNEMc4SlDIIT3pnQmj6WfcZ+EEriglW
	uq1KO1njvCWq2t+4Kvesv+D5yGu76MehnNnDeJURyL6pZphs2GOzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g13gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EQFVP012122;
	Mon, 3 Aug 2026 14:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydhpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673ET83714680514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 713FD20040;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CAE32004B;
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
Subject: [PATCH v2 1/3] s390/pci: Rework __zpci_event_error() to remove conditional locking
Date: Mon,  3 Aug 2026 16:29:05 +0200
Message-ID: <20260803142907.1771509-2-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX+G191qlPCXQ7
 6FL49vu8HyfWqUus+JR900HE4bjlYNm9i4vVCATkDykVqCt+uNOR2Jnzq84l3v0wF5plhMLpjuu
 7+/vp1vN8AaagUONZ6xl/gP6qIvaTX57bwj/DA3JHmDZ48f8sGas0jA1HGwHKmncz4vQlOWOGMq
 HKSXyiSS6SZx48zxbB229gnCoDTfLQ1QqzK12RI9b1/ekwSIaWQgsqtvT46C7YJHF9V60ZsCWcU
 76lwa9rWepYhRbZmvR3Hp8TMQ5TGe4xmNB3ontwMDEkfeRQlxernUE7W3gPWzFNE8SAUqal/uqH
 ByzLJxLbMbnMU9O6Z2ZRw6PtGjJdVFZitnD4gKFvBPePpYULFLoVOMt+HSq/VbkLLatHwVM+e8+
 QwlrSXBoMBjaZPvQc6OOaziBYbnHADrKF5fQXh3y+k/olMI6PdWrTmkqCyHMN1O3eZGkmwPNqEG
 xCr+ux+As1e4HXfo+hQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70a5b9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=m4_1mmLPwvc7V99NFaoA:9
X-Proofpoint-GUID: Ff15MI4aK0exooL4EH2z8VZXB7Q_tAA2
X-Proofpoint-ORIG-GUID: Ff15MI4aK0exooL4EH2z8VZXB7Q_tAA2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfXwZYsou9p05wC
 VC92OR87YOLwVhvAS5AOZOhHn41Xiv8qOeELLb5ajh256F5aP+Qr078bZn7MVubZx1MXOEyilOt
 o5vTil6WO6V/k9O4/KRRYElsJPo5Al8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030128

Clang's compiler based static context analysis does not work with
locks that are conditionally taken like in __zpci_event_error():

arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
 is not held on every path through here [-Wthread-safety-analysis]

Given that code which takes locks conditionally can be considered
suboptimal rework __zpci_event_error() to get rid of this.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..48fa26dcbee1 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -288,6 +288,12 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
 	pci_dev_unlock(pdev);
 }
 
+static void __zpci_event_print_error(struct pci_dev *pdev, struct zpci_ccdf_err *ccdf)
+{
+	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
+	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
+}
+
 static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
@@ -301,24 +307,24 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	zpci_err("error CCDF:\n");
 	zpci_err_hex(ccdf, sizeof(*ccdf));
 
-	if (zdev) {
-		mutex_lock(&zdev->state_lock);
-		rc = clp_refresh_fh(zdev->fid, &fh);
-		if (rc)
-			goto no_pdev;
-		if (!fh || ccdf->fh != fh) {
-			/* Ignore events with stale handles */
-			zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
-				 ccdf->fid, fh, ccdf->fh);
-			goto no_pdev;
-		}
-		zpci_update_fh(zdev, ccdf->fh);
-		if (zdev->zbus->bus)
-			pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
-	}
+	if (!zdev)
+		return __zpci_event_print_error(pdev, ccdf);
 
-	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
-	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
+	mutex_lock(&zdev->state_lock);
+	rc = clp_refresh_fh(zdev->fid, &fh);
+	if (rc)
+		goto no_pdev;
+	if (!fh || ccdf->fh != fh) {
+		/* Ignore events with stale handles */
+		zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
+			 ccdf->fid, fh, ccdf->fh);
+		goto no_pdev;
+	}
+	zpci_update_fh(zdev, ccdf->fh);
+	if (zdev->zbus->bus)
+		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+
+	__zpci_event_print_error(pdev, ccdf);
 
 	if (!pdev)
 		goto no_pdev;
@@ -340,8 +346,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	}
 	pci_dev_put(pdev);
 no_pdev:
-	if (zdev)
-		mutex_unlock(&zdev->state_lock);
+	mutex_unlock(&zdev->state_lock);
 	zpci_zdev_put(zdev);
 }
 
-- 
2.53.0

