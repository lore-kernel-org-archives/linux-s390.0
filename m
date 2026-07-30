Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C2450403;
	Thu, 30 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428848; cv=none; b=cL6QvIyahGDNJoWvPBbSjzKM7TIzv1GZ7dPLLSHU5snj5K2cAYrKz/ZvfMqQ2IOd5laSRoGSWqZtqFBgZySeigpPUtUojbLeYGIgVvsZBJ2fWuNPOl4PEjRO14VtaHxWQNrE6/lsSn4JCS9oCC9vhfvNT2q2nf58+Pc1ubPllZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428848; c=relaxed/simple;
	bh=se99soGo//q3Rn9a+ZJJWYrJkGxfzlBrC5FXpNYxnZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP4JBu7Zc2pUSWi/jDGAYP1LEozI3pgAlCbovXimLWikWgNKYAKszoARh7tzPXRtoJtqN57648IPXGQkV+/tc+yxJZhSDeDlDyZ3z6eccGmC6rd/aeKMyaWY58pOKedya6wKRjtqYLn+cjdSdctvDMHTe+oYF+WzjYgs1ewGfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J4JJ2yV8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J4JJ2yV8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFlvT43353717;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WwRBIStAm9rfgGXOM
	SkqsJzhCzVtwv2C6r9vJWbWuxc=; b=J4JJ2yV87v9t81ewMwLbXQXlJzZPwfWDK
	3EPzftwQJP458UoRl67t0IvRjyOfZPQxF/o2Vnw4h7fAmoOtprXHvCOpA1q4aIVU
	lDFF8UPPsUvz4sBbJEsMzd8IqnPl1wDsi08aHFAJPZpqywfBnYMjXoJGhC9gvXgD
	/XJfgdpPn+HYAnXDFPuuVYwtmA/g/N2fFwPqe6amUsFoZQjPejMJOKr9egfbSssh
	kNh6v4GtqziUt7i7FiT543RECAQ8TJtFZnt4/DDrb0yKzmaSrKbheJqYxN2povWb
	6wYHAnQ7d+B9fira1gfsnVZ8wahpGuCQkpLOG3TE9OKv+2v7P26zA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfvkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQUDU011327;
	Thu, 30 Jul 2026 16:27:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhm1vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRGNK20120278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B8520040;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E10620043;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 09/14] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Thu, 30 Jul 2026 18:27:09 +0200
Message-ID: <20260730162714.133327-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXx7UW+U5y8rOG
 Ryc1l31J0xfj4CrPvNgt8FT0w2YDzvTLQ0n3F5LvG45+JKGgjSiv/z7zpAVGg4uuoOP4uMdKUHE
 R8JS1XYQd6/tq9ZK9U+Y0AT/9VL53Eo=
X-Proofpoint-GUID: a-CCLKLwPOXB6w7KIm8PziOh4j6cnZwI
X-Proofpoint-ORIG-GUID: a-CCLKLwPOXB6w7KIm8PziOh4j6cnZwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX8Ch/dfAvp3bJ
 cc788XSv4TewayZJaB+Yttjko7yHZCe4nQRT9I3CvRVbOEsBTwfR59pkWKls8WC1rDrR0nj5uHr
 1Vj/8DX5zPsIJEMUBKiPgZGK7pNl9JSIBPDMmOCkJKbaD+Xibib7afrJlsYgpAOoKrWDyWqnp7w
 rRKU9AmTWkjuDUxA0QqGBJEq5n+3e157+6sSTjrcspIeBiXvHeQ9NZXuoOD99e2lTr8sF5uyhP5
 7dc0l+31IdlQ1NFo20wYJDBKljsS30NgqOo/pzK7xxEAAmzdOK5ZLpvvMOyqzqhxac7vT79JF9d
 Gum4hPzfxYImSeDnRHJwO52VCNU/4oAUUARRPTgBKR+FNMd9WM2l8tvrm9Wmkyi6sT0F+KEdWPj
 xFA0mxUl9l0L2tMipfEzfe3WFm7fEzdiQ8KGdgMWVtst1NSN9q1EODC47FTMk2Jaom7JGs8NClg
 dzHQn41HzKXhHeISYAA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b7b6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=owYgaZMeOewOGYH0y6gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

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
index a234c2ab5fed..7395d7863670 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3799,21 +3799,21 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
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
@@ -3855,10 +3855,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		rc = -ENOMEM;
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
-			goto out_free_sie_block;
+			return -ENOMEM;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
@@ -3866,22 +3865,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
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

