Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F231985D;
	Wed, 22 Jul 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725729; cv=none; b=DWYMtyujyo/euV6gVyE6xU/vDuZe1FWWHYAxDnWrRTURLxoUFSU2GmLQVEKtq2C7FLFVcurlej+7OZsawd2d6j/La53qCtCxDNd0hG7CvOispTjrfAJPEBk1UqxCGBAoVHhIrR+/FiodCOqJkqC77T/CVI+4IM7Hn9iQo4Z8sUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725729; c=relaxed/simple;
	bh=rHHqMu5/r9TWTyNdrtpxa2sx8j8QayLrEbYOC6bJH5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dujhlE3mZg+nFrcvyrBV1EHtbERaSxW3hDewLtqN3xVmWCnl20x4JgdRy6JO9GaCJujd+8VQSG0M9lSKYzlmoxKcNV5QOCuWNdyxB7paSfWQ2pYHmW3xSrKB3dHT+3p7Kwv9WYaGmqoeSgTrkb3F2p6dGyZciaIYkp4D/xCM7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDL2MfR+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDL2MfR+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9BqOJ3565670;
	Wed, 22 Jul 2026 13:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=OZJ0+dwcofhnEPON6TdxYtdyP3aP
	3KFTDOa0v5v8MoA=; b=lDL2MfR+zAIe/OG9OAC4rawDD3go3fYAv181Sj2RrXUE
	j2iJuqSfJ0JAkuo61k0RtVR0LycDb4LRdV+aM8cQifPJXxNzk1qD6qbr809DrqrK
	uKx7AnramjIOP1MIF7tlK1pcDZKesXAttBzBDpOf7rELEivwlk0ksSIHQDGxYod2
	W3svl+3SyRASM5ERKaMPhrP9y3Uqpxumj6DlPwiiDYheEZF3+YJNA5CqrLenu3Xk
	yfzEXpeYxjWfL2veR95UU1ydXUELsR01VEXf9ff/lPQZ4PYroa/FD4Z6Bxo8X2rn
	H6OwTCxwIHujwEY7HjhI9XAp7CyAjpFSoRNvhuFcLw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g9rsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 13:08:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MD6sAg000535;
	Wed, 22 Jul 2026 13:08:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyf3rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 13:08:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MD8ixC32375470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 13:08:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22C4158060;
	Wed, 22 Jul 2026 13:08:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5A535804E;
	Wed, 22 Jul 2026 13:08:40 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 13:08:40 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 22 Jul 2026 15:08:34 +0200
Subject: [PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return
 without MIO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-b4-syscall_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqEMAwAvyI5W6hFqvgVkdJtsxqwKonKivh3y
 x6HgZkbBJlQoCtuYDxJaF0yVGUBYfLLiIpiZjDaWN2YSn1qJZcEP88uJVod4+6+9HPHJjujTwp
 DHU3UrbfBQs5sjNn/F/3wPC9XBe84cgAAAA==
X-Change-ID: 20260721-b4-syscall_mmio_ret_fix_upstream-ec4d2d08a6c6
To: Gerd Bayer <gbayer@linux.ibm.com>, Tobias Schumacher <ts@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Simona Vetter <simona.vetter@ffwll.ch>
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=rHHqMu5/r9TWTyNdrtpxa2sx8j8QayLrEbYOC6bJH5o=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLISDty4bi7twrNFhTVqL0/U3bIukTczuOXcjjYJv3YuX
 eg+ybioo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgIlk7mNkePz3vqpshdHhrfLB
 Rc4Ovh9X1s78OWXJmcnPi1ZLpxxoL2ZkOPZUKvu8uewSB3HTpWr1vt4cv3r8pL4zur/8/kjHcgE
 LJwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfX54FzlFtM17dK
 XAwExH7vaC7ogQoYtNf1s5Zyi1yml22u1FldDQa30u5V4hkejaJPubHKIeKlyP2iDiYDJ7N8tQI
 VkZ8Mdds3tyzowleu7UATdeAS6x6fFc2r52VRLcDD375SQmVqgTBJEPiD14WOw/AXHi/ZIFy0Gr
 xpBTh4VDKDQ8JVlQqAUxwNZJOX2spIULQvzfMlFfSJ1G72yPfG8DhtI313EiVRRy5G/UHD6Q944
 8QmA30wtW4qt/bWgjF20IKRHaOcQ1MxxKtSzrNQUmHGcFKItZi4S2W6aW3xeTpe+ZzOuerDekS1
 9jVNdhIX/nEifGqlcNQb6Ko7b+8eFjqaToRHtfVmM6lDEhZF9AwYtdaS4r70awaR+uzT27bfwHw
 ZJ66mcjFwHldxUHj2xLbcLiewGxBbvAnkR9TPWkLAA2/OwSYSNiopGkx8xg5A3FM/VwQwm6Bw3Q
 Q1EWQ2vdw9V1/Rc2oCQ==
X-Proofpoint-GUID: WNckRbX2C_5RCuMLQtC7ElS9mVW1QPoQ
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60c0de cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rwcjxMHqnQOVHCpN88IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfX1GdvLZlf36QR
 Qi+aYN5Agwe5PaT5yYKIdAHZu6qX7knVKOLO0wd55nzcaCdJWbuLpQF3RQVRrkb/slc5SEWzmFn
 +R+y/F19A3fa9nb9HqPtthjfkIZKCDE=
X-Proofpoint-ORIG-GUID: WNckRbX2C_5RCuMLQtC7ElS9mVW1QPoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220124

On a machine without PCI memory-I/O (MIO) support or when running with
pci=nomio the s390 specific PCI MMIO write syscall checks if the MMIO
cookie is above ZPCI_IOMAP_ADDR_BASE as a sanity check before even
trying to perform the MMIO. If this check fails the return value was
left unchanged and thus 0 from prior operations falsely indicating
success. This could potentially confuse user-space into falsely
believing the MMIO, on a mapping not valid for MMIO was successful.

Fix this by setting the return value to -EFAULT prior to the check
following the same pattern as elsewhere in the same function.

Cc: stable@vger.kernel.org
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Fixes: a67a88b0b8de ("s390/pci: remove races against pte updates")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..f3f79ba78410 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -188,6 +188,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 			goto out_unlock_mmap;
 	}
 
+	ret = -EFAULT;
 	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260721-b4-syscall_mmio_ret_fix_upstream-ec4d2d08a6c6

Best regards,
-- 
Niklas Schnelle

