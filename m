Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931C4F7978;
	Wed, 22 Jul 2026 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739992; cv=none; b=CbcO0NiDvnv1+EQhd0EkOWE9MKSsx3ShnXet6c4tc48jI7PqgMVi4UvB9qXvOhxwIAxzqOLtdVVlvKje1lrD1phqYdIT4Oq13COb1kklSOlg6leoc24xsb3MFIwdPoiYMY9Eus8D15q5jqmOYX+PXcR9JG1AWgvPBSbCN13c69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739992; c=relaxed/simple;
	bh=qkCafmPF2uJNXiBck6SyJPJZ6afWQe6vFPIfcRPlels=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHf64w8zGx6GXsL0nxEiHjX06swos+xDv5UsSZyizEMP2SJZTrYxvtsxcRZs+DZKGWMl3lxS1tjsmw5xIPeYUn1Bb1jk+UjPjEkIzUe5ZPaC9wT9wlmKT3yl9+XkRXhQGB6hkWYrc1JxagiQfyhM8ELr40XENPnWfDNkIOdjAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnAILQHu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnAILQHu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFflPA382884;
	Wed, 22 Jul 2026 17:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1TkNdN61S103MDsHz
	XNwgWKbs37UhH4GKScY6/TtHK0=; b=cnAILQHupwbYxgBXpomEEXKuhHOo75zyX
	493XHsQfBlKig/nCY5FGULNYdns9wkV4D4+Kx79/35/wfIQn2MwWlS6qXDcnTHIL
	mcEN6aNe9n+jjEsbk9hkFwhy/TDy7bLsjQEaZGo3hU0unXPUOroAaxPPiNVbADXC
	4Vk26Jw1MSbeNi6Mb94aWTes2YrQf5aePNgyLHk2RDIoABpJcb9rMFfSTueiiNh7
	/DHkvaF8jsS/fuxzHdpoY8Ml3oKeJunvD9RR/nU3Mhro8QK2rfJ+tsZSHataTDNS
	Zi5shZDGjqQwec7drUNTiXNuRgoqVG3MVFamb84iYCH8V3kyvYvIg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7913cwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4dGt031833;
	Wed, 22 Jul 2026 17:06:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyg1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6RBw50266588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06AD58059;
	Wed, 22 Jul 2026 17:06:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3CF58043;
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 4/6] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Wed, 22 Jul 2026 10:06:19 -0700
Message-ID: <20260722170621.1686-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BOz2NSB0H0b24eko_FgPh8n5d4-jpBpu
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a60f896 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfXxjS6yyTIo3ho
 NsvOFLI8S37G75kLT0m04rY96szQ/lBBfKShgzU2aY9vEiGCulhfewoJTDMrvSKJ+TceQ8jFuiX
 I+GG/V7B3SE7LEEkldh8ep4KkVyWJ2Q=
X-Proofpoint-GUID: BOz2NSB0H0b24eko_FgPh8n5d4-jpBpu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX/6duXNlcrC/J
 rGFL0LA1CyUZx8bdrNiTi+2DIV9TReAnK567hLey4BKqgSV3vm3+Nfg4Z8PJFEOpmYxu3sjDX4E
 Ch4fTKwmPiu27WwEah2TNhNrAu4enHfwh9uU0C5jXGUyUX49mF6fIlaWtoRNithgzmMMSkeKpxX
 NOYyPBeFSBb6ZqM0MM/aoOPN0DxQL/7HVhJ0KgKuYbNhrY3Pz6UEDENon2TCGx8KfeTXnEoW6/0
 nvKH9h+HYd2itp8aFBdnK4VsrkkJRb+RLuGCa3Slz98MMc63Vx1+E9Exu1wsxC/Brj+ZRHmIyqM
 aWjYVzD1aHZm8FYFG4W6ELo6cW5uCGNVgo41haaitzXxoKovqMqZMHnMwyn+6n8YFuwf+HlXudH
 99AFUBlE6bCdxYVbrB2gsncw/qrcmZjQys8ggFFqY8ThNgJ3l4r3YQj6LTzpXeOvVBe5UTsL2GB
 iy4uM5HxAY7QxwFkXgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220164

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously
allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 33abc15aa685..231a4236fc3c 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -314,6 +314,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -350,6 +355,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.43.0

