Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DC471CEB;
	Wed,  5 Aug 2026 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936994; cv=none; b=TQTTh5LualjN6OkcRFMVAwJnP+UiWCNeVARoMl38IwJQFMEqFHHOpyBCoIyd7AS1rHwEY893FUV0idgb8xAN06DozmIJrXJ3F5rVL6+Hf9cz6vlOjqY6dIpBBUh/BJ1N0OCERvX8H9QQY67mbqd/0T7IUtDBIh/jcOvb8FBA3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936994; c=relaxed/simple;
	bh=BZJUX9NcvJVgbaeeKfWxsCaWGpij24OSNPviaUfRR5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS2hVE/5q+9qv+JHyQDyWjcY8tvQ1BX7wUy5iTnunqPrj7klaoUfI4VckKW7r62rShR1Q7XPWpgADX2h/x0NZnI+gky/De+pt27Cbmegzv9C/XMUkStrvchHIBH/vEX0HbmORKrr8U5kwXFLx3GdleCaKKbF+u3aruZ0kYWxqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FJcnxIyY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FJcnxIyY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CIaKs3826729;
	Wed, 5 Aug 2026 13:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/0KJQFDJg5HOJ2UGT
	vrf/5xhQNSDj9isc/PJWdQWSm0=; b=FJcnxIyYfcpfrEpMJpPr2yNbMiKu20JuQ
	uzB6napsEltGQ8x0s2B6ibazh9rob6xhfeLeiH8p6f4v5A3QN7Z5JAh7xRB17jJM
	OD1hz514U6vs/3KhoaNuApc+wY1TGAhUegk6rRs0idFpJvQYh9AajOvOs9Vq+bBt
	Aam24y6i8hgZbxtltFXrjOtBQqMihZjdlzMC2iYtNnGkzm3UF6IkaEE1t3axx/Hh
	vOVdqs1rzeURyRM3tqjHfMmbonT08+OE+Osov7aoiKr3LskZetTbee+bKVXEfKdz
	AzzxTVAd3+pOc7K/5V+Rv1dtknl6pHMUYDX01s/HoelZub6wHn7Yg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h539a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DQFJ6011100;
	Wed, 5 Aug 2026 13:36:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtypgqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DaSQ549545722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:36:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E47D20040;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D607B2004E;
	Wed,  5 Aug 2026 13:36:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:36:27 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] s390/pci: Rework __zpci_event_error() to remove conditional locking
Date: Wed,  5 Aug 2026 15:36:25 +0200
Message-ID: <20260805133627.1216607-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805133627.1216607-1-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX/EEDngJtZxab
 eagSwkeeqaeY/h6wOmJ6I3QJxQPb/ferwtpGr1iF/f+vnAPqryQSBXbAJxvNgQF+1WslIchAf47
 OazeMd0f458M1f/1DX3hdi9RFJoP2Og=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX4Vu9amLbwZKU
 4u9tIVIRvWeGHJCHYEFsKA1RvD4n7eQX0m8IqI2Sw1TBWIaYqo6qIYO9DSU86dODkcvR0kOKlwW
 PIzt7Pu0w2sOrQEugWAwNqC6u1K1u2la0GG3BINCT6Hr/3zj9oC45GFroq4ARCtoEToMX/5SKha
 4ceQNUXmyI8G5lOhRx+R47TzxQlxGlBC3Q9BI+tUY1y4VKzqjQwImHQJtKWGmJEJm8HDZltSJGn
 wuERIJPWanN9yBkE0mOm2kns1Cn1hH1K++6i6PhawG1Vbt4+tF7u8eEEhfswgNRAVCvQ1rfAnNP
 KWwBSPDt+LDa5TuQ1RdnONHSE+GX3C2Hdv+PcREzNDkMlhzm54Bm6xxnE+vaBaev6gMXuFFpd3S
 Y7IcTrw7P4t7YT9KCuA9lsov+ms41doeTOC2+Pw3W6K9p+5Yi6XNF/bnyBjVVZ1uKGdDsy4MRRj
 pCfbIyW4Y4HYzugvNbA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a733c60 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=m4_1mmLPwvc7V99NFaoA:9
X-Proofpoint-ORIG-GUID: DDw7hS_eEUxvq7YJwH8zBX1Lid_vvX0o
X-Proofpoint-GUID: DDw7hS_eEUxvq7YJwH8zBX1Lid_vvX0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050107

Clang's compiler based static context analysis does not work with
locks that are conditionally taken like in __zpci_event_error():

arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
 is not held on every path through here [-Wthread-safety-analysis]

Given that code which takes locks conditionally can be considered
suboptimal rework __zpci_event_error() to get rid of this.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..bead4ed5d4ab 100644
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
+		return __zpci_event_print_error(NULL, ccdf);
 
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

