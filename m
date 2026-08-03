Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D237377553;
	Mon,  3 Aug 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751664; cv=none; b=nRu/zxAfhbg24X3Jd0CUB/chO99P5M78gCbcktBQdS3gQU908IaLskmuaPUlcx9udcKyctHKX9yAJ1K+jDp9kZ1COojL/SQj1thp70HvvetEiD9Tv5o1PQNRM6jqc0HogJWZjWM1eypdx6zMo0hxgcmpT2vkHllbz0FiSC4MCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751664; c=relaxed/simple;
	bh=l8VHo3beb+c1Ya5TU1gZOZ/9kYIgeg3YtqpughHy37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAfe8VPkNTK48CmB9l0Y8V+2NN+t2welgxMSskSBT1QwzexWKtkgYuhaWkLFjUL4E852TOcGPH624cv15waKdAWK16zMdvLqiiazml23GKPtMdk0jY+PYVmPGot4mAxlDmkRhFvdYldk3hzYxSYAnMG6C5puNEP5yIS5ntYmubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cU7whaSy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cU7whaSy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llk3o167346;
	Mon, 3 Aug 2026 10:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KAPt8yphSUrRziQzp
	GGyIEBbbgEz71A+Y8k1zEJtR2s=; b=cU7whaSyGX7lIJa/jtgKIcGezsIKwOjiJ
	N0NZqrMJAT7cwy5yyQYjJKCrlqPecgo8ZHoAP5IlUuXhMqSjAaylZOTXbZMB8MU0
	DgkxyercvJ/zfH8ivnCDQAAOOsTThlMGOdNM5etWf7D0x128Y18JEUDLi5Bxz61P
	++iNC1+46QouYVM9uiDmqI8xOos3sFVP6CwlqFlziH+gHiuUeO7BBnwNCwDltJqW
	JcWp1PN3SIc7HcOZgOGDezG/bz/JNDhVJBK13AmiJSj12Oxg+srTR5oWxW4wtnWK
	ebkLZygJcuEt0Hj/PiMXkCYVPFnbbhomLlRlF9oNqvvEJPpVDAa5w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g007e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6739uQjv013967;
	Mon, 3 Aug 2026 10:07:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jvv2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673A7Ojl41681248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 10:07:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259512006E;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AD22006C;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 10:07:23 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] s390/pci: Rework __zpci_event_error() to remove conditional locking
Date: Mon,  3 Aug 2026 12:07:21 +0200
Message-ID: <20260803100723.2343688-2-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX1iymzai4PP5Q
 +tpvmH3Ro1i2kvTGudF3BaFEwQhuVkWzPESTRFEfwJC+pUdXszmrKA20F089Y/ffRG4XjuJMAnR
 coyTKVZNX1ezoG1v3WXQiRWtLogUinxIpCKl/jJnPXN2OMOhFPg4tprZHXFQHP4dQOCNVvSBpLy
 TBsyB6xBZLMCLHPeHESAYgwvM6cfrmZvvHVZkYksKqNFuBfmUuHaPK5DWUgmLhOOhX2zwziFKGe
 veuPMdM0WghMLwrj8dHKGMxfeKuXPNXK9iF+rdIZf9RWLrdlML1abZVM5PcFqTzDxMYYlS30Tyw
 YRf2fWp9lSz1xyjTR5PRlXheRsFZw+vcLBPov4kXUQ+7xm8iphWztuVMn+ogi0UIwhJahYWVf1O
 rYxGG6CIUsoFJce7+tTJG6CZ57i4xTwmEoUhPPxjUddMjawBiezecPVdbz3+4KmnYZRfOtyAaSq
 nWiEMPCp6bG+QIAnV9w==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a706861 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=m4_1mmLPwvc7V99NFaoA:9
X-Proofpoint-GUID: fWsDUe7asRME3VIFEMxmyjym9k-Vdg2-
X-Proofpoint-ORIG-GUID: fWsDUe7asRME3VIFEMxmyjym9k-Vdg2-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfXxsYGm6wc9z09
 6+Yc8k4S68XFBT/+/o4S/oj2zb+QgDG1liMoMqIQw6zxz8GS4JEtWSQKTaawwvEWAayVDjnWgoP
 ClLvFOGImgis5HqqUUT4MjqVUKzpUWM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030087

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

