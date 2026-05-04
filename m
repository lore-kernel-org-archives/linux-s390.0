Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F013DF000;
	Mon,  4 May 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908044; cv=none; b=Cp0Ef2RtI4iyM/RjiNm1CrHovyxoSJkhGaNXuLkwieF4YDNMYkeCS1vrIgLJ605gCF+vfFoDqo8yXLhJjDZJ3sD21FBModmZ/h2vcY7i2J/zv7WJGO0DFrw8lMcgcSfyb4zz3cXvOwb/eDmAr9H52wUmq1fvB74IvEfr4X9Jk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908044; c=relaxed/simple;
	bh=xLqTxzrdKZ+sKuHN5r0iXIhIZ6ktOCl/bNcfeqV9eVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI4hw3p7AlSh3fyiAZMjPkjyMFdE4EuR71bAGsv/XYUWBAJR8zgFvR7qjpenfWS95sYvYjYfAvGZJYgNiiUn+MrQzCKrWtxKL9ILjG0cg1CtSt8bCh2JQKEcbWC8s+GvDsDlYB1kSyKJZnLG5pJYA1keHMcNWKlMrFmThI1CCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k0jxcT3M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k0jxcT3M"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644FB0OR3254680;
	Mon, 4 May 2026 15:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X/1ZO+oOvQ9ZcuW6b
	9rCN3Dk/wxW+dvrMYD+YVewZIQ=; b=k0jxcT3MqSazaTwS8IC+K++R4nst7uPQy
	s6UnemyGlrISdTt2R7q3DETmNJ3CbPIFXq4pRkvpZfcAQoN1UADZKFknpqsfA3D8
	m1v0dgWGPwHyB6jwmAnLkjPyai7aGdFHE6NIMaEtxxXbkNR09CKul0jlNlKj8FQ+
	q0r0YCcVfadJkkhSAEdWZ5A16BkXNHyQGzqaazzYqJ8CoxZy56QJ68NjSR193IjJ
	RRMAyCxVDTIdI+zN8iCXeIuaWYCXLbcMt/hOWy0fPAt2UEzQognjmerrWMPl8toX
	tHGX5nsniTVr5l3Y+NIbBoEPcVwg4jTZJtR2CigRIzJZ53LUKQa9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w67g2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsSWI008932;
	Mon, 4 May 2026 15:20:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvwt4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FKc5P11600434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:20:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F2D5805C;
	Mon,  4 May 2026 15:20:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5563858054;
	Mon,  4 May 2026 15:20:35 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:20:35 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
        Junrui Luo <moonafterrain@outlook.com>,
        Yuhao Jiang <danisjiang@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, stable@vger.kernel.org
Subject: [GIT PULL 1/2] KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic
Date: Mon,  4 May 2026 17:20:25 +0200
Message-ID: <20260504152026.587578-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504152026.587578-1-borntraeger@linux.ibm.com>
References: <20260504152026.587578-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f8b948 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vNY_8e-zaKlpoDb8ZssA:9
X-Proofpoint-ORIG-GUID: MmCpg8z6Nuh8taZoi7d5Jj06F75rW3FA
X-Proofpoint-GUID: mz09lNmgCh3zLBeGMZiTKI-k-8oqpceV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MiBTYWx0ZWRfXzlHJVz1oJSIt
 iqm/GGZ1MZRxCTy7VsQVwbWs5UUckA4nsDetnvTLUsW2uDWDV/DJwFkNXPEGzy0w2f6XpZO82Ln
 q89+7t51oyRFe3DuM6Ki6K0yYGKzWbhTm+oxWI+VEpLGjs/pzNqtvd0CcWuVq7WgUUqWX9dExkF
 CehIo8S0NiMvi+snFA6HNfBrMHRCCKUOhGlsEjjPKITeYyl59QvYDrJh3Vhwwrbf5m9xt26Ph/c
 0l1blqzc3qYZDLSUb2c73TD8pYtcql/nR97bm4QdLUjMXxYO41+lQ1m0xAAcv4TUD5fYItUeNOe
 Swnmi8l4EL0p3kas3ETdXN0xhg/CjHedgtr2iZzCK8JZSyJaBQ5U61OtpDPHssN1Cidiby4gC7P
 Vt/+ehRtUKCSacx8+4iQe4JcWGYkQqd+m/GBk/nDFPdSgEzbnXJgIlaLgMGhxnMlo5WLhVfBJ6L
 TUUcfx6mIITOtXUpWXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040152

From: Junrui Luo <moonafterrain@outlook.com>

kvm_s390_pci_aif_enable(), kvm_s390_pci_aif_disable(), and
aen_host_forward() index the GAIT by manually multiplying the index
with sizeof(struct zpci_gaite).

Since aift->gait is already a struct zpci_gaite pointer, this
double-scales the offset, accessing element aisb*16 instead of aisb.

This causes out-of-bounds accesses when aisb >= 32 (with
ZPCI_NR_DEVICES=512)

Fix by removing the erroneous sizeof multiplication.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Fixes: 73f91b004321 ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +--
 arch/s390/kvm/pci.c       | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7cb8ce833b62..f48f25c7dc8f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3307,8 +3307,7 @@ static void aen_host_forward(unsigned long si)
 	struct zpci_gaite *gaite;
 	struct kvm *kvm;
 
-	gaite = (struct zpci_gaite *)aift->gait +
-		(si * sizeof(struct zpci_gaite));
+	gaite = aift->gait + si;
 	if (gaite->count == 0)
 		return;
 	if (gaite->aisb != 0)
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 86d93e8dddae..eed45af1a92d 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -290,8 +290,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    phys_to_virt(fib->fmt0.aibv));
 
 	spin_lock_irq(&aift->gait_lock);
-	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
-						   sizeof(struct zpci_gaite));
+	gaite = aift->gait + zdev->aisb;
 
 	/* If assist not requested, host will get all alerts */
 	if (assist)
@@ -357,8 +356,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 	if (zdev->kzdev->fib.fmt0.aibv == 0)
 		goto out;
 	spin_lock_irq(&aift->gait_lock);
-	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
-						   sizeof(struct zpci_gaite));
+	gaite = aift->gait + zdev->aisb;
 	isc = gaite->gisc;
 	gaite->count--;
 	if (gaite->count == 0) {
-- 
2.53.0

