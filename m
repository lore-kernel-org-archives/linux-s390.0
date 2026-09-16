Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04503394E91;
	Wed, 16 Sep 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571681; cv=none; b=YF4WFu6dsebM55pEYMs0P9D+YjkwbsGn46Coy51psRPUVs0a8qelcbEO5/vD+N3usO8JwwxpwWu8ASU3JY7Ri1P/egXOv/u8xJg+B5phD8VBeQwO5W8Falb58p2h4yvCUqoBGoKcwbRvPc04DDfG5lNan0K6S9ZffaYLBHnU604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571681; c=relaxed/simple;
	bh=NdNjRxc+wRko4KIQOGeyMjd36ycXOwfSKQOfr1J68N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQIpwIgIiFjBe3GI+3BwxQ1W9RtNj++E8Ba7zy1xk4/Hms/p7S6A2/K8W50cviJnDuqXONhFuoOUk7XLRrse6PuzIpToEFJtf2K2124xkXWSukkDunOedv8KEdx+xytxjbnQCTwcGqHnXwqb+FdPjtKyTyl0Jq4LqcuRQU4eVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VE6G5clv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VE6G5clv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVsKW2136149;
	Wed, 16 Sep 2026 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ac93+U
	z1/X7RqIN4afeTPVET9P5fvYEcV9SgWbJbm14=; b=VE6G5clvPX2N5iBAOPeH9l
	HO1e7RiamtyNdUF5zr54xLjfDeAFT+WCtoJHpoQLNtTdlcFvCOf1fQhcmNxiqLVR
	+Zcfx2cYJYzCwdOMws/kdsKrkuqqTHDNsZGFbYswSViIBsk333FTOS7bvAvcBr8B
	fxWJUu50EcsWZVxD5KCVOADdhEEXQVwJIPP586IfuJ0iF/6mN3NMhX92ru1DreOQ
	QlQh69OxWq26GHSukjEhBLHenUIdQJ6QYezHiLCX6x89vFYgK0ibGunkMuTS70l3
	eENv2aon7WQ3xfO4ge5VshSI2gvrcJRZEW8GXPg2qEBvBVp4QeYRB+QhROZk0lfg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqd9py-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaAm41571749;
	Wed, 16 Sep 2026 15:14:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bxwr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFEain41157266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:14:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D4F5805D;
	Wed, 16 Sep 2026 15:14:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C59758043;
	Wed, 16 Sep 2026 15:14:33 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:14:33 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:14:12 +0200
Subject: [PATCH v3 3/4] s390/pci: Report SCLP status on error events when
 no pdev is associated
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=NdNjRxc+wRko4KIQOGeyMjd36ycXOwfSKQOfr1J68N0=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJWbfJtF4l/nMp8g3l/ZyDXpQeNfnzXLHxehs3r4+A1s
 D52s62yo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgIkouTH8j5zaJd8v/cckL798
 xj3m/LsTPuefKvOIWhsrfFzCuZ69geF/yh2Xa5OPSp06+jF2k27K++aevjs3J7Edz2ryZuopWlP
 HBQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX2D+xrM1PXhBO
 IGKYJsDlO+Q/wXkHpaq/k4XAbkQTolrgLmCsrtY11OxJot4R9N8rSHcT33ogEdGyJMTCsM7VgTW
 A+yCjNoMuBY0yYGwoNuJenU7jDm1fdvu8kzS4ZGK75BpbE2zE+OJQAzaLA4QxfE8iKftRFzHTTu
 AzJBx7IXL6MUtsvYjw0494qJVlaBbS6nic0LS2vlAkQ0EH29FYN3MZwtXN631PSvUp1mXJWa9EN
 ea818uQQaTIF+a66KikFJDi5rjVdy+0rOzpVeMwGpboujVGq/H3kHPYlxDCnolQzwwSbMDO67Qw
 /O8d+KJ8fGhHRn3coucBpdezkcpWbzPD0IZ8hHk/3D7NDObZiX3qbk8sfe/0IU4pW90iyzkNQNm
 yGgY/DTo2tL4K5UR2qTV1jbIOxJ+BkT445TmGB3CE1jXUBOXpEzc9/8ZBS/I3wEwAvOtwNTgPlX
 7p2vEfnki7uCU4lz/MA==
X-Proofpoint-GUID: 2NgFI-eY16_7vDVfGr_ppO91g7vY74e3
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaab25e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=d-oOgTxYaRR7rsuNLcEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2NgFI-eY16_7vDVfGr_ppO91g7vY74e3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX7azMHUpW1tB7
 wBpNHFVteDgjmXRl4e1ibubYpEMAIPKITiAcRaD3bd9NiFpWnhMUHNfcqSuhXG/Ioat4V/KZv/X
 drNdzFF/Cdj2Jbzoec8NB7z+rDPwzPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204

With commit 4ec6054e7321 ("s390/pci: Report PCI error recovery results
via SCLP") SCLP reports are generated when recovery is performed in
response to an error event. If such an error event arrives but no pdev
is currently associated with the zdev, e.g. because it was removed or
not yet probed, no report is generated. Fix this by generating a report
specific to an error event for a zdev without an associated pdev.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index ec93f34b6e19..7b538c6ae11b 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -361,8 +361,10 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 
 	__zpci_event_print_error(pdev, ccdf);
 
-	if (!pdev)
+	if (!pdev) {
+		zpci_report_status(zdev, NULL, "error event", "no pdev bound");
 		goto no_pdev;
+	}
 
 	switch (ccdf->pec) {
 	case 0x002a: /* Error event concerns FMB */

-- 
2.53.0

