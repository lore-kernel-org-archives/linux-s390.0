Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27239DBCC;
	Tue, 28 Jul 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258448; cv=none; b=iJXDi5DzzrmXZc73lv3hQ20Dh+Z2ol32etortG+jF9pu2XWtAtxdAAIrvqdS5ns/ClLyIYivQtU+wbBQWZBwTKbgWuauWv7myIXRqhH50J9TKmkkCgWvj2CKQ6Vp5xVCUJLqN1sfyqyLb2hL9gEbKLsTtFkTDpoPcdQLe247W9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258448; c=relaxed/simple;
	bh=yzKdIZyWjJYlk27N6mIx7wcJmjW8TTZXiDWoVjykfZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9/FdvpBninFb6yoO8BweYLd0xBC7Es2dyGVKcsBSyNcZBr2DrbotDsItJZ+wgxIHawXKM+EaqA6wFOsm30B3QqQTDNax98+CJqw67SsUmX2N3AYAfIBIJ3zXZYypdMLYebGDHwgfAg30l18WwKUfU/ua16Li+eCnGZ1Dhszi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asCXJiZU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asCXJiZU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElhs21380177;
	Tue, 28 Jul 2026 17:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+U8v2GX1N+HdBGUO9
	szNAEzxuy+gOwr9+NnEkFWqLiU=; b=asCXJiZUvS/IYT2C0r1jMVl3GlYIVv5Ge
	+BGxxHzr1XHCWeIpBQlgml1a9mVG4W2kNhhbSxYgCC/TA+U3lntWpdP8sBDHPi9t
	a85dQ8lLuQzNu9PZx5JMxfdMQCXS4/GGLz3qVST0xMDNp8iIPYmYCZ0FVXDKQ8id
	sSm0IDXwHhp8AI3B/8YLIyYgTOrq4EmNxQMNfZ2YdLDJLGu5dw1WK/jf7apHSJZf
	wXYnw4pN1CpSWltzatAxuqAa9mAPd+oga+fqJiHvgjqhWO7PHWzKe0sjJzPY6Aiv
	950dMSm7cqsPqNsIMkBwdy6OrQbRYnTVPd+ipTqtRyqmT4e+4NV6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj5wb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuFo9018820;
	Tue, 28 Jul 2026 17:07:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk2y0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7Fab27459856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2AD20049;
	Tue, 28 Jul 2026 17:07:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BE820040;
	Tue, 28 Jul 2026 17:07:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 06/13] KVM: s390: Fix overclearing ESCA in case of error
Date: Tue, 28 Jul 2026 19:07:01 +0200
Message-ID: <20260728170708.294400-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX+c4QbDDDc7I0
 Mz/QX2Ot2DPEHrA6g2VePDMSeWAH/DV6gG1PBMezyPRIcc5rKOTIpJvvYdbhjETJwwM3C1FFA+X
 AOkfvwC/lzRu0PMbp1Cf8JzHvqk1zQo=
X-Proofpoint-GUID: Bicg_u1CpK38_eMN4hg2Vr7Ieu94-D0f
X-Proofpoint-ORIG-GUID: Bicg_u1CpK38_eMN4hg2Vr7Ieu94-D0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXxmgI/vbF3SHQ
 u4gIlI3f98EkmjibDKM3n6F67nFd8ThWJSJ8Stre60VX3cBEd9+whx1Se+bg4BtZJ6YO4ECFxoz
 ZdjqtaadPZ9Tr1vIO2LFXMGDLgILCBF03/AAo5Qr52bQArvhGQAVN5gP1sm4trXPvkgDNsXRVgc
 Q6dm7CIWqphC3X8sS+fIXvkujxxM/AHQPEgo4DX9NmuhponXXq6zveKbJnp2KktnXlG3MKPtJyR
 eSTi/8ZPu/8dnCcg+GcZtxVetivLmajJ/A3WgbmxRr7rWzyBH0n8H1szMjM3gxDYwVcoIGhtKEq
 8MecPTG0W1NMiKFM5/Vnp07nnsLVXdvRG7HqV7fu/y7HmMfB4ngzYswELBl0e+pSpLEqTuZcHc2
 EOvTYXVnhdoY0yZV4DGWccVOtCioTZB0nwjW1tdAtEbs3U7Ws5lK2C5zv2C8MuvNLn3tImLDaKL
 SoYTBqRnFO6C/H2n1lA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68e1ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=OniIQR2WiTFW0jQNa14A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the pointer to the ESCA in the state description is
not set.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..2acdff130fa6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 82c6c8632e1b..47eba1664bec 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3461,7 +3461,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

