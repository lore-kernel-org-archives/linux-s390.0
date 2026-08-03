Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8830D3FE;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773379; cv=none; b=i4Ti6z1br4DVjhLdvTAP1BhMtjgrFAJY5CGUebgJJi2il5xDWhDVQFW9R9+CmFZJXIrQZPQiJS0R1o1rh0tTpn+njFjv51/MFvi2AX9dyz8CqnhttAzqFd0Qqx+Xv3qmg3TrG3ksPHJcyD87dbXuMYwSx8QkvvoVxY0Lo3rykbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773379; c=relaxed/simple;
	bh=JppfRANrPF6V3zzMM9WQ5/DSsGvD9liY3GLrD3ShbIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDAMAALg3hjsE9uryqqvPW+O+Ql4rYksmJ0j7IT5uX4Al4JkqbnYzwmTlC2KvK4+jdFsVliWdkT5TLc6jPJU3nsMrdYAi0Sf3DOdtkc8bk5/wrDaDeDMS1RwafBHbZNfiDAeombNq2Cbrz9NOetYYFDwI0hlzeI/IcVc1hoHULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gm2Edcjb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gm2Edcjb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHv1D2206418;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wJ7GxBlN/swocJiJk
	HWMNVJEpHmO8w56Yl2Vka6Mnik=; b=gm2EdcjbhEQf0l04HIyhHxesplpr0iDIY
	vT3RwFXuWajesR7izGmdibKSsLKuUM0f8A3C0XkZVBYA18br7v8NdRCJQUzmdfDW
	4TnEstB10tpuXEvCFGZMa4pCbQcyXf6m1t+3NC09MVzRF2zezGUUNqPZ5dVPpF1I
	9kuxo5v7qBrzAA66nci9S8gmYQaagDnhGiGzRxmaDXNEdIWkpdBemppCm81TZ7uj
	/4JvY7JOtVlDJdGHQ/vutJyWMhnKTHxVVaTODzFxUCjHY+oGQmTqNXHUSrorW9en
	0ic2h0HBOQRjNsCIHtsv7Un+a4RgqzNaSblWkSCYMAfCriOZFhLpA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1he7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuGBY025297;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx5yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9RFi39911748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C07920040;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7176D2004B;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 20/23] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Mon,  3 Aug 2026 18:09:21 +0200
Message-ID: <20260803160924.236807-21-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX0hNllP0NW8UV
 4QiPbTWlyYv5T5P7LY9jQ3L81maer88uTNYgw/AlsTsWzrdPNMl3YR+H99aA6FL1A1FWcUH1AKq
 kqAcLmnLD7Gf12t5o6YuvTOjoZCJK2t8jMsikAup8ffsr4J+KjJgWh9uDztJ7v9HUP+l6XBzoVw
 Mujjj3MDZ3XW/wi1eTjUfDckDMidah2cL4GWRVjELh2NXUcwfLNv3WCQ9JdM/x00fnAbfw40gcv
 fELy2xZ0gzPmLtq7QU3WGqtDFJ8J7MlaqdXHMozmy2jY0R1kxfdAkGIvnoE79/wq1VdSbnhUGYJ
 2PmqAdqkh2ZIYixY8BVqjBmdfoi4NmLHxgVfv1iz1cFY7jgqkbCwOLBD9MOnVy0ABZbRAeYMZEE
 kiJDqUqnT9ry6Gv1tlbSwTnnuiyE1je8qxfCuFMRaG902FDGWMEw1+RGkIDQaBcRwT327xtrPrx
 dO8FkfH2DAYftb9wjSg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70bd3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=owYgaZMeOewOGYH0y6gA:9
X-Proofpoint-GUID: ZWqZAFN3djUNRJPsjylW5MwhnwQq7cKI
X-Proofpoint-ORIG-GUID: ZWqZAFN3djUNRJPsjylW5MwhnwQq7cKI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2Y1UBTZwGICO
 VsnSsj2/q6O+A5YnDgrMIkyfd0A5Caf8wcZ/lWEbdiobUPC+PR+qzJGwqhJxRWn3XXYDrzQ0lZj
 E3RAVgnefUwOTCTFM9T+ZtwWcHUcuGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

The mmu cache is the first thing that is allocated in
kvm_arch_vcpu_create(), but in case of failure it was not freed.

Fix by freeing the mmu cache in case of failure.

Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
gotos.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-11-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2741ca323ede..9b8a35e7dc82 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3800,21 +3800,21 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
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
@@ -3856,10 +3856,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		rc = -ENOMEM;
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
-			goto out_free_sie_block;
+			return -ENOMEM;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
@@ -3867,22 +3866,19 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
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

