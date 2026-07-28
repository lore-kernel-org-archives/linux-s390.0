Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DE39CCF3;
	Tue, 28 Jul 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258448; cv=none; b=ur2enm6ASfhpifoh3PkUKhIBuudb5139tDWYepQ9SBv3EBaAvOrGe9rHkjf3Ql5EK9XqVo650i5MCt6oaGfuUE2tOLjlGpFx5lYM0wWrO/Dc8BFZBO3taDt0EfuHNNGOLPsZxlEtjtcyr8Xqa0Ar9Ya+NzH7pEKRJzl2ZczwNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258448; c=relaxed/simple;
	bh=zho/jIjZkeV4dgiBK9swTQJdlFYHNUMAyHnt9MSMn1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChZiGTRedZeobi8TNxdg4tqV8gHsCrDq3bNHbiS1lAyAy/ZhE7LNBzHQulIdGRDid/rTg+vEj4BBUmbBsAi/X2M6rnu5xA1t8Apaql5NcosGHmk87UqQpYqXzxTKgH5CXp2hDqOGT3/XDfzbEU6u+77ssEVrxajHqRIecPb63lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIrCvIvi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIrCvIvi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEmPWk1492463;
	Tue, 28 Jul 2026 17:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NJg8B969fB6VOjwl5
	SL6EY3xqV+/PAP5qRtuuS6VMw4=; b=YIrCvIvidKDr8m+bvB6B3mkqxBso6AmUh
	9o9QF2wuL3BxvzKeESOiMVnFmcFgmdH38ccXq6YTzrfhf2WERhiBLs/kcnnRkK6Z
	hqNz8kwzUj2DGSQifxMMQrW6zyHUNVaBJz7Zs4Fm0yoztl9RDiPEuBrSWemXXYM7
	FBQhDn8vNc3hF9Ou4uMLYXfHWwvF0FteBIuWtcDvlGvTN+/a40hDgId9JDCpKu82
	SlcXIIuDj6TntvRt9nY2559I8SMdsY8SDZlut/A6WgeBK5jvpIbpPgTVL0QhLycA
	jCkYema/6BN5vzFxHU+HGxQPy1a+C1jSYog2eYTVDLo7a+pzaKNRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xphrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuEMS018803;
	Tue, 28 Jul 2026 17:07:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk2y0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7HC451970460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4048220049;
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BF4F20040;
	Tue, 28 Jul 2026 17:07:16 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 08/13] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Tue, 28 Jul 2026 19:07:03 +0200
Message-ID: <20260728170708.294400-9-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: rdbXVX2D3R4zgCiq7TwYn4QYGz74c_4r
X-Proofpoint-ORIG-GUID: rdbXVX2D3R4zgCiq7TwYn4QYGz74c_4r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX+bRQQ88SKhUM
 M7EC5GC7RiZtCCdZ6u4o6w5j+FA+cxuKwxGVF8gXQfKBO5xMjjlxB8kKHVkPLQchq9P0rIaBXB5
 onjOjUtVoo5UXh9UtaEGuTzIn8rSjR4=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e1cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=owYgaZMeOewOGYH0y6gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX6trLqphNfpFd
 aK0huHop0XbYKzxzQ0+o80f9QP1b9fbqaOy4VR3yFnxVwAO1k1YlD8+4S5hYOunB/PH0zjNsaiZ
 pFzOrmmhcnQlssZ/8L8dqEs6LE1XgYZMhymtaSd4VNlsELZdzR3SiOAJgqLFZZb+lk2GVyj5Vd1
 zPVUnDnplsvmSNdEBEB3G6d5rfQSGGZl+JvsHXfmZ2Bx5zTPy4R6hkNLqTLD9llEFPmEFelsj5E
 yvaJt/wapYVhs34FXgMq1e3b2y5QMGZkSSZTsqkLLz6yIjhLkkeaxvwnrZH1fLw3O1ffdfwgKtH
 X0s1ztXoBqNNJvq6wfWt+PT6/zh2IhksIFE9E0tHXrN0MAm+uZGlKu1NTl3Re/93gjBYWRWTxGb
 neI6b742isyR6FoXkdQ6LdzW8gBgrgSACmCfIGO9wgwB3JeUVk4jDxdW6xwnnEdF5E5owyxkaLn
 LQby8A+93BwZybI4Esg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

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
index 47eba1664bec..776dfa0ef970 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3795,21 +3795,21 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
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
@@ -3851,10 +3851,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		rc = -ENOMEM;
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
-			goto out_free_sie_block;
+			return -ENOMEM;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
@@ -3862,22 +3861,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
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

