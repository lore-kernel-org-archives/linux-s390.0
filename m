Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A238A72C;
	Wed, 16 Sep 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571678; cv=none; b=Sfb+S2m9vCivL3rrBh90v6PD6MCeXV3eoQANSAiyLgdreY2xPREtIJl//ieas3SZUgguAT4rBWK3DYMasyh0rE2isFPv+eKLRAYWnZNeFJ7jgmfn4xYRwm4OuwsAt12q2S9f2UFF2u1WoM2cuyXN+ZZ8gkyrsXUNvRd0z93IPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571678; c=relaxed/simple;
	bh=GC6gEaCPT0YK7vPMmtVnLI/Z4ceZjHbrLe4dhgkJ22M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooBvxTeBrMP9fN8uXzGFSd6JaDwUvwOnfQALgb6dgko904IzkjjcopM0K8Kx/4PmQwziOKVLHqxT1q+iDS2e2OIQjxPdSSYrGcwt80d9JzLPTqzVXHncBo6ZDJ84mLkkcbY8eFyjauZEp4quSUdl0LstH2jnL9RtZqI74J65cuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=croTU5JS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="croTU5JS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVpWw4007270;
	Wed, 16 Sep 2026 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JWvBYq
	Yn/2ZOiUL2Pmg1UE0FFMWVSjPK+5ZNX0O/8QU=; b=croTU5JSJuJ++LI+v2H9OX
	Hejp5stpUU12OF+IqoBVy1jzD+DIRf4JnaCR7SHapwhK+R6UKvR6w6H3XI6S6Qiy
	lDOrBaxZ1RwqKi4brU8RmZqleXlzq8w7mHlni9LORTPB+skl9K3XAUYj332Yxn97
	OSgp+6M1m5ipqRvOd6KU623f9K1Th2m73MrKv6Tly/c4oau0EhkI2FfkUHRFInL/
	R9gt22oDq9CtAjKJHq0RbgXGt4PcEWY3rSa9Dnh7RWkaulvniFv08QyERXp4vhpl
	Mqh5POQlygNVnd7fpMMrkPpRaydo2cMTCBShC839XCdKiqsvDyD3rh8/TA9SEJuA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83wawj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaDpn1571790;
	Wed, 16 Sep 2026 15:14:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bxwr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFEXbE60293576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:14:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C9275805F;
	Wed, 16 Sep 2026 15:14:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F93658053;
	Wed, 16 Sep 2026 15:14:30 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:14:29 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:14:11 +0200
Subject: [PATCH v3 2/4] s390/pci: Fix missing device lock in
 zpci_report_status()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=GC6gEaCPT0YK7vPMmtVnLI/Z4ceZjHbrLe4dhgkJ22M=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJWbfLRW+GwvEdsXzA375dmoQunFD81Oyh28ldlb/sZ9
 eDCrptmHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEwkcT7Db7bUtbmphTsZD808
 uCZrZ+4sSbaHiWwT084adfEdqeVgDmdkeHDQlyt02ba3WttNVnqd65q6Krs2L+7Ff9eI/xe/Ht0
 ewwgA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX9hl9veQ4+hyL
 9D4h1TwIHI9ko5fKXamubJfn/L9sD9r2i/WQ3irdbHRa/mfxY1oNb1qt+Jh6Iu3TB03arY3Reu6
 2fLiMx0UorYK51i5hNLyy8xhd4IChUdScMdgNFr2OlmnUnU5XDBwvUppSLwONQZzTk4b0cE7DOa
 LEumZAMmMLTLrighQDFt9XE5agm/eKVxvTaSOueXxcU5R/Wr70KYPNS1nkzq2qDM5RU7m/NP+cK
 S7ueRMwdEOSu8NZocXU+M+kQEA1ZagjHKLYWtGfCGWLiVJc3jQwZTWaldqj1cxUStRjo77Zzsdt
 TQ7buzUI35nt/d+Sp5nAas6DfxAay47acWLVDKM3/yTAm0zNmlLs0qt0opqnlSFEabFeeNAK2Hq
 dolxB7M1CZFmemkFktjGx7qO/nMAOOKxIE5syXLTRZtDZmN4rNw+/XuwMBYZjisRACiuhTBAtrb
 K47IB3LhFCfCFgOjKMQ==
X-Proofpoint-ORIG-GUID: kEvc0JHkY8D7AX48AtE7ARfqhvoOOKxS
X-Proofpoint-GUID: kEvc0JHkY8D7AX48AtE7ARfqhvoOOKxS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX9EFuOavTvhWt
 3ToOscTpgAuHGVbri7TlxGuSR5UhlHno1ydur/0B2EZkucSQup9vhVVwFxuI5JL9AwiziyqqeiT
 s2twL6+bVWWhg73U0y2nNjRJSRu9JWs=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaab25b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rUsYaACuVqKhdyhYbpEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204

When pdev is non-NULL, zpci_report_status() accesses the device's driver.
To get a consistent state matching the recovery, the device lock needs to
be held. Do so by expanding the existing device lock critical section.

The lock only needs to be held when the pdev is non-NULL, so extract
the pdev-specific reporting into a helper function which also adds a
lockdep assertion to detect calls without the device lock held.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c  |  2 +-
 arch/s390/pci/pci_report.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 3b4941b65840..ec93f34b6e19 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -297,8 +297,8 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
 		driver->err_handler->resume(pdev);
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
-	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, pdev, "recovery", status_str);
+	device_unlock(&pdev->dev);
 
 	return ers_res;
 }
diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
index 867419779219..72ecabf7003c 100644
--- a/arch/s390/pci/pci_report.c
+++ b/arch/s390/pci/pci_report.c
@@ -87,6 +87,19 @@ static struct debug_view debug_log_view = {
 	NULL
 };
 
+static ssize_t zpci_report_pdev(struct pci_dev *pdev, char *buf, size_t size)
+{
+	struct pci_driver *driver;
+	const char *start = buf;
+	char *end = buf + size;
+
+	device_lock_assert(&pdev->dev);
+	buf += scnprintf(buf, end - buf, "state: %s\n", zpci_state_str(pdev->error_state));
+	driver = to_pci_driver(pdev->dev.driver);
+	buf += scnprintf(buf, end - buf, "driver: %s\n", (driver) ? driver->name : "n/a");
+	return buf - start;
+}
+
 /**
  * zpci_report_status - Report the status of operations on a PCI device
  * @zdev:	The zPCI device for which to report status
@@ -108,7 +121,6 @@ int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
 		       const char *operation, const char *status)
 {
 	struct zpci_report_error *report;
-	struct pci_driver *driver = NULL;
 	char *buf, *end;
 	int ret;
 
@@ -122,16 +134,13 @@ int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
 	report = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!report)
 		return -ENOMEM;
-	if (pdev)
-		driver = to_pci_driver(pdev->dev.driver);
 
 	buf = report->data.log_data;
 	end = report->data.log_data + ZPCI_REPORT_DATA_SIZE;
 	buf += scnprintf(buf, end - buf, "report: %s\n", operation);
 	buf += scnprintf(buf, end - buf, "status: %s\n", status);
-	buf += scnprintf(buf, end - buf, "state: %s\n",
-			 (pdev) ? zpci_state_str(pdev->error_state) : "n/a");
-	buf += scnprintf(buf, end - buf, "driver: %s\n", (driver) ? driver->name : "n/a");
+	if (pdev)
+		buf += zpci_report_pdev(pdev, buf, end - buf);
 	ret = debug_dump(pci_debug_msg_id, &debug_log_view, buf, end - buf, true);
 	if (ret < 0)
 		pr_err("Reading PCI debug messages failed with code %d\n", ret);

-- 
2.53.0

