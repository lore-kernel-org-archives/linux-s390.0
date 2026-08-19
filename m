Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20F415F07;
	Wed, 19 Aug 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129476; cv=none; b=N1g5/Oyt3zV6zLSDfT1N6hAAZmpmld/BiAcgwzECm1n9gFkCbosJXyDT2JPva4TcmUgx8Wfgj/MTf4eLuc78Fj7nIdvAI3wJUYAVyYaVipHAcUklV0CLkVSsshUfp6FQnW465cgd6LhImT5U0AWrDGvZupNRNWlA7iyAtmp2oIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129476; c=relaxed/simple;
	bh=Y38cVCTo9HfTxe9w3USJ3JnCx84wfBdyYn5Fbl8Gdmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEOMQHU1PssTuD3jfroklIk2I8/RJCyX9OUZuiv41sqiqwolidjbaN4sIRjS0rldy1sZ9KRT3tohUGtVfrCSos5DmgfVE1ZzvjafDByTqDza8bknTZVm2e3d25tm7Q1+9EkOdpyIpYFH+7RJdVn0ZRwE/o3zJn0bCY4tUAd69jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sVLr6KmD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sVLr6KmD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VjDS2621733;
	Wed, 19 Aug 2026 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r2BdWx
	oh8mgVXdbRQoThpiDQbegCOwnf7Z5RlaRMD1c=; b=sVLr6KmDJLoOygr5EFfzbZ
	z47PDCCRhkISqCXGRgj48neLvYSLnWb2kH/krHV1pVoMNvNb4S7LXn8LIWRgX31h
	N6M5l+pCxwwnQN0bBW0GensqKj8F9Lo6qhbQhKl0WZbKhicdjOpUJ1IxSjFokiVx
	JxTaYK0uvTkDbnFWjFyPxTg7eKHG8B8OhUAsP29Yr01Emj94HlBg7Gu9H3CUfF7Z
	MfHGHlCT+wndBTRQRe9ap7dU/HdIQQ0Hj5Yun8t/2pu/6mH7I6F2j2s7iuAgKiIG
	x7PQLVoUjBuh1nBeRyA9SNAyu/+FQx9yDZ1RKVo67CH9rh80K46mE5GAoIeGlkZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1amfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fJP6028842;
	Wed, 19 Aug 2026 08:51:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw84uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p8oD35586410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF41920040;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F5D62004E;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:56 +0200
Subject: [PATCH 3/7] s390/pci: fix resource leak in zpci MSI setup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-3-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a856e82 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fzb7yXF3lHBN6XHo5OoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d1UHDiz7EFVAo2TqZctM_qQoSv4kv7XV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfXzRbdCMZqAD9b
 LRfNMlGXkDx4rAE+s8ybywHlXCMmfgjftkO+ScteO+Wg6Ky6PBf8QIFrwXZ+aBsGkvy2x5MVzio
 JTjXy7kFuPCWlgJVivmjPU2jS1MI184=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX/xvf/YWKAuz6
 YpXT9WUtba8lj6igh2TaKBOWQmM7X1Guho6Wrnu4onOs/xjvQiwm2tyUluBQtakIlUuD9FCXzdy
 QlT7lri+EQSINxXlFRmH7A4X+y8HDLD1pFZ+wqTo8n6H/Z2iquDGWWJrzL2Oq7x9zf+vECGJUNr
 usNWSO/uIYfmmyhyoDL7GvwDuBH/dOqlC3hz2ngmCgdg++zc0b1z71DRZL6qz1fxsWkY9JbPc9P
 fErWFa+EmZwgZeGB/CK1thuN0j+akoyfZ6DqeTvBt+AGC2kR9KaswWhQODV3+nspebYBI7oS9zc
 8aMMfX0pw9IqCRlOsjpLiKyLdfxpKY1SGUaf8Dka35fDFRllb82TUV0jcHVAoru/qThrHgkGwo8
 9/j+DLhZjSgetFEaMmlV4qlc4zF5RFO/apRZSUKb8cAAJ6eM1kYXpOGmAk1nyT8DTs2RqrdGRMt
 hJ2KDYpcU3IqmBaH6Og==
X-Proofpoint-ORIG-GUID: d1UHDiz7EFVAo2TqZctM_qQoSv4kv7XV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063

If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
ZPCI_NR_DEVICES summary bits (~128 total), reducing system capacity with
each failed device hotplug. In systems with repeated device insertion
failures or under memory pressure, all summary bits can be exhausted,
preventing new PCI devices from being added until reboot.

Add proper error handling to free the zpci_sbv bit and reset zdev->aisb
if the AIBV creation fails.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 94b03d16006b..5e934ac990ac 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -320,8 +320,11 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 		zdev->aibv = airq_iv_create(msi_vecs,
 					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
 					    NULL);
-		if (!zdev->aibv)
+		if (!zdev->aibv) {
+			airq_iv_free_bit(zpci_sbv, *bit);
+			zdev->aisb = -1UL;
 			return -ENOMEM;
+		}
 
 		/* Wire up shortcut pointer */
 		zpci_ibv[*bit] = zdev->aibv;

-- 
2.53.0

