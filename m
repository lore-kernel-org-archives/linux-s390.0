Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E703AAF66;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338992; cv=none; b=uH9m+NGMdAWkeKq2OXJAjAi+bN7zT6eMNURmt7QiX6n+PdlNFbXH1HewShSjz7HBDeZYOhzLcd0unLsz4uwH33h+l+TomPYvfeuPO4BTspuDcaSzgY/zl5ScM3mGAzVZxrwyQHCXNmqBn9ZyBR1jAmDYig/xvaJq++z5u7DhI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338992; c=relaxed/simple;
	bh=ov1CFmPmC5q7v8sAwc5PC/iISzv+IAzWZLBMaiD5WHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhhKG6P7/cuOw6Bz9XHZsZ4XE2P+nCUfC0sNmiaUSflPrsMtE5t2/drioexzGQ8PyNenkrYiZZttZh9ukzpxmC/brcuLFYnGbrOwM936dy96SX6ZJqrG213F2nZh0I8YH+R5P6F3frQBEQy9npSH148OfBUxaYenAkQobhL8UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D2cnRFRO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D2cnRFRO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHZLn2684329;
	Wed, 29 Jul 2026 15:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AoEyVyCeHq53gdCuV
	9EsKvarQIBoFJd6KJbvPdCkArg=; b=D2cnRFROaUInF6ZjehU+icXbO7E7XuDBI
	jwLLCS/VYCTs1tRVX4/4tIj6MvwoMvAhiUznZzsqFacfkBIRWDUU1I0oexbuA6nl
	7h8aUS2RjomRytvHHtR1A5gXh0iLlkqbSgiewy5wTHVMAxs+tRT8XxVc8pCUrHL8
	NACQ3cRvTZoMzwuW3wW7io8HNnuylGlN3aXCvaa7OQbPIWVtfTUt/4fxpArSICw9
	/5PygddTDBjEVYHbXjyYMwHV5Of0dvPx3kqY0E9KPEp73xFvX1mqJBidT3/OyUpg
	MSxJpJPn+MpBSXJ/H+v9ELJKhNtgc3fRAMUDksF2uVWFUbNV1DsSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyckbs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQNOn029238;
	Wed, 29 Jul 2026 15:29:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf6cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTevC30277930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC9A20040;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 071562004D;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 09/13] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Wed, 29 Jul 2026 17:29:34 +0200
Message-ID: <20260729152938.782383-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DPF1VA3iDq5-36aMzwghAxuFdK8pXgYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX9FmYVQxXCu1h
 esQs6c5aXM4OCw8ykeUlhaJDDzxbW9axi+QEsz9sVDqQi4pvJDn4R1ADo6nCAYxoLbAGb/83jXD
 HuQDm3QXmy1wdiDBc1SzPk65nE81QYQV4ETfxC5BNOww4OCrC47mSXDytvkIp4m5958BXbw6E7z
 fk7UiXMkyMPLW3Fdw2ffWLMFDc/XP4r+6yp0CSFAoPm02xSEQWnDMK1R/1Msh56kxn1JV2nB+aE
 5VRKd9uSDzDfVplwAYXdZihmj20/WHoQuR85WmvZwBurv1+hgjaF9H99hxOAnsDG1IV6TEsTip3
 nOsCRW/TByZo49rffFx6ivzsC+VrhGiGwo35w1VV3Dvs95LTJEHEezbhewq47h8a5FITsSloSJ7
 ub7ynWIddZb4g2MW3sq3MYc14yAVzS/UokPyKB63LfwVNx6mGzKcFt1y3z+0I1no2ogBaiiwb6S
 qpmfjbX4P9t8bfRml0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX7n9Ks+KhWX8w
 qwDPpUOQ856m76j0oXOq+uV5nkEdl17VxA3F3058MAb4Wa8+r8nvAMup0tKIIh6nzeNHBQ3ZysR
 dWNOOq1+0EYGy/dkeTRi3elf01VPn5Y=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a1c6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=owYgaZMeOewOGYH0y6gA:9
X-Proofpoint-GUID: DPF1VA3iDq5-36aMzwghAxuFdK8pXgYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

The mmu cache is the first thing that is allocated in
kvm_arch_vcpu_create(), but in case of failure it was not freed.

Fix by freeing the mmu cache in case of failure.

Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
gotos.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/kvm-s390.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a61a2140a60c..fbe9abf365df 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3796,21 +3796,21 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
+DEFINE_FREE(sie_page, struct sie_page *, if (_T) free_page((unsigned long)(_T)))
+
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
-	struct sie_page *sie_page;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	struct sie_page *sie_page __free(sie_page) = NULL;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct sie_page) != 4096);
-	vcpu->arch.mc = kvm_s390_new_mmu_cache();
-	if (!vcpu->arch.mc)
+	mc = kvm_s390_new_mmu_cache();
+	if (!mc)
 		return -ENOMEM;
 	sie_page = (struct sie_page *) get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!sie_page) {
-		kvm_s390_free_mmu_cache(vcpu->arch.mc);
-		vcpu->arch.mc = NULL;
+	if (!sie_page)
 		return -ENOMEM;
-	}
 
 	vcpu->arch.sie_block = &sie_page->sie_block;
 	vcpu->arch.sie_block->itdba = virt_to_phys(&sie_page->itdb);
@@ -3852,10 +3852,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		rc = -ENOMEM;
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
-			goto out_free_sie_block;
+			return -ENOMEM;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
@@ -3863,22 +3862,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
 
 	rc = kvm_s390_vcpu_setup(vcpu);
-	if (rc)
-		goto out_ucontrol_uninit;
+	if (rc) {
+		if (kvm_is_ucontrol(vcpu->kvm)) {
+			scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
+				gmap_remove_child(vcpu->arch.gmap);
+			vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
+		}
+		return rc;
+	}
 
+	vcpu->arch.mc = no_free_ptr(mc);
+	sie_page = NULL;
 	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
 	return 0;
-
-out_ucontrol_uninit:
-	if (kvm_is_ucontrol(vcpu->kvm)) {
-		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
-		gmap_remove_child(vcpu->arch.gmap);
-		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
-		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
-	}
-out_free_sie_block:
-	free_page((unsigned long)(vcpu->arch.sie_block));
-	return rc;
 }
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
-- 
2.55.0

