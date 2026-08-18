Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6C1D95A3;
	Tue, 18 Aug 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080675; cv=none; b=ll7GHa53V4Pxo/3VlUwqS/W4cfLcOjPsFxCM0ITDI12LQj6cyK4zKlhhVBqsgBs3C6BvDcgRvERN/ZwZXvyYT29WtkSAYJcTqDUHd7jsQsC78cyn4IRq/NZn24k6sJxuDIE9/+wnbb01zmrNlyl//+adncpEDVn5mqD5vNkIxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080675; c=relaxed/simple;
	bh=IDW+fleWsvkiks+s2gnrxeximrB30wzFu+95Pr2KWPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ix524ngHkkyGlQbMijplmPWEO/5WBQ0xja3wi8fo1eJEaQhwhI6KmyCl3s5rWQPsfkVTMlXWvjMFGdg5p3yjrGAVVi58DmmPhf3jyeAJg92DrPLqaGLgq+qvVSRNqudqyRfjT0+wq3794X0Mia1p7TFcU2U00cQglKlec0iuKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUhBwKx1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUhBwKx1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVbE13306853;
	Tue, 18 Aug 2026 19:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ntMDbEAciAN+SVn0hu+TxhsjE4UK
	rV9MlkYFkCS8sao=; b=cUhBwKx1hs4EhmktAidIVFjWdFaLQTMmE1sEYXPxZLZy
	c5XgFKdEchBZHVGs2li63KTNHJ+6Dn9KTdJAhS2s8zIKPjpSSjlA8VIz3IpoLAEr
	MmLuhjQNEYch6pSKYdo5fQ5oWTffrYMbacGg4vd+3z+hPuKDZdP9mEpQBL5ryUME
	7nFiMjxU/Gc5ksSo69OUb+61floBKrxFLBgQRlncUkVYqOp6NtJRBYhk/e/0BZnQ
	iHaOPo9BnQHcsCMiMl43nhwDdROHtUMiJ0XD9waUMOs0KxeZ6M1J3JXiMY20a8hW
	DtQyhhWqjSNFWM5pb4TH4Zp0LSz2j6V0RxCQydoUnQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtd54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:17:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJBJ4G029774;
	Tue, 18 Aug 2026 19:17:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngcu3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:17:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJHpS53736064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:17:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FF6858045;
	Tue, 18 Aug 2026 19:17:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C73C58050;
	Tue, 18 Aug 2026 19:17:48 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:17:47 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 18 Aug 2026 21:17:46 +0200
Subject: [PATCH] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNWw6CMBBFt0L6bUmnJqB+uQ9DmrYMMpFH05YGJ
 ezdyg78PDe552wsoCcM7FZszGOiQPOUAU4Fs72ensipzcykkJW4QM07WtXHWVIe3eyjClHHJSj
 XYlID6hcHAwIsdCgksKxxHvPnSDyazD2FOPv3UUzwW/+QJ+DAK2N0XdXy3F7hPtC0rCWZsbTzy
 Jp937+Gepxa1AAAAA==
X-Change-ID: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=IDW+fleWsvkiks+s2gnrxeximrB30wzFu+95Pr2KWPg=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJa1t+uCZ1++OymLRlB7/bdrplik8BY0hJhMMlLaPWy0
 6/X2B170FHKwiDGxSArpsiyqMvZb13BFNM9Qf0dMHNYmUCGMHBxCsBELPYyMnw58NbklUfyZMHg
 aWaLsu0u3M05X2az4IV41G2JPr27trMYGU6ufPn3zzat7SsYDR7vWDKdr2XZHrUWfvYQ3VvGAtL
 PORkA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfXymwnx36aydp0
 lL+Eibk0GCkyQbLPnH/tZeB2KMMcSBDwPNVNBvZRW5LO3pdEcss5ijp/BZ80MU562uJAgxICc7N
 jHXnXhMa4cZONpxZac8Z5wffP/7k5kgiYJUYYQWEieeytFOcsQOJ9KFGIS+Zb8AFqJVgu1IMQqM
 qG/eFrSwdPi0iakCyfXsRSogEdlCxAylC84evml6lJrLEFw7MA4u01HQ1dkWgriLcn8HnmtOON4
 BfGXnwkyFkc5G2S7c4v7iNMdFcQfhr3JvTFH8tLmEafxM5wqT3r8DjqRjRZATu/aZVhw5wshWj+
 j4IV5JE+dRfQPxJmyiDkoksfv0jPZE0ogWCTs6l/MlsJmLbnPwUyY70s0X7OmA4JLyqQSfGXeg1
 ptJ9TNXcYWfNoc3xrKrKWUrhVXLsGKYqcy9S2D2f+F1kqfysHoHiTE7XdSbVrJ4oEFEptsUg9St
 MValrHWlo75FpaYtp+Q==
X-Proofpoint-ORIG-GUID: T5wWpw4-BQ_OiXBJHTfD2wy7C0EbRt9K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX9CL04SHBNFW2
 G3nPoB8izctagtGvVESCiVVCuVlS3YDtOlh00m90V9DkgCq7ui3AWz/7Zvny9D3Lwv7EsA+o4Hu
 b4qEfQ80GbedrOuRMpJQisDk6RiUXWw=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84afe1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=7bLVd-tG6EYq6qT3GVcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T5wWpw4-BQ_OiXBJHTfD2wy7C0EbRt9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140

In zpci_report_status() a reference to the struct pci_dev associated
with the struct zpci_dev being reported about is acquired using
pci_get_slot(). This reference needs to be dropped with pci_dev_put()
but this call is missing thus leaking the reference. On subsequent hot
unplug this will cause the struct pci_dev to not be released leaking
memory and potentially prevent reattach.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
index 7030f7052926..76b8afc146fe 100644
--- a/arch/s390/pci/pci_report.c
+++ b/arch/s390/pci/pci_report.c
@@ -151,6 +151,7 @@ int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char
 	else
 		pr_info("Reported PCI device status\n");
 
+	pci_dev_put(pdev);
 	free_page((unsigned long)report);
 
 	return ret;

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021

Best regards,
-- 
Niklas Schnelle

