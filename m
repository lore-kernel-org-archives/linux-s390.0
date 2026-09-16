Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD87382374;
	Wed, 16 Sep 2026 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571675; cv=none; b=csclTcWMAll7aymXnB6Fc7OM7UKXQDRRUAqDIsxbzCpXD6ShuTCqAYV5A6ib9lsq6SBOGyZ7HjMlEKW4ReBKpA7nQEXqurRF4lDsi3738GGOcq2e7F5z0vy5Z7JY13mZnVdx+NxyG9AkW9vuu/m/gdbI3zkJIiVy/7sj8INXYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571675; c=relaxed/simple;
	bh=7cqApsxrrXF1iZBaYezLCsDW9Lz3TanCXVpVsFdHdeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPEw2jH1qF8KGFN5xQdaMLwFI1gmKS7G8OXbQU4XSTyNoR28xOWuI/w6zr4/MdIj+JilPpIKUGNpTD3h3PNvQNY88grlKG+2DDGuEfZJweW19Wduq1tKROJEYBiEth1pmhqF1wxIveIPOTgbiBJyh0qK9OtBU4grjETK35vU4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEZlb7/F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEZlb7/F"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVv2r3863232;
	Wed, 16 Sep 2026 15:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FADIZB
	I9RVgxD2tSXrqyFP0Q/K/kD63anx3qbSxA5+A=; b=fEZlb7/FjPIKjniywRnJ6m
	3w0JZHgp2ZkWc+QaKGfsrmZC4pVoc1sU3ZvW1gRZusat/gUZA+1oUn+pavcS+/Xd
	wkAlErW6h9JtQsxDKSDLAQ57avpPssih7ILKrc5re7tqz/v/ahUX6HVEyBo3/JD7
	fx48DZl/2SeLUzWI7/sliRl4x7qObYh1REK+elp4rAVqAxZjk3Po1utm1rr4sHZk
	c98SMXSlqOdP/X4xUaRdCH+y1/u4fGdNAXjEdqxiOOBIORv7fXKBmCpbfAWVTj/F
	pHLiGwnxzO7jXyV5RnNQguKzlRxyZo8yWt6fiO12ZdfXdD46jKOoepk87Of77GZw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hw8ca-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaInx1634620;
	Wed, 16 Sep 2026 15:14:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywexxtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFET6s12976664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:14:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B30BC5805F;
	Wed, 16 Sep 2026 15:14:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8762958059;
	Wed, 16 Sep 2026 15:14:26 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:14:26 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:14:10 +0200
Subject: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference in
 zpci_report_status()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=7cqApsxrrXF1iZBaYezLCsDW9Lz3TanCXVpVsFdHdeU=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJWbfIpOq2t0cUu89PvimaJ0scJssVNuYaFs+saPY9u8
 5jkUKDXUcrCIMbFICumyLKoy9lvXcEU0z1B/R0wc1iZQIYwcHEKwEQkNzP84b+476myjdaP/Py3
 j4N5VUQnbCp8u/bdZyHXFeLf+f5OnM3IsIxT49/SaT/cVgvyee17GX3DcV9i976ZYkZCz6XEY0N
 LWAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX+q24xGDxCGCR
 EreTtnNfX+eoMSO0aLGmy0TmJ61D4Z4S4weiOpYcEwbx2PfFI9NJX468Trn18K83v0JzRJTbhZy
 VQju1nj0DM6XQ81Un4PqFAUCJCYEGdwtHiuyrmWNOFi7agjLos0H0qD8kWyawjovZEkTPIWLP1z
 dXInnR4UBnhrUbqZO9vk0TRfMul2KEo34IcYC0sPffvi0WB/mviLesB5GhuhBWzR3Se2c2AF/Th
 INVVQByc5PTAqsd1ZOkowfUubVWiJOcQbf2Yh5/QsR8t3TOc7QgWEhz61CEjaW7KSpWN6Y+lfvY
 yCq2GO5eqq/6LNH5peMvou45747VknS2wqbRCxrWfG4zxhJ5/QolNudNT5040WM1VtW4OwciysN
 aFamdR3rrmzWNr5JGXHIa1zS1J5pbZyzU+i3DiASU1RBJTbSd/4rW0CpoYwAb41nYm3XEKHDuHQ
 BmY5DD6h6fNxNI+CrFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX1NrsnIRacEY6
 yFZpDfZex5MyjeSwzA3PDSNeKe7c4bjxWRVI6ojDgw4FGGoj6rujlEqUqEzeBKmgCJzqIqFKkx/
 ZEWPXAABJ3Bkl4AzmW/Yp4TVNnFqtCc=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaab257 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=x3_7OtgpGyxeELnHUrcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r-x0GIgefrII0zk4wVQhQaJqeEgT5kv7
X-Proofpoint-GUID: r-x0GIgefrII0zk4wVQhQaJqeEgT5kv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160204

In zpci_report_status(), a reference to the pdev associated with the
zdev being reported about is acquired using pci_get_slot(). This
reference needs to be dropped with pci_dev_put(), but this call is
missing, thus leaking the reference. On subsequent hot unplug, this will
cause the struct pci_dev to not be released, leaking memory and
preventing reattach.

At the same time, the only existing caller already holds a pdev
reference. So instead of reacquiring and then dropping another reference,
simply pass the existing pdev pointer to zpci_report_status(). This gets
rid of the need for pci_get_slot() as well as the zdev->zbus check.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c  |  2 +-
 arch/s390/pci/pci_report.c | 11 +++++------
 arch/s390/pci/pci_report.h |  4 +++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index f317a1465dad..3b4941b65840 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -298,7 +298,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
 	device_unlock(&pdev->dev);
-	zpci_report_status(zdev, "recovery", status_str);
+	zpci_report_status(zdev, pdev, "recovery", status_str);
 
 	return ers_res;
 }
diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
index 7030f7052926..867419779219 100644
--- a/arch/s390/pci/pci_report.c
+++ b/arch/s390/pci/pci_report.c
@@ -89,7 +89,8 @@ static struct debug_view debug_log_view = {
 
 /**
  * zpci_report_status - Report the status of operations on a PCI device
- * @zdev:	The PCI device for which to report status
+ * @zdev:	The zPCI device for which to report status
+ * @pdev:	The PCI device associated with the zdev if any, NULL otherwise
  * @operation:	A string representing the operation reported
  * @status:	A string representing the status of the operation
  *
@@ -103,15 +104,15 @@ static struct debug_view debug_log_view = {
  *
  * Return: 0 on success an error code < 0 otherwise.
  */
-int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status)
+int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
+		       const char *operation, const char *status)
 {
 	struct zpci_report_error *report;
 	struct pci_driver *driver = NULL;
-	struct pci_dev *pdev = NULL;
 	char *buf, *end;
 	int ret;
 
-	if (!zdev || !zdev->zbus)
+	if (!zdev)
 		return -ENODEV;
 
 	/* Protected virtualization hosts get nothing from us */
@@ -121,8 +122,6 @@ int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char
 	report = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!report)
 		return -ENOMEM;
-	if (zdev->zbus->bus)
-		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 	if (pdev)
 		driver = to_pci_driver(pdev->dev.driver);
 
diff --git a/arch/s390/pci/pci_report.h b/arch/s390/pci/pci_report.h
index e08003d51a97..dd7b0b05001c 100644
--- a/arch/s390/pci/pci_report.h
+++ b/arch/s390/pci/pci_report.h
@@ -8,9 +8,11 @@
  */
 #ifndef __S390_PCI_REPORT_H
 #define __S390_PCI_REPORT_H
+#include <linux/pci.h>
 
 struct zpci_dev;
 
-int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status);
+int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
+		       const char *operation, const char *status);
 
 #endif /* __S390_PCI_REPORT_H */

-- 
2.53.0

