Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727464AbgCXMuj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:50:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OCmUAA102131
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:50:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuvcg2s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:50:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 24 Mar 2020 12:50:34 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: Use fallthrough;
Date: Tue, 24 Mar 2020 13:50:29 +0100
In-Reply-To: <20200324125030.323689-1-borntraeger@de.ibm.com>
References: <20200324125030.323689-1-borntraeger@de.ibm.com>
Message-Id: <20200324125030.323689-2-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Joe Perches <joe@perches.com>

From: Joe Perches <joe@perches.com>

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/d63c86429f3e5aa806aa3e185c97d213904924a5.1583896348.git.joe@perches.com
[borntrager@de.ibm.com: Fix link to tool and subject]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c   | 23 +++++++++++++----------
 arch/s390/kvm/interrupt.c |  2 +-
 arch/s390/kvm/kvm-s390.c  |  4 ++--
 arch/s390/mm/gmap.c       |  6 +++---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 07d30ffcfa41..47a67a958107 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -505,7 +505,7 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 		switch (prot) {
 		case PROT_TYPE_IEP:
 			tec->b61 = 1;
-			/* FALL THROUGH */
+			fallthrough;
 		case PROT_TYPE_LA:
 			tec->b56 = 1;
 			break;
@@ -514,12 +514,12 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 			break;
 		case PROT_TYPE_ALC:
 			tec->b60 = 1;
-			/* FALL THROUGH */
+			fallthrough;
 		case PROT_TYPE_DAT:
 			tec->b61 = 1;
 			break;
 		}
-		/* FALL THROUGH */
+		fallthrough;
 	case PGM_ASCE_TYPE:
 	case PGM_PAGE_TRANSLATION:
 	case PGM_REGION_FIRST_TRANS:
@@ -534,7 +534,7 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 		tec->addr = gva >> PAGE_SHIFT;
 		tec->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
 		tec->as = psw_bits(vcpu->arch.sie_block->gpsw).as;
-		/* FALL THROUGH */
+		fallthrough;
 	case PGM_ALEN_TRANSLATION:
 	case PGM_ALE_SEQUENCE:
 	case PGM_ASTE_VALIDITY:
@@ -677,7 +677,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 			dat_protection |= rfte.p;
 		ptr = rfte.rto * PAGE_SIZE + vaddr.rsx * 8;
 	}
-		/* fallthrough */
+		fallthrough;
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
@@ -695,7 +695,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 			dat_protection |= rste.p;
 		ptr = rste.rto * PAGE_SIZE + vaddr.rtx * 8;
 	}
-		/* fallthrough */
+		fallthrough;
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
@@ -723,7 +723,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 			dat_protection |= rtte.fc0.p;
 		ptr = rtte.fc0.sto * PAGE_SIZE + vaddr.sx * 8;
 	}
-		/* fallthrough */
+		fallthrough;
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
@@ -1050,7 +1050,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_r2t(sg, saddr, rfte.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+	}
+		fallthrough;
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
@@ -1076,7 +1077,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_r3t(sg, saddr, rste.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+	}
+		fallthrough;
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
@@ -1111,7 +1113,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+	}
+		fallthrough;
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 028167d6eacd..8191106bf7b9 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -886,7 +886,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	case PGM_PRIMARY_AUTHORITY:
 	case PGM_SECONDARY_AUTHORITY:
 		nullifying = true;
-		/* fall through */
+		fallthrough;
 	case PGM_SPACE_SWITCH:
 		rc = put_guest_lc(vcpu, pgm_info.trans_exc_code,
 				  (u64 *)__LC_TRANS_EXC_CODE);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6b1842a9feed..d590f32f13d3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3752,7 +3752,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		rc = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
 		break;
 	case KVM_MP_STATE_CHECK_STOP:
-		/* fall through - CHECK_STOP and LOAD are not supported yet */
+		fallthrough;	/* CHECK_STOP and LOAD are not supported yet */
 	default:
 		rc = -ENXIO;
 	}
@@ -4985,7 +4985,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 					old->npages * PAGE_SIZE);
 		if (rc)
 			break;
-		/* FALLTHROUGH */
+		fallthrough;
 	case KVM_MR_CREATE:
 		rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
 				      mem->guest_phys_addr, mem->memory_size);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 27926a06df32..03c899849c38 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -804,7 +804,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* Fallthrough */
+		fallthrough;
 	case _ASCE_TYPE_REGION2:
 		table += (gaddr & _REGION2_INDEX) >> _REGION2_SHIFT;
 		if (level == 3)
@@ -812,7 +812,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* Fallthrough */
+		fallthrough;
 	case _ASCE_TYPE_REGION3:
 		table += (gaddr & _REGION3_INDEX) >> _REGION3_SHIFT;
 		if (level == 2)
@@ -820,7 +820,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* Fallthrough */
+		fallthrough;
 	case _ASCE_TYPE_SEGMENT:
 		table += (gaddr & _SEGMENT_INDEX) >> _SEGMENT_SHIFT;
 		if (level == 1)
-- 
2.24.1
